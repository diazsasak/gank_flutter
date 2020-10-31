part of 'call_bloc.dart';

@immutable
abstract class CallEvent {}

class InitCall extends CallEvent {
  final String channelName;
  final ClientRole role;

  InitCall({this.channelName, this.role});
}

class ShowSnackbar extends CallEvent {
  final String error;
  final String status;

  ShowSnackbar(this.error, this.status);
}

class EndCall extends CallEvent {}
class ToggleMute extends CallEvent {}
class ToggleVideo extends CallEvent {}
class SwitchCamera extends CallEvent {}
class ManageUser extends CallEvent {
  final List<int> users;

  ManageUser(this.users);
}
