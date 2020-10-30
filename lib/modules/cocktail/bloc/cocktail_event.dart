part of 'cocktail_bloc.dart';

abstract class CocktailEvent extends Equatable {
  const CocktailEvent();
}

class CocktailStarted extends CocktailEvent {
  @override
  List<Object> get props => [];
}
