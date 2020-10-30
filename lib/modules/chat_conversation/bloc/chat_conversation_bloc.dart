import 'dart:async';

import 'package:agora_rtm/agora_rtm.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gank_flutter/models/chat_message.dart';

part 'chat_conversation_event.dart';
part 'chat_conversation_state.dart';

class ChatConversationBloc extends Bloc<ChatConversationEvent, ChatConversationState> {
  String userId;
  AgoraRtmClient client;

  ChatConversationBloc(this.userId, this.client) : super(ChatConversationInitial());

  @override
  Stream<ChatConversationState> mapEventToState(
    ChatConversationEvent event,
  ) async* {
    if(event is ChatConversationStarted){

    }
  }
}
