import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gank_flutter/modules/account/view/account_page.dart';
import 'package:gank_flutter/modules/chat/view/chat_page.dart';
import 'package:gank_flutter/modules/cocktail/view/cocktail_page.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final pages = [
    CocktailPage(),
    ChatPage(),
    AccountPage(),
  ];

  setMenuIndex(int index) {
    emit(HomeInitial(menuIndex: index));
  }
}
