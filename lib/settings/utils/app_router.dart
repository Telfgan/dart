import 'package:flutter_front/settings/utils/router_utils.dart';
import 'package:flutter_front/pages/home_page.dart';
import 'package:flutter_front/pages/profile_page.dart';
import 'package:flutter_front/pages/profile_edit.dart';
import 'package:flutter_front/pages/screen/screen_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_front/global/app_state_provider.dart';

class AppRouter {
  AppRouter({
    required this.appStateProvider,
    required this.prefs,
  });

  AppStateProvider appStateProvider;
  late SharedPreferences prefs;
  get router => _router;

  late final _router = GoRouter(
      refreshListenable: appStateProvider,
      initialLocation: "/",
      routes: [
        GoRoute(
            path: APP_PAGE.auth.routePath,
            name: APP_PAGE.auth.routeName,
            builder: (context, state) => const AuthScreen()),
        GoRoute(
          path: APP_PAGE.home.routePath,
          name: APP_PAGE.home.routeName,
          builder: (context, state) =>
              HomePage(token: state.queryParams['token']!),
        ),
        GoRoute(
            path: APP_PAGE.profile.routePath,
            name: APP_PAGE.profile.routeName,
            builder: (context, state) =>
                ProfilePage(token: state.queryParams['token']!)),
        GoRoute(
            path: APP_PAGE.profile_edit.routePath,
            name: APP_PAGE.profile_edit.routeName,
            builder: (context, state) =>
                ProfilePageEdit(token: state.queryParams['token']!)),
      ],
      redirect: (context, state) {
        final String onboardPath =
            state.namedLocation(APP_PAGE.onboard.routeName);

        bool isOnboarding = state.subloc == onboardPath;

        if (state.subloc == "/") {
          return null;
        }

        bool toOnboard = prefs.containsKey('onBoardCount') ? false : true;

        if (toOnboard) {
          return isOnboarding ? null : onboardPath;
        }
        return null;
      });
}
