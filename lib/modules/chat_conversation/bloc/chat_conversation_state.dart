part of 'chat_conversation_bloc.dart';

abstract class ChatConversationState {
  const ChatConversationState();
}

class ChatConversationInitial extends ChatConversationState {
  // @override
  // List<Object> get props => [];
}

class SendMessageFailure extends ChatConversationState {
  // @override
  // List<Object> get props => [];
}

class MessageLoadSuccess extends ChatConversationState {
  final List<ChatMessage> messages;

  MessageLoadSuccess(this.messages);

  MessageLoadSuccess copyWith({
    List<ChatMessage> messages,
  }) {
    return MessageLoadSuccess(
      messages ?? this.messages,
    );
  }

// @override
// List<Object> get props => [messages];
}
