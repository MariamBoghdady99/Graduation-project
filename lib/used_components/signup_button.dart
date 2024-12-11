import 'package:flutter/material.dart';

class SignUpBotton extends StatelessWidget {

  Color borderColor;
  Color buttonColor;
  void Function() onPressed;
  Widget buttonChild;


  SignUpBotton({this.borderColor = Colors.grey, required this.buttonColor,
    required this.onPressed,
    required this.buttonChild});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style:ElevatedButton.styleFrom(
          elevation: 26,
          padding: EdgeInsets.symmetric(
              vertical: 15,
              ),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: borderColor),
            borderRadius:
            BorderRadius.all(Radius.circular(20)),
          ),
          backgroundColor: buttonColor,
        ),
        onPressed: onPressed,
        child: buttonChild,
        );
  }
}
