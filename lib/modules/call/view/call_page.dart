import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gank_flutter/modules/call/bloc/call_bloc.dart';
import 'package:gank_flutter/modules/chat_conversation/view/chat_conversation_page.dart';

class CallPage extends StatefulWidget {
  final String channelName;
  final ClientRole role;

  const CallPage({Key key, this.channelName, this.role}) : super(key: key);

  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  /// Helper function to get list of native views
  List<Widget> _getRenderViews(CallInitialized state) {
    final List<StatefulWidget> list = [];
    if (widget.role == ClientRole.Broadcaster) {
      list.add(RtcLocalView.SurfaceView());
    }
    state.users
        .forEach((int uid) => list.add(RtcRemoteView.SurfaceView(uid: uid)));
    return list;
  }

  /// Video view wrapper
  Widget _videoView(view) {
    return Expanded(child: Container(child: view));
  }

  /// Video view row wrapper
  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(_videoView).toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  /// Video layout wrapper
  Widget _viewRows(CallInitialized state) {
    final views = _getRenderViews(state);
    switch (views.length) {
      case 1:
        return Container(
            child: Column(
          children: <Widget>[_videoView(views[0])],
        ));
      case 2:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow([views[0]]),
            _expandedVideoRow([views[1]])
          ],
        ));
      case 3:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow(views.sublist(0, 2)),
            _expandedVideoRow(views.sublist(2, 3))
          ],
        ));
      case 4:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow(views.sublist(0, 2)),
            _expandedVideoRow(views.sublist(2, 4))
          ],
        ));
      default:
    }
    return Container();
  }

  /// Toolbar layout
  Widget _toolbar(BuildContext context, CallInitialized state) {
    if (widget.role == ClientRole.Audience) return Container();
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: () => context.bloc<CallBloc>().add(ToggleMute()),
            child: Icon(
              state.muted ? Icons.mic_off : Icons.mic,
              color: state.muted ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: state.muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () => context.bloc<CallBloc>().add(EndCall()),
            child: Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: () => context.bloc<CallBloc>().add(SwitchCamera()),
            child: Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () => context.bloc<CallBloc>().add(ToggleVideo()),
            child: Icon(
              !state.videoOff
                  ? Icons.visibility_rounded
                  : Icons.visibility_off_rounded,
              color: !state.videoOff ? Colors.blueAccent : Colors.white,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: !state.videoOff ? Colors.white : Colors.blueAccent,
            padding: const EdgeInsets.all(12.0),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.channelName),
      ),
      backgroundColor: Colors.black,
      body: BlocProvider(
        create: (context) => CallBloc()
          ..add(InitCall(channelName: widget.channelName, role: widget.role)),
        child: BlocListener<CallBloc, CallState>(
          listener: (context, state) {
            if (state is SnackbarShowing) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: state.status == 'failure'
                      ? Colors.orange
                      : Colors.lightBlueAccent,
                  content: Text(state.message),
                ),
              );
            } else if (state is CallEnded) {
              Navigator.pop(context);
              Navigator.pop(context);
            }
          },
          child: BlocBuilder<CallBloc, CallState>(builder: (context, state) {
            if (state is CallInitialized) {
              return Center(
                child: Stack(
                  children: <Widget>[
                    state.videoOff
                        ? Container(
                            child: Center(
                              child: Icon(Icons.visibility_off_rounded,
                                  color: Colors.white),
                            ),
                          )
                        : _viewRows(state),
                    _toolbar(context, state),
                  ],
                ),
              );
            }
            return Container(
              color: Theme.of(context).backgroundColor,
            );
          }),
        ),
      ),
    );
  }
}
