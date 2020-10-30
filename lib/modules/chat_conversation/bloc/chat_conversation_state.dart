part of 'chat_conversation_bloc.dart';

abstract class ChatConversationState extends Equatable {
  const ChatConversationState();
}

class ChatConversationInitial extends ChatConversationState {
  @override
  List<Object> get props => [];
}

class SendMessageFailure extends ChatConversationState {
  @override
  List<Object> get props => [];
}

class MessageLoadSuccess extends ChatConversationState {
  final List<ChatMessage> messages;


  MessageLoadSuccess(this.messages);

  @override
  List<Object> get props => [messages];
}
