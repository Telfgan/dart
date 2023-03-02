import 'package:conduit/conduit.dart';

import '../models/user.dart';
import '../utils/app_responce.dart';
import 'auth_controller.dart';

//Контроллер, отвечающий за регистрацию, работает посредством получения запроса и токенов
class AuthRegController extends AuthBaseController {
  AuthRegController(super.managedContext);

  @Operation.post()
  Future<Response> register(@Bind.body() RegisterRequest newUser) async {
    if (newUser.login == null ||
        newUser.password == null ||
        newUser.name == null) {
      return AppResponse.badRequest(
          title: "Fields 'login', 'password', 'name' are requerd");
    }

    final salt = generateRandomSalt();
    final passwordHash = generatePasswordHash(newUser.password!, salt);

    late final Tokens tokens;
    late final User user;
    try {
      await managedContext.transaction((transaction) async {
        final qCreateUser = Query<User>(transaction)
          ..values.login = newUser.login!
          ..values.name = newUser.name!
          ..values.passwordSalt = salt
          ..values.passwordHash = passwordHash
          ..values.refreshToken = "";

        user = await qCreateUser.insert();

        tokens = await updateToken(user.id!, transaction);
      });

      final response = {
        "id": user.id,
        "login": user.login,
        "name": user.name,
        "refreshToken": tokens.refreshToken,
        "accessToken": tokens.accessToken
      };

      return Response.ok(response);
    } on QueryException catch (e) {
      return AppResponse.serverError(e, message: e.message);
    }
  }
}
