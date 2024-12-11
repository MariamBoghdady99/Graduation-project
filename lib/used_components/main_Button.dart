import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {

  final List<Color> colors;
  final String text;
  final bool isOnlight;
  final Function() onPressed;
  MainButton({required this.text, required this.colors, required this.isOnlight, required this.onPressed});

  //const MainButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 30,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.shade50,
            // color: Color(0xFF6078EA),
            offset: Offset(0,8),
            blurRadius: 8,
          )
        ]
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isOnlight ?Icon(Icons.play_circle_filled, color: Color(0xFFB0BFDE),) :
                Container(),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.transparent,
              ),
                onPressed: onPressed,
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    color: isOnlight ? Color(0xFF7C8FB5) : Colors.brown[100],
                    letterSpacing: 1,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
