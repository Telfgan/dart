enum APP_PAGE { auth, register, home, profile, profile_edit, onboard }

extension AppPageExtension on APP_PAGE {
  // create path for routes
  String get routePath {
    switch (this) {
      case APP_PAGE.auth:
        return "/";

      case APP_PAGE.register:
        return "/register";

      case APP_PAGE.home:
        return "/home";

      case APP_PAGE.profile:
        return "/profile";

      case APP_PAGE.profile_edit:
        return "/profileedit";

      case APP_PAGE.onboard:
        return "/onboard";

      default:
        return "/";
    }
  }

// for named routes
  String get routeName {
    switch (this) {
      case APP_PAGE.home:
        return "home";

      case APP_PAGE.auth:
        return "auth";

      case APP_PAGE.register:
        return "register";

      case APP_PAGE.profile:
        return "profile";

      case APP_PAGE.profile_edit:
        return "profileedit";

      case APP_PAGE.onboard:
        return "profile";

      default:
        return "auth";
    }
  }

// for page titles

  String get routePageTitle {
    switch (this) {
      case APP_PAGE.home:
        return "Home page";

      case APP_PAGE.auth:
        return "Register/SignIn";

      case APP_PAGE.profile:
        return "Profile";

      case APP_PAGE.profile_edit:
        return "Profile Edit";

      case APP_PAGE.onboard:
        return "On Board";

      default:
        return "Auth";
    }
  }
}
