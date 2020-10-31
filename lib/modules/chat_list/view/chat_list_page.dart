import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gank_flutter/blocs/authentication/authentication_bloc.dart';
import 'package:gank_flutter/modules/chat_list/bloc/chat_list_bloc.dart';
import 'package:gank_flutter/modules/chat_list/view/chat_member_list_item.dart';

class ChatListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatListBloc(
        context.bloc<AuthenticationBloc>().state.user.email,
      )..add(ChatMemberStarted()),
      child: BlocListener<ChatListBloc, ChatListState>(
        listener: (context, state) {
          if (state is ChatMemberLoadFailure) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.orange,
                content: Text(state.message),
              ),
            );
          }
        },
        child:
            BlocBuilder<ChatListBloc, ChatListState>(builder: (context, state) {
          if (state is ChatInitial) {
            return SafeArea(
              child: Container(
                color: Theme.of(context).backgroundColor,
                child: Center(
                  child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor)),
                ),
              ),
            );
          } else if (state is ChatMemberLoadSuccess) {
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: Text('Chat List'),
                ),
                body: Container(
                  padding: EdgeInsets.only(bottom: 8),
                  color: Theme.of(context).backgroundColor,
                  child: state.members.length == 0
                      ? Center(
                          child: Text('No one online.'),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.all(8.0),
                          itemCount: state.members.length,
                          itemBuilder: (context, index) {
                            return ChatMemberListItem(state.members[index]);
                          }),
                ),
              ),
            );
          } else if (state is ChatMemberLoadFailure) {
            return SafeArea(
              child: Container(
                color: Theme.of(context).backgroundColor,
                child: Center(
                  child: Text('Failed to load chat list, please try again.'),
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
