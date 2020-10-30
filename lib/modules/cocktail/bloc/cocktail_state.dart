part of 'cocktail_bloc.dart';

abstract class CocktailState extends Equatable {
  const CocktailState();
}

class CocktailInitial extends CocktailState {
  @override
  List<Object> get props => [];
}

class CocktailLoadSuccess extends CocktailState {
  final List<Cocktail> data;

  CocktailLoadSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class CocktailLoadFailure extends CocktailState {
  final String message;

  CocktailLoadFailure(
      {this.message = 'Failed to load cocktail, please try again.'});

  @override
  List<Object> get props => [message];
}
