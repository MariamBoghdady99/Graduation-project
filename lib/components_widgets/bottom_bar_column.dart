import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomBarColumn extends StatelessWidget {
  final String heading, s1, s1Link;
  final String ? s2, s3, s2Link,s3Link;

  const BottomBarColumn({
    Key? key,
    required this.heading,
    required this.s1,
    required this.s1Link,
    this.s2 ,
    this.s2Link,
    this.s3,
    this.s3Link,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 20,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: TextStyle(
              fontSize: 18,
              color: Colors.blueGrey[100],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, s1Link);
            },
            child: Text(
              s1,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white60,
              ),
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () async {
              Navigator.pushNamed(context, s2Link!);
            },
            child: Text(
              s2!,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white60,
              ),
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, s3Link!);
            },
            child: Text(
              s3!,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white60,
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
