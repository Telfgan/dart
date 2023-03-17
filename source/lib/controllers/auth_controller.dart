import 'package:api_project/utils/app_utilits.dart';
import 'package:conduit/conduit.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

import '../models/user.dart';

class Tokens {
  Tokens(this.accessToken, this.refreshToken);
  String accessToken;
  String refreshToken;
}

//Контроллер для аутентификации, запрашивает токены и рефрешит их
class AuthBaseController extends ResourceController {
  AuthBaseController(this.managedContext);
  final ManagedContext managedContext;
  String get jwtSecretKey => AppUtils.jwtSecretKey;

  Future<Tokens> updateToken(int userId, ManagedContext transaction) async {
    final refreshToken = getRefreshToken(jwtSecretKey, userId);

    final qUpdateTokens = Query<User>(transaction)
      ..values.refreshToken = refreshToken
      ..where((x) => x.id).equalTo(userId);

    await qUpdateTokens.updateOne();

    return Tokens(getAccessToken(jwtSecretKey, userId), refreshToken);
  }

  String getAccessToken(String secretKey, int userId) {
    final accessClaimSet =
        JwtClaim(maxAge: const Duration(hours: 1), otherClaims: {'id': userId});
    return issueJwtHS256(accessClaimSet, secretKey);
  }

  String getRefreshToken(String secretKey, int userId) {
    final refreshClaimSet =
        JwtClaim(maxAge: const Duration(days: 60), otherClaims: {'id': userId});
    return issueJwtHS256(refreshClaimSet, secretKey);
  }
}
