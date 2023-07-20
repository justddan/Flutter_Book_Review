import 'package:bookreview/src/init/page/init_page.dart';
import 'package:bookreview/src/splash/page/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late GoRouter router;

  @override
  void initState() {
    super.initState();
    router = GoRouter(
      routes: [
        GoRoute(
          path: "/",
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          path: "/init",
          builder: (context, state) => const InitPage(),
        ),
      ],
      initialLocation: "/",
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Color(0xff1C1C1C),
            titleTextStyle: TextStyle(
              color: Colors.white,
            )),
        scaffoldBackgroundColor: const Color(0xff1C1C1C),
      ),
    );
  }
}
