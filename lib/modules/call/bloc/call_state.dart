part of 'call_bloc.dart';

@immutable
abstract class CallState {}

class CallInitial extends CallState {}

class CallInitialized extends CallState {
  final bool muted;
  final bool videoOff;
  final List<int> users;

  CallInitialized(this.muted, this.videoOff, this.users);

  CallInitialized copyWith({bool muted, bool videoOff, List<int> users}) {
    return CallInitialized(
        muted ?? this.muted, videoOff ?? this.videoOff, users ?? this.users);
  }
}

class SnackbarShowing extends CallState {
  final String message;
  final String status;

  SnackbarShowing(this.message, this.status);
}

class CallEnded extends CallState {}
