import 'package:flutter/material.dart';
import 'package:gank_flutter/blocs/authentication/authentication_bloc.dart';
import 'package:gank_flutter/models/chat_message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatMessageListItem extends StatelessWidget {
  final ChatMessage message;

  ChatMessageListItem(this.message);

  @override
  Widget build(BuildContext context) {
    bool isOwner =
        message.userId == context.bloc<AuthenticationBloc>().state.user.email;
    return Container(
      padding:
          isOwner ? EdgeInsets.only(left: 30.0) : EdgeInsets.only(right: 30.0),
      child: Card(
        color: isOwner
            ? Theme.of(context).primaryColor
            : Theme.of(context).cardColor,
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment:
                isOwner ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                message.userId,
                style: TextStyle(
                    color:
                        isOwner ? Theme.of(context).cardColor : Colors.white),
              ),
              Text(
                message.message,
                style: TextStyle(
                    color:
                        isOwner ? Theme.of(context).cardColor : Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
