import 'package:conduit/conduit.dart';

import '../models/user.dart';
import '../utils/app_responce.dart';
import 'auth_controller.dart';

//Контроллер, отвечающий за логин, отвечает посредством получения запросов
class AuthLoginController extends AuthBaseController {
  AuthLoginController(super.managedContext);

  @Operation.post()
  Future<Response> login(@Bind.body() LoginRequest auth) async {
    if (auth.login == null || auth.password == null) {
      return AppResponse.badRequest(
          title: 'Fields "login" and "password" are required');
    }

    try {
      final qFindUser = Query<User>(managedContext)
        ..where((x) => x.login).equalTo(auth.login!);

      final user = await qFindUser.fetchOne();

      if (user == null) {
        return AppResponse.badRequest(title: 'Invalid login');
      }

      final requestHashPassword =
          generatePasswordHash(auth.password ?? '', user.passwordSalt!);

      if (requestHashPassword == user.passwordHash) {
        final tokens = await updateToken(user.id!, managedContext);

        return Response.ok({
          "id": user.id,
          "login": user.login,
          "name": user.name,
          "refreshToken": tokens.refreshToken,
          "accessToken": tokens.accessToken
        });
      } else {
        throw AppResponse.badRequest(title: 'Invalid password');
      }
    } on QueryException catch (e) {
      return AppResponse.serverError(e, message: e.message);
    }
  }
}
