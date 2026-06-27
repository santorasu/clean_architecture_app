
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/resource/theme_manager.dart';
import 'core/route/route_import_part.dart';
import 'core/route/route_name.dart';

  void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp(
        navigatorKey: AppRouter.navigatorKey,
        title: 'User List',
        debugShowCheckedModeBanner: false,
        theme: getApplicationTheme(),
        darkTheme: getApplicationTheme(),
        themeMode: ThemeMode.dark,
        onGenerateRoute: AppRouter.getRoute,
        initialRoute: RouteName.splashScreen,
      ),
    );
  }
}
