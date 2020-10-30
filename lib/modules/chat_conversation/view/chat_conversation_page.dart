import 'package:agora_rtm/agora_rtm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gank_flutter/blocs/authentication/authentication_bloc.dart';
import 'package:gank_flutter/modules/chat_conversation/bloc/chat_conversation_bloc.dart';
import 'package:gank_flutter/modules/chat_conversation/view/chat_message_list_item.dart';

class ChatConversationPage extends StatelessWidget {
  final AgoraRtmClient client;

  ChatConversationPage(this.client);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ChatConversationPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatConversationBloc(
          context.bloc<AuthenticationBloc>().state.user.name, client)
        ..add(ChatConversationStarted()),
      child: BlocListener<ChatConversationBloc, ChatConversationState>(
        listener: (context, state) {
          if (state is SendMessageFailure) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.orange,
                content: Text('Failed to send message.'),
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
                  title: Text('Name'),
                ),
                body: Container(
                  padding: EdgeInsets.only(bottom: 8),
                  color: Theme.of(context).backgroundColor,
                  child: ListView.builder(
                      padding: EdgeInsets.all(8.0),
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        return ChatMessageListItem(state.messages[index]);
                      }),
                ),
              ),
            );
          }
          return Container(
            color: Theme.of(context).backgroundColor,
          );
        }),
      ),
    );
  }
}
