import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gank_flutter/models/cocktail.dart';
import 'package:gank_flutter/repositories/cocktail_repository.dart';
import 'package:meta/meta.dart';

part 'cocktail_event.dart';

part 'cocktail_state.dart';

class CocktailBloc extends Bloc<CocktailEvent, CocktailState> {
  final CocktailRepository cocktailRepository;

  CocktailBloc({@required this.cocktailRepository}) : super(CocktailInitial());

  @override
  Stream<CocktailState> mapEventToState(
    CocktailEvent event,
  ) async* {
    if (event is CocktailStarted) {
      Map<String, dynamic> response =
          await cocktailRepository.getData();
      if (response['status']) {
        yield CocktailLoadSuccess(response['data']);
      } else {
        yield CocktailLoadFailure(message: response['data']);
      }
    }
  }
}
