import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gank_flutter/blocs/authentication/authentication_bloc.dart';
import 'package:gank_flutter/blocs/bottom_navigation/bottom_navigation.dart';
import 'package:gank_flutter/modules/home/view/home_page.dart';
import 'package:gank_flutter/modules/login/view/login_page.dart';
import 'package:gank_flutter/modules/splash/view/splash_page.dart';
import 'package:gank_flutter/repositories/authentication_repository.dart';
import 'package:gank_flutter/theme.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;
  AuthenticationRepository authenticationRepository =
      AuthenticationRepository();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<BottomNavigationBloc>(
            lazy: false,
            create: (BuildContext context) =>
                BottomNavigationBloc()..add(NavStarted()),
          ),
          BlocProvider<AuthenticationBloc>(
            lazy: false,
            create: (BuildContext context) => AuthenticationBloc(
                authenticationRepository: authenticationRepository),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: DevicePreview.of(context).locale,
          builder: DevicePreview.appBuilder,
          theme: theme,
          navigatorKey: _navigatorKey,
          home: BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              print('yes');
              switch (state.status) {
                case AuthenticationStatus.authenticated:
                  _navigator.pushAndRemoveUntil<void>(
                    HomePage.route(),
                    (route) => false,
                  );
                  break;
                case AuthenticationStatus.unauthenticated:
                  _navigator.pushAndRemoveUntil<void>(
                    LoginPage.route(),
                    (route) => false,
                  );
                  break;
                default:
                  break;
              }
            },
            child: SplashPage(),
          ),
          onGenerateRoute: (_) => SplashPage.route(),
        ),
      ),
    );
  }
}
