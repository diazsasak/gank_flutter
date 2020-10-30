import 'dart:async';

import 'package:agora_rtm/agora_rtm.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'chat_list_event.dart';

part 'chat_list_state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  AgoraRtmClient _client;
  AgoraRtmChannel _channel;
  String userId;

  ChatListBloc(this.userId) : super(ChatInitial());

  @override
  Stream<ChatListState> mapEventToState(
    ChatListEvent event,
  ) async* {
    if (event is ChatMemberStarted) {
      await createClient();
      await login();
      _channel = await createChannel('gank');
      await joinChannel();
      try {
        List<AgoraRtmMember> members = await getMembers();
        yield ChatMemberLoadSuccess(members: members);
      } on Exception catch (e) {
        yield ChatMemberLoadFailure(e.toString());
      }
    } else if (event is ChatMemberChanged) {
      try {
        List<AgoraRtmMember> members = await getMembers();
        yield ChatMemberLoadSuccess(members: members);
      } on Exception catch (e) {
        yield ChatMemberLoadFailure(e.toString());
      }
    }
  }

  Future<AgoraRtmChannel> createChannel(String name) async {
    AgoraRtmChannel channel = await _client.createChannel(name);
    print('channel created: ${channel.channelId}');
    channel.onMemberJoined = (AgoraRtmMember member) {
      print(
          "Member joined: " + member.userId + ', channel: ' + member.channelId);
      mapEventToState(ChatMemberChanged());
    };
    channel.onMemberLeft = (AgoraRtmMember member) {
      print("Member left: " + member.userId + ', channel: ' + member.channelId);
      mapEventToState(ChatMemberChanged());
    };
    channel.onMessageReceived =
        (AgoraRtmMessage message, AgoraRtmMember member) {
      print("Channel msg: " + member.userId + ", msg: " + message.text);
    };
    return channel;
  }

  Future<void> createClient() async {
    print('create client');
    _client =
        await AgoraRtmClient.createInstance('10be0f706220404296699b9458e87b6b');
    _client.onMessageReceived = (AgoraRtmMessage message, String peerId) {
      print("Peer msg: " + peerId + ", msg: " + message.text);
    };
    _client.onConnectionStateChanged = (int state, int reason) {
      print('Connection state changed: ' +
          state.toString() +
          ', reason: ' +
          reason.toString());
      if (state == 5) {
        _client.logout();
        print('Logout.');
      }
    };
  }

  Future<List<AgoraRtmMember>> getMembers() async {
    try {
      List<AgoraRtmMember> members = await _channel.getMembers();
      print('Members: ' + members.toString());
      return members;
    } catch (errorCode) {
      print('GetMembers failed: ' + errorCode.toString());
      throw Exception('GetMembers failed: ' + errorCode.toString());
    }
  }

  Future<void> joinChannel() async {
    print('Joining channel: ${_channel.channelId}.');
    try {
      await _channel.join();
      print('Join channel success.');
    } catch (errorCode) {
      print('Join channel error: ' + errorCode.toString());
    }
  }

  Future<void> login() async {
    print('try login, user id: $userId');
    try {
      await _client.login(null, userId);
      print('Login success: ' + userId);
    } catch (errorCode) {
      print('Login error: ' + errorCode.toString());
    }
  }
}
