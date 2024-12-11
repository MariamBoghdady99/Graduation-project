import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_web_app/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_web_app/screens/user_screens/userPage.dart';
import 'package:my_web_app/screens/principal_screen.dart';
import 'package:my_web_app/screens/sign_in_screen.dart';
import 'package:my_web_app/screens/home_screen.dart';
import 'package:my_web_app/used_components/textField_container.dart';
import 'package:my_web_app/used_components/signup_button.dart';
import 'package:my_web_app/constants.dart';
import 'package:my_web_app/screens/reset_screen.dart';
import 'package:my_web_app/used_components/password_textField_container.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_web_app/screens/about_us_screen.dart';
import 'package:my_web_app/screens/contact_us_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_web_app/screens/show_guests.dart';

class LogInPage extends StatefulWidget {
  static String id = 'log_in_screen';

  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _auth = FirebaseAuth.instance;

  late String email;
  late String password;
  bool showPassword = true;

  bool _isLoading = false;

  Future<void> _googleSignIn() async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          await _auth.signInWithCredential(GoogleAuthProvider.credential(
              idToken: googleAuth.idToken,
              accessToken: googleAuth.accessToken));
          Navigator.pushNamed(context, ShowGuests.id);
        } on FirebaseException catch (e) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(
                    e.toString(),
                    style: TextStyle(color: Colors.red),
                  ),
                );
              });
        }
      }
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
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, HomePage.id);
              },
              child: Text(
                'Home',
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
      body: Container(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: .35*width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Log in to your Account',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.green.shade600),
                  ),
                  SizedBox(height:height*.1),
                  TextFieldContainer(
                      containerColor: Colors.white,
                      insertedtype: TextInputType.emailAddress,
                      onChanged: (value) {
                        email = value;
                      },
                      iconColor: Colors.grey.shade600,
                      insertedHint: 'Email',
                      insertedIcon: Icons.email),
                  SizedBox(
                    height: 15,
                  ),
                  PasswordTextFieldContainer(
                      containerColor: Colors.white,
                      onChanged: (value) {
                        password = value;
                      },
                      obscureText: showPassword,
                      iconColor: Colors.grey.shade600,
                      insertedHint: "Password",
                      insertedIcon: Icons.vpn_key,
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
                      }),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: .2*width,
                    child: SignUpBotton(
                      buttonColor: Colors.grey,
                      onPressed: () async {
                        try {
                          final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                          if (user != null ) {
                            final docsIDs = await FirebaseFirestore.instance.collection('Guests').get().then(
                                    (value) => value.docs.map((e) => e.id).toList());
                            print(docsIDs);
                            if(docsIDs.contains(password)){
                              var userData  = FirebaseFirestore.instance.collection('Guests').doc(password);
                              DocumentSnapshot data = await userData.get();
                              final finalData = data.data() as Map<String, dynamic>;

                              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                  UserPage(theDocID: password, theGuestData: finalData,)));
                            } else {
                              Navigator.pushNamed(context, ShowGuests.id);
                            }
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text(
                                      'No user found for that email.',
                                      style: TextStyle(
                                          color: Colors.red
                                      ),),
                                  );
                                }
                            );
                          } else if (e.code == 'wrong-password') {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text(
                                      'Wrong password provided for that user.',
                                      style: TextStyle(
                                          color: Colors.red
                                      ),),
                                  );
                                }
                            );
                          }
                        }
                        catch (e) {
                          print(e);
                        }
                      },
                      buttonChild: Text(
                        "Log In",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.green.shade100,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, ResetPassword.id);
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?",style: TextStyle(color: Colors.grey.shade800,)),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, SignUpPage.id);
                        },
                        child: Container(
                          child: Text("Register now",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green.shade600)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: .1*width),
            Container(
              width: .5*width,
              height: height,
              child: Image.asset('images/login.jpg'),
            ),
          ],
        ),
      ),
    );
  }
}
