import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class BottomNavigationEvent extends Equatable {
  const BottomNavigationEvent();
}

class NavStarted extends BottomNavigationEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class PageTapped extends BottomNavigationEvent {
  final int index;

  PageTapped({@required this.index});

  @override
  String toString() => 'PageTapped: $index';

  @override
  // TODO: implement props
  List<Object> get props => [];
}
