import 'package:bloc/bloc.dart';
import 'package:gank_flutter/modules/login/cubit/login_state.dart';
import 'package:gank_flutter/repositories/authentication_repository.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository)
      : assert(_authenticationRepository != null),
        super(const LoginState());

  final AuthenticationRepository _authenticationRepository;

  Future<void> logInWithGoogle() async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      await _authenticationRepository.logInWithGoogle();
      emit(state.copyWith(status: LoginStatus.success));
    } on Exception {
      emit(state.copyWith(status: LoginStatus.failed));
    } on NoSuchMethodError {
      emit(state.copyWith(status: LoginStatus.pure));
    }
  }
}
