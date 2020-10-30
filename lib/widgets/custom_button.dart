import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final String label;
  final double width;

  CustomButton({
    @required this.label,
    @required this.onPressed,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      color: Theme.of(context).buttonColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
      child: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
