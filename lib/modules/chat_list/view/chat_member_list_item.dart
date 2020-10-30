import 'package:agora_rtm/agora_rtm.dart';
import 'package:flutter/material.dart';
import 'package:gank_flutter/modules/chat_conversation/view/chat_conversation_page.dart';

class ChatMemberListItem extends StatelessWidget {
  final AgoraRtmMember member;

  ChatMemberListItem(this.member);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.push(context, ChatConversationPage.route()),
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [Text(member.userId)],
          ),
        ),
      ),
    );
  }
}
