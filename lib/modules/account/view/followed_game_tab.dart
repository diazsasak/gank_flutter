import 'package:flutter/material.dart';

class FollowedGameTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              ClipRect(
                child: Image.asset(
                  'assets/logo.png',
                  height: 40.0,
                  width: 40.0,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text('Dota 2'),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text('3655 followers',
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                            fontWeight: FontWeight.w300, fontSize: 9.0)),
                  ],
                ),
              ),
              FlatButton(
                onPressed: () {},
                height: 10.0,
                minWidth: 5.0,
                color: Theme.of(context).buttonColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                child: Icon(Icons.check, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
