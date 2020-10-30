import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gank_flutter/modules/cocktail/bloc/cocktail_bloc.dart';
import 'package:gank_flutter/modules/cocktail/view/cocktail_list_item.dart';
import 'package:gank_flutter/providers/cocktail_provider.dart';
import 'package:gank_flutter/repositories/cocktail_repository.dart';

class CocktailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CocktailBloc(
          cocktailRepository:
              CocktailRepository(cocktailProvider: CocktailProvider()))
        ..add(CocktailStarted()),
      child: BlocListener<CocktailBloc, CocktailState>(
        listener: (context, state) {
          if (state is CocktailLoadFailure) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.orange,
                content: Text(state.message),
              ),
            );
          }
        },
        child:
            BlocBuilder<CocktailBloc, CocktailState>(builder: (context, state) {
          if (state is CocktailInitial) {
            return SafeArea(
              child: Container(
                color: Theme.of(context).backgroundColor,
                child: Center(
                  child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor)),
                ),
              ),
            );
          } else if (state is CocktailLoadSuccess) {
            return SafeArea(
              child: Container(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                color: Theme.of(context).backgroundColor,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: state.data.length,
                          itemBuilder: (context, index) {
                            return CocktailListItem(state.data[index]);
                          }),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is CocktailLoadFailure) {
            return SafeArea(
              child: Container(
                color: Theme.of(context).backgroundColor,
                child: Center(
                  child: Text('Failed to load cocktail, please try again.'),
                ),
              ),
            );
          }
          return Container(
            color: Theme.of(context).backgroundColor,
          );
        }),
      ),
    );
  }
}
