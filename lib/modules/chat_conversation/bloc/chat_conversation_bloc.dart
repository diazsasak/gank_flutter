import 'dart:async';

import 'package:agora_rtm/agora_rtm.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gank_flutter/models/chat_message.dart';

part 'chat_conversation_event.dart';

part 'chat_conversation_state.dart';

class ChatConversationBloc
    extends Bloc<ChatConversationEvent, ChatConversationState> {
  String userId;
  String partnerId;
  AgoraRtmChannel channel;
  AgoraRtmClient client;
  List<ChatMessage> messages = [];

  ChatConversationBloc(this.client, this.channel, this.userId, this.partnerId)
      : super(ChatConversationInitial()) {
    client.onMessageReceived = (AgoraRtmMessage message, String peerId) {
      print("receive msg from: " + peerId + ", msg: " + message.text);
      if (peerId == partnerId) {
        add(ChatMessageReceive(ChatMessage(peerId, message.text)));
      }
    };
  }

  @override
  Stream<ChatConversationState> mapEventToState(
    ChatConversationEvent event,
  ) async* {
    if (event is ChatMessageSend) {
      AgoraRtmMessage arm = AgoraRtmMessage.fromText(event.message);
      client.sendMessageToPeer(partnerId, arm);
      messages.add(ChatMessage(userId, event.message));
      yield (state as MessageLoadSuccess).copyWith(messages: messages);
    } else if (event is ChatConversationStarted) {
      yield MessageLoadSuccess(messages);
    } else if (event is ChatMessageReceive) {
      messages.add(event.message);
      yield (state as MessageLoadSuccess).copyWith(messages: messages);
    }
  }

  sendMessage(String text) async {
    try {
      AgoraRtmMessage message = AgoraRtmMessage.fromText(text);
      print(message.text);
      await client.sendMessageToPeer(partnerId, message, false);
      print('Send peer message success.');
    } catch (errorCode) {
      print('Send peer message error: ' + errorCode.toString());
    }
  }
}
