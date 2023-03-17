import 'package:api_project/check_auth_controller.dart';
import 'package:api_project/controllers/login_controller.dart';
import 'package:api_project/controllers/refresh_auth.controller.dart';
import 'package:api_project/controllers/registration_controller.dart';
import 'package:api_project/operations_controller.dart';
import 'package:yaml/yaml.dart';

import 'appiapp.dart';
import 'models/note.dart';
import 'user_controller.dart';

class ApiChannel extends ApplicationChannel {
  late final ManagedContext managedContext;

  @override
  Future prepare() async {
    final persistentStore = _initDatabase();

    managedContext = ManagedContext(
        ManagedDataModel.fromCurrentMirrorSystem(), persistentStore);

    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    return super.prepare();
  }

  PersistentStore _initDatabase() {
    print(Directory.current);

    final configFile = File('database.yaml');
    dynamic yamlConfig;
    try {
      final yamlString = configFile.readAsStringSync();
      yamlConfig = loadYaml(yamlString);
    } catch (ex) {}

    final fail = (String msg) =>
        throw Exception("The DB configuration was skipped. ($msg)");
    final getYamlKey =
        (String key) => yamlConfig != null ? yamlConfig[key].toString() : null;

    final username = Platform.environment['DB_USERNAME'] ??
        getYamlKey('username') ??
        fail("DB_USERNAME | username");
    final password = Platform.environment['DB_PASSWORD'] ??
        getYamlKey('password') ??
        fail("DB_PASSWORD | password");
    final host =
        Platform.environment['DB_HOST'] ?? getYamlKey('host') ?? '127.0.0.1';
    final port = int.parse(
        Platform.environment['DB_PORT'] ?? getYamlKey('port') ?? '5432');
    final databaseName = Platform.environment['DB_NAME'] ??
        getYamlKey('databaseName') ??
        fail("DB_NAME | databaseName");

    return PostgreSQLPersistentStore(
        username, password, host, port, databaseName);
  }

  @override
  Controller get entryPoint {
    final router = Router();

    router
      ..route('login').link(() => AuthLoginController(managedContext))
      ..route('register').link(() => AuthRegController(managedContext))
      ..route('refresh-token').link(() => AuthRefreshController(managedContext))
      ..route('user')
          .link(CheckAuthController.new)!
          .link(() => UsersController(managedContext))
      ..route('notes/[:id]')
          .link(CheckAuthController.new)!
          .link(() => NotesController(managedContext))
      ..route('notes-history').link(CheckAuthController.new)!.linkFunction(
          (request) async => Response.ok(
              await Query<NoteHistoryRecord>(managedContext).fetch()));

    return router;
  }
}
