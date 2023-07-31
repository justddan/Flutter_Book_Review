import 'package:bookreview/src/common/cubit/authentication_cubit.dart';
import 'package:bookreview/src/login/page/login_page.dart';
import 'package:bookreview/src/root/page/root_page.dart';
import 'package:bookreview/src/signup/cubit/signup_cubit.dart';
import 'package:bookreview/src/signup/page/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      initialLocation: "/",
      refreshListenable: context.read<AuthenticationCubit>(),
      redirect: (context, state) {
        var authStatus = context.read<AuthenticationCubit>().state.status;
        switch (authStatus) {
          case AuthenticationStatus.authentication:
            break;
          case AuthenticationStatus.unauthenticated:
            return "/signup";
          case AuthenticationStatus.unknown:
            return "/login";
          case AuthenticationStatus.init:
            break;
          case AuthenticationStatus.error:
            break;
        }
        return state.path;
      },
      routes: [
        GoRoute(
          path: "/",
          builder: (context, state) => const RootPage(),
        ),
        GoRoute(
          path: "/login",
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: "/signup",
          builder: (context, state) => BlocProvider(
            create: (context) => SignupCubit(),
            child: const SignupPage(),
          ),
        ),
      ],
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
