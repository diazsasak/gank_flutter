import 'package:bloc/bloc.dart';
import 'package:gank_flutter/modules/login/cubit/login_state.dart';
import 'package:gank_flutter/repositories/authentication_repository.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authenticationRepository) : super(const LoginState());

  final AuthenticationRepository authenticationRepository;

  Future<void> logInWithGoogle() async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      await authenticationRepository.logInWithGoogle();
      emit(state.copyWith(status: LoginStatus.success));
    } on Exception {
      emit(state.copyWith(status: LoginStatus.failed));
    } on NoSuchMethodError {
      emit(state.copyWith(status: LoginStatus.pure));
    }
  }
}
