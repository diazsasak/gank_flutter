import 'package:agora_rtm/agora_rtm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gank_flutter/modules/chat_conversation/view/chat_conversation_page.dart';
import 'package:gank_flutter/modules/chat_list/bloc/chat_list_bloc.dart';

class ChatMemberListItem extends StatelessWidget {
  final AgoraRtmMember member;

  ChatMemberListItem(this.member);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute<void>(
                builder: (_) => BlocProvider.value(
                      value: context.bloc<ChatListBloc>(),
                      child: ChatConversationPage(member.userId),
                    ))),
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(Icons.circle,
                  color: Theme.of(context).primaryColor, size: 10),
              SizedBox(width: 5),
              Text(member.userId)
            ],
          ),
        ),
      ),
    );
  }
}
