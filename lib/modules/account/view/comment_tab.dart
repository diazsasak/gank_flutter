import 'package:flutter/material.dart';

class CommentTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50.0, bottom: 10.0),
          child: Image.asset(
            'assets/logo.png',
            height: 100.0,
            width: 100.0,
          ),
        ),
        SizedBox(height: 15),
        Text(
          "IT'S QUIET IN HERE",
          textAlign: TextAlign.center,
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        SizedBox(height: 15),
        Text(
          "You haven't constructed any comments yet.",
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
