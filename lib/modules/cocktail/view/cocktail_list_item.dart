import 'package:flutter/material.dart';
import 'package:gank_flutter/models/cocktail.dart';

class CocktailListItem extends StatelessWidget {
  final Cocktail data;

  CocktailListItem(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
              child: Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/logo.png',
                      height: 30.0,
                      width: 30.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          RichText(
                              text: TextSpan(
                                  text: 'Gank',
                                  style: Theme.of(context).textTheme.bodyText1,
                                  children: [
                                TextSpan(
                                    text: ' to ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal)),
                                TextSpan(
                                    text: 'Dota 2',
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                              ])),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text('Oct 9, 2020',
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                              fontWeight: FontWeight.w300, fontSize: 9.0)),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                data.strDrink,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 12.0),
              ),
            ),
            Container(
              width: double.infinity,
              height: 200.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  data.strDrinkThumb,
                  height: 50.0,
                  width: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.check_box, color: Colors.white, size: 15.0),
                      SizedBox(width: 5),
                      Text('123',
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 8.0)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.mode_comment_outlined,
                          color: Colors.white, size: 15.0),
                      SizedBox(width: 5),
                      Text('123',
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 8.0)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.share_outlined,
                          color: Colors.white, size: 15.0),
                      SizedBox(width: 5),
                      Text('SHARE',
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 8.0)),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
