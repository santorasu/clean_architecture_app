part of 'route_import_part.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case RouteName.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case RouteName.userListScreen:
        return MaterialPageRoute(builder: (_) => const UserListScreen());

      default:
        return unDefineRoute();
    }
  }

  static Route<dynamic> unDefineRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: Text(AppString.noRoute)),
        body: Center(child: Text(AppString.noRoute)),
      ),
    );
  }
}
