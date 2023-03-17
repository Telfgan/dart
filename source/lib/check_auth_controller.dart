import 'dart:async';
import 'dart:io';
import 'package:api_project/utils/app_responce.dart';
import 'package:api_project/utils/app_utilits.dart';
import 'package:conduit/conduit.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

//Класс, отвечающий за проверку на авторизацию
class CheckAuthController extends Controller {
  @override
  FutureOr<RequestOrResponse?> handle(Request request) {
    try {
      final header = request.raw.headers.value(HttpHeaders.authorizationHeader);
      if (header == null) return Response.unauthorized();

      final token = const AuthorizationBearerParser().parse(header);

      final jwtClaim =
          verifyJwtHS256Signature(token ?? '', AppUtils.jwtSecretKey);
      jwtClaim.validate();

      request.attachments["userId"] = int.parse(jwtClaim["id"].toString());

      return request;
    } on JwtException catch (e) {
      return AppResponse.unauthorized(
          title: 'Invalid token', details: e.message);
    }
  }
}
