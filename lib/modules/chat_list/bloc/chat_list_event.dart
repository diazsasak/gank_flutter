part of 'chat_list_bloc.dart';

abstract class ChatListEvent extends Equatable {
  const ChatListEvent();
}

class ChatMemberStarted extends ChatListEvent {
  @override
  List<Object> get props => [];
}

class ChatMemberChanged extends ChatListEvent {
  @override
  List<Object> get props => [];
}
