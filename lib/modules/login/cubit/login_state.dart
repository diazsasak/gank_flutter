import 'package:equatable/equatable.dart';

enum LoginStatus { pure, loading, success, failed }

class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.pure,
  });

  final LoginStatus status;

  @override
  List<Object> get props => [status];

  LoginState copyWith({
    LoginStatus status,
  }) {
    return LoginState(
      status: status ?? this.status,
    );
  }
}
