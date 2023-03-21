import 'package:flutter_front/theme/app_theme.dart';
import 'package:flutter_front/pages/home_page.dart';
import 'package:flutter_front/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_front/global/app_state_provider.dart';
import 'package:flutter_front/settings/utils/router_utils.dart';

import '../settings/utils/app_router.dart';
import '../theme/app_theme.dart';

Future<void> main() async {
//  concrete binding for applications based on the Widgets framework
  WidgetsFlutterBinding.ensureInitialized();
// Instantiate shared pref
  SharedPreferences prefs = await SharedPreferences.getInstance();

// Pass prefs as value in MyApp
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatefulWidget {
// Declared fields prefs which we will pass to the router class
  SharedPreferences prefs;
  MyApp({required this.prefs, Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppStateProvider()),
        // Remove previous Provider call and create new proxyprovider that depends on AppStateProvider
        ProxyProvider<AppStateProvider, AppRouter>(
            update: (context, appStateProvider, _) => AppRouter(
                appStateProvider: appStateProvider, prefs: widget.prefs))
      ],
      child: Builder(
        builder: ((context) {
          final GoRouter router = Provider.of<AppRouter>(context).router;

          return MaterialApp.router(
            routeInformationParser: router.routeInformationParser,
            theme: mainTheme,
            routerDelegate: router.routerDelegate,
          );
        }),
      ),
    );
  }
}
