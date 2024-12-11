import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_web_app/screens/sign_in_screen.dart';
import 'package:my_web_app/screens/home_screen.dart';
import 'package:my_web_app/screens/about_us_screen.dart';
import 'package:my_web_app/screens/contact_us_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatefulWidget {
  static String id = 'contact_us_screen';

  const ContactUsPage({Key? key}) : super(key: key);

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

final nameController = TextEditingController();
final phoneController = TextEditingController();
final emailController = TextEditingController();
final messageController = TextEditingController();

class _ContactUsPageState extends State<ContactUsPage> {
  final String name = '';
  final String email = '';
  final String phone = '';
  final String message = '';
  final String time = DateTime.now().toString();

  void sendEmail(String email) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'ggargabela@gmail.com',
      query: email,
    );

    final String url = params.toString();

    if (await canLaunch(url)){
      await launch(url);
    }else{
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          // backgroundColor: Colors.blueGrey,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: 100,
          leading: Center(
              child: Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Text(
              'CURA',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          )),
          /*Builder(
          builder: (BuildContext context) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  // width: 40,
                  // height: 40,
                  child: Image.asset('images/logo.png'),
                ),
                Text('CURA'),
              ],
            );
          },
        ),*/
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizedBox(
              //   width: 100,
              // ),
              TextButton(
                /*style: TextButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                primary: Colors.black87,
                minimumSize: Size(88, 36),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),*/
                onPressed: () {
                  Navigator.pushNamed(context, HomePage.id);
                },
                child: Text(
                  'Home',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                    // decoration: TextDecoration.underline,
                    // decorationThickness: 20.0,
                  ),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AboutUsPage.id);
                },
                child: Text(
                  'About us',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Contact Us',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
            ],
          ),
          actions: [
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignUpPage.id);
                    },
                    child: Text(
                      'SignUP',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                      ),
                    )),
                Container(
                  width: .05 * width,
                ),
              ],
            )
          ],
        ),
        body: CustomPaint(
          painter: BluePainter(),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: .6*width,
                  height: .8 * height,
                  child: Center(
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: .6 * (width),
                          height: .6 * height,
                          child: Image.asset('images/Emails.gif'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.mail, color:Colors.green.shade600),
                            Text('mariam.ibrhaim00@gmail.com',style: TextStyle(color: Colors.grey.shade600,fontWeight: FontWeight.bold),),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.phone, color:Colors.green.shade600),
                            Text('+20 100 700',style: TextStyle(color: Colors.grey.shade600,fontWeight: FontWeight.bold),),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.place_outlined, color:Colors.green.shade600),
                            Text('Faculty of Engineering',style: TextStyle(color: Colors.grey.shade600,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: .3 * (width),
                  height: .8 * height,
                  child: Column(
                    children: [
                      // SizedBox(height: 100,),
                      Text(
                        'Message Us',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.grey[600]),
                      ),
                      const Divider(
                        height: 40,
                        thickness: 5,
                        indent: 10,
                        endIndent: 0,
                        color: Colors.green,
                      ),
                      Container(
                        padding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 5),

                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: TextFormField(
                            textAlign: TextAlign.start,
                            controller: nameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Name',
                              floatingLabelStyle:
                              MaterialStateTextStyle.resolveWith(
                                      (Set<MaterialState> states) {
                                    final Color color =
                                    states.contains(MaterialState.error)
                                        ? Theme.of(context).colorScheme.error
                                        : Colors.blueGrey.shade700;
                                    return TextStyle(
                                      color: color,
                                      letterSpacing: 1.3,
                                    );
                                  }),
                              labelStyle: MaterialStateTextStyle.resolveWith(
                                      (Set<MaterialState> states) {
                                    final Color color =
                                    states.contains(MaterialState.error)
                                        ? Theme.of(context).colorScheme.error
                                        : Colors.blueGrey.shade700;
                                    return TextStyle(
                                      color: color,
                                      letterSpacing: 1.3,
                                    );
                                  }),
                            ),
                          ),

                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Email',
                            floatingLabelStyle:
                            MaterialStateTextStyle.resolveWith(
                                    (Set<MaterialState> states) {
                                  final Color color =
                                  states.contains(MaterialState.error)
                                      ? Theme.of(context).colorScheme.error
                                      : Colors.blueGrey.shade700;
                                  return TextStyle(
                                    color: color,
                                    letterSpacing: 1.3,
                                  );
                                }),
                            labelStyle: MaterialStateTextStyle.resolveWith(
                                    (Set<MaterialState> states) {
                                  final Color color =
                                  states.contains(MaterialState.error)
                                      ? Theme.of(context).colorScheme.error
                                      : Colors.blueGrey.shade700;
                                  return TextStyle(
                                    color: color,
                                    letterSpacing: 1.3,
                                  );
                                }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          controller: phoneController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Phone Number',
                            floatingLabelStyle:
                            MaterialStateTextStyle.resolveWith(
                                    (Set<MaterialState> states) {
                                  final Color color =
                                  states.contains(MaterialState.error)
                                      ? Theme.of(context).colorScheme.error
                                      : Colors.blueGrey.shade700;
                                  return TextStyle(
                                    color: color,
                                    letterSpacing: 1.3,
                                  );
                                }),
                            labelStyle: MaterialStateTextStyle.resolveWith(
                                    (Set<MaterialState> states) {
                                  final Color color =
                                  states.contains(MaterialState.error)
                                      ? Theme.of(context).colorScheme.error
                                      : Colors.blueGrey.shade700;
                                  return TextStyle(
                                    color: color,
                                    letterSpacing: 1.3,
                                  );
                                }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: TextFormField(
                          maxLines: 7,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          controller: messageController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Message',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            floatingLabelStyle:
                            MaterialStateTextStyle.resolveWith(
                                    (Set<MaterialState> states) {
                                  final Color color =
                                  states.contains(MaterialState.error)
                                      ? Theme.of(context).colorScheme.error
                                      : Colors.blueGrey.shade700;
                                  return TextStyle(
                                    color: color,
                                    letterSpacing: 1.3,
                                  );
                                }),
                            labelStyle: MaterialStateTextStyle.resolveWith(
                                    (Set<MaterialState> states) {
                                  final Color color =
                                  states.contains(MaterialState.error)
                                      ? Theme.of(context).colorScheme.error
                                      : Colors.blueGrey.shade700;
                                  return TextStyle(
                                    color: color,
                                    letterSpacing: 1.3,
                                  );
                                }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        width:width*.2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape:
                            StadiumBorder(),
                            primary: Colors.grey[800],
                            onPrimary: Colors.grey[400],
                            onSurface: Colors.grey[600],
                          ),
                          // Within the `FirstRoute` widget
                          onPressed: () async {
                            if(nameController.text.isEmpty){
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text(
                                        'the name is empty, please enter your name',
                                        style: TextStyle(
                                          color: Colors.red
                                        ),
                                      ),
                                    );
                                  }
                              );
                            } else if(emailController.text.isEmpty){
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text(
                                        'the email is empty, please enter your email',
                                        style: TextStyle(
                                            color: Colors.red
                                        ),
                                      ),
                                    );
                                  }
                              );
                            } else if(phoneController.text.isEmpty){
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text(
                                        'the email is empty, please enter your email',
                                        style: TextStyle(
                                            color: Colors.red
                                        ),
                                      ),
                                    );
                                  }
                              );
                            } else if(messageController.text.isEmpty){
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text(
                                        'the message is empty, please enter your message',
                                        style: TextStyle(
                                            color: Colors.red
                                        ),
                                      ),
                                    );
                                  }
                              );
                            } else {
                              await FirebaseFirestore.instance.collection('Messages').doc(time).set({
                                'Name': nameController.text,
                                'E-mail': emailController.text,
                                'Phone': phoneController.text,
                                'Message': messageController.text
                              }, SetOptions(merge: true));
                              // Navigator.pushNamed(context, ContactUsPage.id);
                              sendEmail(messageController.text);

                              nameController.clear();
                              emailController.clear();
                              phoneController.clear();
                              messageController.clear();
                            }
                          },
                          child: Text(
                            'Submit',
                            style: TextStyle(color: Colors.green.shade50),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width * .1,
                ),
              ],
            ),
          ),
        )
        );
  }
}

class BluePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Colors.white;
    canvas.drawPath(mainBackground, paint);

    Path ovalPath = Path();
    //top left
    //start point from 20% width to the left
    ovalPath.moveTo(width * .93, 0);
    //paint a curve from current position to middle of the screen
    ovalPath.quadraticBezierTo(width * .95, height * .1, width, height * .1);
    //draw remaining line to bottom left side
    ovalPath.lineTo(width, 0);
    //close line to reset it back
    ovalPath.close();
    paint.color = Colors.green.shade100;
    canvas.drawPath(ovalPath, paint);

    //top right
    ovalPath.moveTo(width*.05, 0);
    //paint a curve from current position to middle of the screen
    ovalPath.quadraticBezierTo(width * .05, height * .1, 0, height * .1);
    //draw remaining line to bottom left side
    ovalPath.lineTo(0, 0);
    //close line to reset it back
    ovalPath.close();
    paint.color = Colors.green.shade100;
    canvas.drawPath(ovalPath, paint);

    //bottom left
    /*ovalPath.moveTo(width * .83, height);
    //paint a curve from current position to middle of the screen
    ovalPath.quadraticBezierTo(width * .85, height * .8, width, height * .8);
    //draw remaining line to bottom left side
    ovalPath.lineTo(width, height);
    //close line to reset it back
    ovalPath.close();
    paint.color = Colors.green.shade100;
    canvas.drawPath(ovalPath, paint);*/
    //bottom right
    ovalPath.moveTo(width * .25, height);
    //paint a curve from current position to middle of the screen
    ovalPath.quadraticBezierTo(width * .23, height * .9, 0, height * .85);
    //draw remaining line to bottom left side
    ovalPath.lineTo(0, height);
    //close line to reset it back
    ovalPath.close();
    paint.color = Colors.green.shade100;
    canvas.drawPath(ovalPath, paint);
  }


  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
