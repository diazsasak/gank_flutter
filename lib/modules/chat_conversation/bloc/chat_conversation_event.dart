part of 'chat_conversation_bloc.dart';

abstract class ChatConversationEvent extends Equatable {
  const ChatConversationEvent();
}

class ChatConversationStarted extends ChatConversationEvent {
  @override
  List<Object> get props => [];
}
