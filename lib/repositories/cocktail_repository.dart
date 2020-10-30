import 'package:gank_flutter/providers/cocktail_provider.dart';
import 'package:meta/meta.dart';

class CocktailRepository {
  final CocktailProvider cocktailProvider;

  CocktailRepository({@required this.cocktailProvider});

  getData() async {
    return cocktailProvider.getData();
  }
}
