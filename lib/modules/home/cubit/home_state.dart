part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  final int menuIndex;

  HomeInitial({this.menuIndex});

  @override
  List<Object> get props => [menuIndex];
}
