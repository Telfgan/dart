// ignore_for_file: unused_element

import 'package:conduit/conduit.dart';
import 'package:conduit_common/src/openapi/documentable.dart';
import 'package:conduit_open_api/src/v3/schema.dart';

import 'note.dart';

class User extends ManagedObject<_User> implements _User {}

@Table(name: "users", useSnakeCaseColumnName: true)
class _User {
  _User(
      {this.id = 0,
      this.login = "",
      this.passwordHash = "",
      this.passwordSalt = "",
      this.name = "",
      this.refreshToken});

  @Column(primaryKey: true)
  int? id;
  @Column(unique: true)
  String? login;
  @Column()
  String? passwordHash;
  @Column()
  String? passwordSalt;
  @Column()
  String? name;
  @Column(nullable: true)
  String? refreshToken;

  ManagedSet<Note>? notes;
}

class LoginRequest implements Serializable {
  LoginRequest({this.login, this.password});

  String? login;
  String? password;

  @override
  Map<String, dynamic>? asMap() => {"login": login, "password": password};

  @override
  APISchemaObject documentSchema(APIDocumentContext context) =>
      throw UnimplementedError();
  @override
  void read(Map<String, dynamic> object,
          {Iterable<String>? accept,
          Iterable<String>? ignore,
          Iterable<String>? reject,
          Iterable<String>? require}) =>
      readFromMap(object);

  @override
  void readFromMap(Map<String, dynamic> object) {
    login = object["login"] as String;
    password = object["password"] as String;
  }
}

class RegisterRequest implements Serializable {
  String? login;
  String? password;
  String? name;

  @override
  Map<String, dynamic>? asMap() =>
      {"login": login, "password": password, "name": name};

  @override
  APISchemaObject documentSchema(APIDocumentContext context) =>
      throw UnimplementedError();
  @override
  void read(Map<String, dynamic> object,
          {Iterable<String>? accept,
          Iterable<String>? ignore,
          Iterable<String>? reject,
          Iterable<String>? require}) =>
      readFromMap(object);

  @override
  void readFromMap(Map<String, dynamic> object) {
    login = object["login"] as String?;
    password = object["password"] as String?;
    name = object["name"] as String?;
  }
}

class EditProfileRequest implements Serializable {
  String? password;
  String? name;

  @override
  Map<String, dynamic>? asMap() => {"password": password, "name": name};

  @override
  APISchemaObject documentSchema(APIDocumentContext context) =>
      throw UnimplementedError();
  @override
  void read(Map<String, dynamic> object,
          {Iterable<String>? accept,
          Iterable<String>? ignore,
          Iterable<String>? reject,
          Iterable<String>? require}) =>
      readFromMap(object);

  @override
  void readFromMap(Map<String, dynamic> object) {
    password = object["password"] as String?;
    name = object["name"] as String?;
  }
}
