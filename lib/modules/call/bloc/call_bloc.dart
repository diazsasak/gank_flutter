import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:bloc/bloc.dart';
import 'package:gank_flutter/utils/settings.dart';
import 'package:meta/meta.dart';

part 'call_event.dart';

part 'call_state.dart';

class CallBloc extends Bloc<CallEvent, CallState> {
  RtcEngine _engine;

  CallBloc() : super(CallInitial());

  @override
  Stream<CallState> mapEventToState(
    CallEvent event,
  ) async* {
    if (event is InitCall) {
      try {
        await initialize(event);
        yield CallInitialized(false, false, []);
      } on Exception catch (e) {
        yield SnackbarShowing(e.toString(), 'failure');
      }
    } else if (event is EndCall) {
      yield CallEnded();
    } else if (event is ToggleMute) {
      bool muted = !(state as CallInitialized).muted;
      yield (state as CallInitialized).copyWith(muted: muted);
      _engine.muteLocalAudioStream(muted);
    } else if (event is ToggleVideo) {
      bool videoOff = !(state as CallInitialized).videoOff;
      if (videoOff) {
        _engine.disableVideo();
      } else {
        _engine.enableVideo();
      }
      yield (state as CallInitialized).copyWith(videoOff: videoOff);
    } else if (event is SwitchCamera) {
      _engine.switchCamera();
    } else if (event is ManageUser) {
      yield (state as CallInitialized).copyWith(users: event.users);
    }
  }

  Future<void> initialize(InitCall event) async {
    if (APP_ID.isEmpty) {
      throw Exception('APP_ID missing');
    }

    await _initAgoraRtcEngine(event.role);
    _addAgoraEventHandlers();
    await _engine.enableWebSdkInteroperability(true);
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    configuration.dimensions = VideoDimensions(1920, 1080);
    await _engine.setVideoEncoderConfiguration(configuration);
    await _engine.joinChannel(Token, event.channelName, null, 0);
  }

  /// Create agora sdk instance and initialize
  Future<void> _initAgoraRtcEngine(ClientRole role) async {
    _engine = await RtcEngine.create(APP_ID);
    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(role);
  }

  /// Add agora event handlers
  void _addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(error: (code) {
      print('onError: $code');
    }, joinChannelSuccess: (channel, uid, elapsed) {
      print('onJoinChannel: $channel, uid: $uid');
    }, leaveChannel: (stats) {
      print('onLeaveChannel');
      add(EndCall());
    }, userJoined: (uid, elapsed) {
      print('userJoined: $uid');
      List<int> users = (state as CallInitialized).users;
      users.add(uid);
      add(ManageUser(users));
    }, userOffline: (uid, elapsed) {
      print('userOffline: $uid');
      add(EndCall());
      // List<int> users = (state as CallInitialized).users;
      // users.remove(uid);
      // add(ManageUser(users));
    }, firstRemoteVideoFrame: (uid, width, height, elapsed) {
      print('firstRemoteVideo: $uid ${width}x $height');
    }));
  }

  @override
  Future<void> close() {
    // destroy sdk
    _engine.leaveChannel();
    _engine.destroy();
    return super.close();
  }
}
