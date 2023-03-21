import 'dart:async';

import '../models/category.dart';
import '../interceptor/InterceptorAuth.dart';
import 'package:dio/dio.dart';
import 'package:flutter_front/models/ModelNotif.dart';
import '../models/post.dart';
import '../models/user.dart';

class Dio_Client {
  final Dio _dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 3500),
      receiveTimeout: const Duration(seconds: 3500),
      sendTimeout: const Duration(seconds: 3500)));

  void dioInterceptorInitialize() {
    _dio.interceptors.add(AuthInterceptor());
  }

  final _baseUrl = "http://localhost:5781/";

  Future<User?> getProfile({required String token}) async {
    User? encodedUser;
    try {
      _dio.options.headers['Authorization'] = 'Bearer ${token}';

      Response rawResponse = await _dio.get(_baseUrl + 'user');

      print('User info: ${rawResponse.data}');

      ModelNotif? modelResponse = ModelNotif.fromJson(rawResponse.data);
      encodedUser = User.fromJson(modelResponse.data);
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }

    return encodedUser;
  }

  Future<String?> deleteNote({required String token, required int id}) async {
    ModelNotif? modelResponse;
    try {
      _dio.options.headers['Authorization'] = 'Bearer ${token}';

      Response rawResponse = await _dio.delete(_baseUrl + 'post/${id}');

      modelResponse = ModelNotif.fromJson(rawResponse.data);

      return modelResponse.message!;
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
        ;

        return modelResponse?.error!;
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
        return e.message;
      }
    }
  }

  Future<List<Category>?> getCategories({required String token}) async {
    try {
      _dio.options.headers['Authorization'] = 'Bearer ${token}';

      Response rawResponse = await _dio.get(_baseUrl + 'category');

      print('Raw Categories: ${rawResponse.data}');

      List<Category> myCategories = (rawResponse.data as List).map((e) {
        return Category.fromJson(e);
      }).toList();

      return myCategories;
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
  }

  Future<List<Post>?> getNotes({required String token}) async {
    List<Post>? myPosts;
    try {
      _dio.options.headers['Authorization'] = 'Bearer ${token}';

      Response rawResponse = await _dio.get(_baseUrl + 'post');

      print('Posts: ${rawResponse.data}');

      List<Post> myPosts = (rawResponse.data as List).map((e) {
        return Post.fromJson(e);
      }).toList();

      return myPosts;
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
  }

  Future<Post?> getNote({required String token, required int id}) async {
    Post? encodedNote;
    try {
      _dio.options.headers['Authorization'] = 'Bearer ${token}';

      Response rawResponse = await _dio.get(_baseUrl + 'post/${id}');

      print('User info: ${rawResponse.data}');

      ModelNotif? modelResponse = ModelNotif.fromJson(rawResponse.data);

      encodedNote = Post.fromJson(modelResponse.data);

      return encodedNote;
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
  }

  Future<String>? createNote(
      {required String token,
      required String name,
      required String content,
      required int categoryId}) async {
    ModelNotif modelResponse;
    try {
      _dio.options.headers['Authorization'] = 'Bearer ${token}';

      Response createNoteResponse = await _dio.post(_baseUrl + 'post',
          data: {
            'name': name,
            'content': content,
            'category': {'id': categoryId}
          },
          options: Options(receiveDataWhenStatusError: true));

      modelResponse = ModelNotif.fromJson(createNoteResponse.data);
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');

        return "Information: ${ModelNotif.fromJson(e.response!.data).message}";
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
        return "Information: ${e.message}";
      }
    }

    return "Information: ${modelResponse.message}";
  }

  Future<String?> updateNote(
      {required String token,
      required int id,
      required String content,
      required String name}) async {
    ModelNotif modelResponse;
    try {
      _dio.options.headers['Authorization'] = 'Bearer ${token}';

      Response updateNoteResponse = await _dio.put(_baseUrl + 'post/${id}',
          data: {'name': name, 'content': content},
          options: Options(receiveDataWhenStatusError: true));

      modelResponse = ModelNotif.fromJson(updateNoteResponse.data);
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');

        return "Information: ${ModelNotif.fromJson(e.response!.data).message}";
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
        return "Information: ${e.message}";
      }
    }

    return "Information: ${modelResponse.message}";
  }

  Future<String?> updateProfile(
      {required String token,
      required User user,
      required String newPassword,
      required String oldPassword}) async {
    User? encodedUser;

    ModelNotif? modelProfileResponse;
    ModelNotif? modelPasswordResponse;

    try {
      _dio.options.headers['Authorization'] = 'Bearer ${token}';

      Response updateProfileResponse = await _dio.post(_baseUrl + 'user',
          data: user.toJson(),
          options: Options(receiveDataWhenStatusError: true));

      modelProfileResponse = ModelNotif.fromJson(updateProfileResponse.data);
      encodedUser = User.fromJson(modelProfileResponse.data);

      Response updatePasswordResponse = await _dio.put(_baseUrl + 'user',
          options: Options(receiveDataWhenStatusError: true),
          queryParameters: {
            'newPassword': newPassword,
            'oldPassword': oldPassword,
          });

      modelPasswordResponse = ModelNotif.fromJson(updatePasswordResponse.data);
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');

        return "Information: ${ModelNotif.fromJson(e.response!.data).message}";
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
        return "Information: ${e.message}";
      }
    }

    return "Information: ${modelProfileResponse.message}, ${modelPasswordResponse.data}";
  }

  Future<ModelNotif?> authUser({required User user}) async {
    ModelNotif? retrievedUser;
    User? encodedUser;
    Response? response;

    try {
      response = await _dio.post(_baseUrl + 'token',
          data: user.toJson(),
          options: Options(receiveDataWhenStatusError: true));
      retrievedUser = ModelNotif.fromJson(response.data);

      encodedUser = User.fromJson(retrievedUser.data);
      _dio.options.headers['Authorization'] =
          'Bearer ${encodedUser.accessToken}';

      print('[Auth] : ${response.data}');

      return retrievedUser;
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');

        return ModelNotif.fromJson(e.response!.data);
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
        return null;
      }
    }
  }
}
