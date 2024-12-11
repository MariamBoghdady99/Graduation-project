import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';

class GuestImage extends StatelessWidget {
  // const GuestImage({Key? key}) : super(key: key);

  late String imageLink;
  GuestImage({required this.imageLink});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundColor: Colors.transparent,
      backgroundImage: NetworkImage('https://cors-anywhere.herokuapp.com/${imageLink}'),
    );
  }
}
