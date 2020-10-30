import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gank_flutter/blocs/authentication/authentication_bloc.dart';
import 'package:gank_flutter/modules/account/view/avatar.dart';
import 'package:gank_flutter/modules/account/view/comment_tab.dart';
import 'package:gank_flutter/modules/account/view/followed_game_tab.dart';
import 'package:gank_flutter/modules/account/view/post_tab.dart';
import 'package:gank_flutter/modules/account/view/profile_tab.dart';

class AccountPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => AccountPage());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.bloc<AuthenticationBloc>().state.user;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/background.jpeg'),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            icon:
                                Icon(Icons.edit_outlined, color: Colors.white),
                            onPressed: null),
                        IconButton(
                            icon: Icon(Icons.settings, color: Colors.white),
                            onPressed: null),
                        IconButton(
                          icon: Icon(Icons.exit_to_app, color: Colors.white),
                          onPressed: () => context
                              .bloc<AuthenticationBloc>()
                              .add(AuthenticationLogoutRequested()),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'FOLLOWERS',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('0'),
                          ],
                        ),
                        Avatar(photo: user.photo),
                        Column(
                          children: [
                            Text('FOLLOWING'),
                            Text('0'),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(height: 8.0),
                        Text(
                          user.email.length > 7
                              ? user.email.substring(0, 7)
                              : user.email,
                          style: Theme.of(context)
                              .textTheme
                              .headline2
                              .copyWith(fontSize: 20.0),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'EXPERIENCE 0',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontSize: 8.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              Container(
                  child: TabBar(
                unselectedLabelColor: Colors.grey,
                labelColor: Colors.white,
                indicatorColor: Colors.white,
                tabs: [
                  Tab(icon: Icon(Icons.person)),
                  Tab(icon: Icon(Icons.dashboard)),
                  Tab(icon: Icon(Icons.mode_comment_outlined)),
                  Tab(icon: Icon(Icons.videogame_asset_outlined)),
                ],
              )),
              Expanded(
                  child: TabBarView(children: [
                ProfileTab(),
                PostTab(),
                CommentTab(),
                FollowedGameTab(),
              ])),
            ],
          ),
        ),
      ),
    );
  }
}
