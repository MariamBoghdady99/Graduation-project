import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_web_app/screens/home_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_web_app/screens/user_screens/user_doctor.dart';
import 'package:my_web_app/screens/user_screens/add_new_report.dart';
import 'package:my_web_app/screens/api_Screens/first_page.dart';
import 'package:my_web_app/screens/user_screens/user_reports.dart';
import 'package:my_web_app/screens/user_screens/user_drugs.dart';
import 'package:intl/intl.dart';

class UserPage extends StatefulWidget {

  static String id = 'user_details';


  const UserPage({Key? key, required this.theDocID, required this.theGuestData}) : super(key: key);

  final String theDocID;
  final Map<String, dynamic> theGuestData;


  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  final _auth = FirebaseAuth.instance;

  signOut() async {
    await _auth.signOut();
    Navigator.pushNamed(context, HomePage.id);
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;

    DateTime today = DateTime.now();
    String guestBirthDate = widget.theGuestData['Age'];
    DateTime birthDate = DateFormat('yyyy-MM-dd').parse(guestBirthDate);
    int guestAge = today.year - birthDate.year;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome ${widget.theGuestData['Name']}\'s relative'
        ),
        leading: PopupMenuButton(
          icon: Icon(
            FontAwesomeIcons.bars,
          ),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,
              child: Row(
                children: [
                  Container(
                    child: Icon(
                      FontAwesomeIcons.userDoctor,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  SizedBox(width: 10.0,),
                  Text('The doctors',
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: 2,
              child: Row(
                children: [
                  Container(
                    child: Icon(
                      FontAwesomeIcons.pills,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  SizedBox(width: 10.0,),
                  Text('The drugs',
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: 3,
              child: Row(
                children: [
                  Container(
                    child: Icon(
                      FontAwesomeIcons.file,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  SizedBox(width: 10.0,),
                  Text('The reports',
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                ],
              ),
            ),
          ],
          onSelected: (int menu) {
            if(menu == 1) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                  UserDoctors(userID: widget.theDocID, userData: widget.theGuestData)));
            } if(menu == 2) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                  UserDrugs(userID: widget.theDocID, userData: widget.theGuestData)));
            } else if (menu == 3) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                      userReports(userData: widget.theGuestData, userId: widget.theDocID)));
            }
          },
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, FirstPage.id);
              },
              child: Text(
                'Go to API page',
                style: TextStyle(
                  color: Colors.white
                ),
              )
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: InputDecorator(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '${widget.theGuestData['Name']}\'s Info',
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: width * .3 * .3,
                    height: height * .35,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(widget.theGuestData['Image']),
                      minRadius: 25,
                      maxRadius: 57,),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text('Name:'),
                      SizedBox(width: 5,),
                      Text(widget.theGuestData['Name']),
                      SizedBox(width: 15,),
                      Text('Age: '),
                      SizedBox(width: 5,),
                      Text('$guestAge'),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
