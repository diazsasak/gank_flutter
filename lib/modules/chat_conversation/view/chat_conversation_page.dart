import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gank_flutter/blocs/authentication/authentication_bloc.dart';
import 'package:gank_flutter/modules/chat_conversation/bloc/chat_conversation_bloc.dart';
import 'package:gank_flutter/modules/chat_conversation/view/chat_message_list_item.dart';
import 'package:gank_flutter/modules/chat_list/bloc/chat_list_bloc.dart';
import 'package:gank_flutter/widgets/custom_loading.dart';
import 'package:permission_handler/permission_handler.dart';

class ChatConversationPage extends StatefulWidget {
  final String partnerId;

  ChatConversationPage(this.partnerId);

  @override
  _ChatConversationPageState createState() => _ChatConversationPageState();
}

class _ChatConversationPageState extends State<ChatConversationPage> {
  final _textCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _handleCameraAndMic();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatConversationBloc(
        context.bloc<ChatListBloc>().client,
        context.bloc<ChatListBloc>().channel,
        context.bloc<AuthenticationBloc>().state.user.email,
        widget.partnerId,
      )..add(ChatConversationStarted()),
      child: BlocListener<ChatConversationBloc, ChatConversationState>(
        listener: (context, state) {
          if (state is SendMessageFailure) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.orange,
                content: Text('Failed to load messages.'),
              ),
            );
          }
        },
        child: BlocBuilder<ChatConversationBloc, ChatConversationState>(
            builder: (context, state) {
          if (state is MessageLoadSuccess) {
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: Text(widget.partnerId),
                  actions: [
                    IconButton(
                      icon: Icon((Icons.video_call_outlined)),
                      onPressed: () {},
                    )
                  ],
                ),
                body: Container(
                  padding: EdgeInsets.only(bottom: 8),
                  color: Theme.of(context).backgroundColor,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            padding: EdgeInsets.all(8.0),
                            itemCount: state.messages.length,
                            itemBuilder: (context, index) {
                              return ChatMessageListItem(state.messages[index]);
                            }),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              style: Theme.of(context).textTheme.bodyText1,
                              controller: _textCtrl,
                              decoration: InputDecoration(
                                  hintText: 'Write your message here..',
                                  hintStyle:
                                      Theme.of(context).textTheme.bodyText1,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor))),
                              maxLines: null,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.send),
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              if (_textCtrl.text.length == 0) {
                                return;
                              }
                              context
                                  .bloc<ChatConversationBloc>()
                                  .add(ChatMessageSend(_textCtrl.text));
                              _textCtrl.text = '';
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is ChatConversationInitial) {
            return CustomLoading();
          }
          return Container(
            color: Theme.of(context).backgroundColor,
          );
        }),
      ),
    );
  }

  Future<void> _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
  }
}
