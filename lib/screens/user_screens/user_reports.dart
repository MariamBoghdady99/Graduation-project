import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_web_app/screens/user_screens/add_new_report.dart';

class userReports extends StatefulWidget {
  const userReports({Key? key, required this.userData, required this.userId}) : super(key: key);

  final Map<String, dynamic> userData;
  final String userId;

  @override
  State<userReports> createState() => _userReportsState();
}

class _userReportsState extends State<userReports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.userData['Name']}\'s Reports',
        ),
        actions: [
          TextButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                    NewReport(docID: widget.userId)));
              },
              child: Text(
                'add new Report'
                )
          ),
        ],
      ),
      body: Center(
        child: TextButton(
          child: Text(
            'Send data to Survey'
          ),
          onPressed: () async {
            final integers = [1, 2, 3, 4, 5, 6];
            final url = Uri.parse("http://127.0.0.1:5000/recieve_integers");
            final headers = {'Content-Type': 'application/json'};
            final body = jsonEncode({'integers': integers});
            try{
              final response = await http.post(url, headers: headers, body: body);
              if (response.statusCode == 200) {
                print('Integers sent successfully');
              } else {
                print('Error sending integers. Status code: ${response.statusCode}');
              }
            }catch(e){
              print(e);
            }
          },
        ),
      ),
    );
  }
}
