import 'dart:async';

import 'package:agora_rtm/agora_rtm.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'chat_list_event.dart';

part 'chat_list_state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  AgoraRtmClient client;
  AgoraRtmChannel channel;
  String userId;

  ChatListBloc(this.userId) : super(ChatInitial());

  @override
  Stream<ChatListState> mapEventToState(
    ChatListEvent event,
  ) async* {
    if (event is ChatMemberStarted) {
      await createClient();
      await login();
      channel = await createChannel('gank');
      await joinChannel();
      await onChannelEvent();
      try {
        List<AgoraRtmMember> members = await getMembers();
        members.removeWhere((element) => element.userId == userId);
        yield ChatMemberLoadSuccess(members: members);
      } on Exception catch (e) {
        yield ChatMemberLoadFailure(e.toString());
      }
    } else if (event is ChatMemberChanged) {
      try {
        List<AgoraRtmMember> members = await getMembers();
        members.removeWhere((element) => element.userId == userId);
        yield ChatMemberLoadSuccess(members: members);
      } on Exception catch (e) {
        yield ChatMemberLoadFailure(e.toString());
      }
    }
  }

  onChannelEvent() {
    channel.onMemberJoined = (AgoraRtmMember member) {
      print(
          "Member joined: " + member.userId + ', channel: ' + member.channelId);
      add(ChatMemberChanged());
    };
    channel.onMemberLeft = (AgoraRtmMember member) {
      print("Member left: " + member.userId + ', channel: ' + member.channelId);
      add(ChatMemberChanged());
    };
  }

  Future<List<AgoraRtmMember>> getMembers() async {
    try {
      List<AgoraRtmMember> members = await channel.getMembers();
      print('Members: ' + members.toString());
      return members;
    } catch (errorCode) {
      print('GetMembers failed: ' + errorCode.toString());
      throw Exception('GetMembers failed: ' + errorCode.toString());
    }
  }

  Future<void> createClient() async {
    print('create client');
    client =
        await AgoraRtmClient.createInstance('10be0f706220404296699b9458e87b6b');
    client.onMessageReceived = (AgoraRtmMessage message, String peerId) {
      print("Peer msg: " + peerId + ", msg: " + message.text);
    };
    client.onConnectionStateChanged = (int state, int reason) {
      print('Connection state changed: ' +
          state.toString() +
          ', reason: ' +
          reason.toString());
      if (state == 5) {
        client.logout();
        print('Logout.');
      }
    };
  }

  Future<AgoraRtmChannel> createChannel(String name) async {
    AgoraRtmChannel channel = await client.createChannel(name);
    print('channel created: ${channel.channelId}');
    channel.onMessageReceived =
        (AgoraRtmMessage message, AgoraRtmMember member) {
      print("Channel msg: " + member.userId + ", msg: " + message.text);
    };
    return channel;
  }

  Future<void> joinChannel() async {
    print('Joining channel: ${channel.channelId}.');
    try {
      await channel.join();
      print('Join channel success.');
    } catch (errorCode) {
      print('Join channel error: ' + errorCode.toString());
    }
  }

  Future<void> login() async {
    print('try login, user id: $userId');
    try {
      await client.login(null, userId);
      print('Login success: ' + userId);
    } catch (errorCode) {
      print('Login error: ' + errorCode.toString());
    }
  }
}
