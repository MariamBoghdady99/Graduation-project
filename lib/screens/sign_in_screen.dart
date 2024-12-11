import 'package:flutter/material.dart';
import 'package:my_web_app/constants/constants.dart';
import 'package:my_web_app/screens/principal_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_web_app/screens/user_screens/userPage.dart';
import 'package:my_web_app/screens/log_in_screen.dart';
import 'package:my_web_app/screens/about_us_screen.dart';
import 'package:my_web_app/screens/contact_us_screen.dart';
import 'package:my_web_app/screens/home_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_web_app/components_widgets/sign_in_with_google.dart';
import 'package:my_web_app/used_components/main_Button.dart';
import 'package:my_web_app/used_components/textField_container.dart';
import 'package:my_web_app/used_components/signup_button.dart';
import 'package:my_web_app/used_components/password_textField_container.dart';
import 'package:my_web_app/screens/show_guests.dart';

class SignUpPage extends StatefulWidget {
  static String id = 'sign_up_screen';

  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  late String email;
  late String password;
  late String userName;
  late String imageUrl;

  bool showPassword = true;

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
        leadingWidth: 200,
        leading: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Row(
                children: [
                  SizedBox(
                    child: Image.asset('images/OIG.png'),
                  ),
                  Text(
                    'CURA',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            )),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // SizedBox(
            //   width: 100,
            // ),
            TextButton(
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
              onPressed: () {
                Navigator.pushNamed(context, ContactUsPage.id);
              },
              child: Text(
                'Contact Us',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 0.5 * width,
                  height: height,
                  child: Image.asset('images/signup.gif'),
                ),
                //The Username,Email,Password Input fields.
                SizedBox(width: .1*width),
                Container(
                  width: width * .35,
                  child: Column(
                    children: [
                      Text(
                        'Sign UP To CURA',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.green.shade600),
                      ),
                      SizedBox(height:height*.1),
                      TextFieldContainer(
                          containerColor: Colors.white,
                          insertedtype: TextInputType.text,
                          onChanged: (value) {
                            userName = value;
                          },
                          iconColor: Colors.grey.shade600,
                          insertedHint: 'Please Enter Your Username',
                          insertedIcon: Icons.supervised_user_circle),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFieldContainer(
                          containerColor: Colors.white,
                          insertedtype: TextInputType.emailAddress,
                          onChanged: (value) {
                            email = value;
                          },
                          iconColor: Colors.grey.shade600,
                          insertedHint: 'Please Enter Your Email',
                          insertedIcon: Icons.email),
                      PasswordTextFieldContainer(
                          containerColor: Colors.white,
                          obscureText: showPassword,
                          onChanged: (value) {
                            password = value;
                          },
                          iconColor: Colors.grey.shade600,
                          insertedHint: 'Please Enter Your Password',
                          insertedIcon: Icons.password,
                          iconFunction: () {
                            if (showPassword == true) {
                              setState(() {
                                showPassword = false;
                              });
                            } else {
                              setState(() {
                                showPassword = true;
                              });
                            }
                          }
                          ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        width: .2*width,
                        child: SignUpBotton(
                          buttonColor: Colors.grey,
                          onPressed: () async {
                            try{
                              final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                              if(newUser != null){
                                final docsIDs = await FirebaseFirestore.instance.collection('Guests').get().then(
                                        (value) => value.docs.map((e) => e.id).toList());
                                print(docsIDs);
                                var userData  = FirebaseFirestore.instance.collection('Guests').doc(password);
                                DocumentSnapshot data = await userData.get();
                                final finalData = data.data() as Map<String, dynamic>;
                                if(docsIDs.contains(password)){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                      UserPage(theDocID: password, theGuestData: finalData,)));
                                } else {
                                  Navigator.pushNamed(context, PrincipalPage.id);
                                }
                              }
                            } on FirebaseException catch (e) {
                              print(e);
                              if(e.code == 'weak-password'){
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text(
                                          'The password provided is too weak.',
                                          style: TextStyle(
                                              color: Colors.red
                                          ),
                                        ),
                                      );
                                    }
                                );
                              } else if(e.code == 'email-already-in-use'){
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text(
                                          'The account already exists for that email.',
                                          style: TextStyle(
                                              color: Colors.red
                                          ),
                                        ),
                                      );
                                    }
                                );
                              }
                            }
                          },
                          buttonChild: Text(
                            'Sign up',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.green.shade100,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        width: .2*width,
                        child: SignUpBotton(
                          buttonColor: Colors.grey,
                          onPressed: () {},
                          buttonChild: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Sign Up With",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.green.shade100,
                                    fontWeight: FontWeight.w700),
                              ),
                              Image.asset(
                                'images/google.png',
                                height: 20,
                                width: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have an account?', style: TextStyle(color: Colors.grey.shade800)),
                          SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, LogInPage.id);
                            },
                            child: Container(
                              child: Text(
                                'Log in',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.green.shade600,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
