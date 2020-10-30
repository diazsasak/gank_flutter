import 'package:flutter/material.dart';
import 'package:gank_flutter/models/chat_message.dart';

class ChatMessageListItem extends StatelessWidget {
  final ChatMessage message;

  ChatMessageListItem(this.message);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Text(message.message),
      ),
    );
  }
}
