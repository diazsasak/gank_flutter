import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gank_flutter/blocs/bottom_navigation/bottom_navigation.dart';
import 'package:gank_flutter/modules/account/view/account_page.dart';
import 'package:gank_flutter/modules/chat_list/view/chat_list_page.dart';
import 'package:gank_flutter/modules/cocktail/view/cocktail_page.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBloc bottomNavigationBloc =
        context.bloc<BottomNavigationBloc>();

    return Scaffold(
      body: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        builder: (context, state) {
          if (state is PageLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is CocktailPageLoaded) {
            return CocktailPage();
          }
          if (state is ChatListPageLoaded) {
            return ChatListPage();
          }
          if (state is AccountPageLoaded) {
            return AccountPage();
          }
          return Container();
        },
      ),
      bottomNavigationBar:
          BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
              builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: bottomNavigationBloc.currentIndex,
          onTap: (index) => bottomNavigationBloc.add(PageTapped(index: index)),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.local_drink), label: 'Cocktail'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
          ],
        );
      }),
    );
  }
}
