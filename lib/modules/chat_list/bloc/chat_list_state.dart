part of 'chat_list_bloc.dart';

abstract class ChatListState extends Equatable {
  const ChatListState();
}

class ChatInitial extends ChatListState {
  @override
  List<Object> get props => [];
}

class ChatMemberLoadSuccess extends ChatListState {
  final List<AgoraRtmMember> members;

  ChatMemberLoadSuccess({@required this.members});

  @override
  List<Object> get props => [members];
}

class ChatMemberLoadFailure extends ChatListState {

  final String message;


  ChatMemberLoadFailure(this.message);

  @override
  List<Object> get props => [message];
}

