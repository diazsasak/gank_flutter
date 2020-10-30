import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gank_flutter/modules/login/cubit/login_cubit.dart';
import 'package:gank_flutter/modules/login/view/login_form.dart';
import 'package:gank_flutter/repositories/authentication_repository.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocProvider(
            create: (_) => LoginCubit(
              context.repository<AuthenticationRepository>(),
            ),
            child: LoginForm(),
          ),
        ),
      ),
    );
  }
}
