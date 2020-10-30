import 'package:flutter/material.dart';
import 'package:gank_flutter/widgets/custom_button.dart';

class PostTab extends StatelessWidget {
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
        Text(
          "You haven't created any posts yet.\nStart sharing your gaming moments.",
          textAlign: TextAlign.center,
        ),
        CustomButton(
          label: 'Create a Post',
          onPressed: () {},
          width: null,
        ),
      ],
    );
  }
}
