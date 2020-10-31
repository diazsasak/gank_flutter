import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class BottomNavigationState extends Equatable {
  const BottomNavigationState();
}

class CurrentIndexChanged extends BottomNavigationState {
  final int currentIndex;

  CurrentIndexChanged({@required this.currentIndex});

  @override
  String toString() => 'CurrentIndexChanged to $currentIndex';

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class PageLoading extends BottomNavigationState {
  @override
  String toString() => 'PageLoading';

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CocktailPageLoaded extends BottomNavigationState {
  CocktailPageLoaded();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ChatListPageLoaded extends BottomNavigationState {
  ChatListPageLoaded();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AccountPageLoaded extends BottomNavigationState {
  AccountPageLoaded();

  @override
  // TODO: implement props
  List<Object> get props => [];
}
