part of 'chat_conversation_bloc.dart';

abstract class ChatConversationEvent extends Equatable {
  const ChatConversationEvent();
}

class ChatConversationStarted extends ChatConversationEvent {
  @override
  List<Object> get props => [];
}

class ChatMessageSend extends ChatConversationEvent {
  final String message;

  ChatMessageSend(this.message);

  @override
  List<Object> get props => [message];
}

class ChatMessageReceive extends ChatConversationEvent {
  final ChatMessage message;

  ChatMessageReceive(this.message);

  @override
  List<Object> get props => [message];
}

class DoCall extends ChatConversationEvent {
  @override
  List<Object> get props => [];
}
