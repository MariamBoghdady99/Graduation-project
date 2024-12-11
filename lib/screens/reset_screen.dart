import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_web_app/used_components/textField_container.dart';
import 'package:my_web_app/used_components/signup_button.dart';
import 'package:my_web_app/screens/log_in_screen.dart';
import 'package:my_web_app/screens/about_us_screen.dart';
import 'package:my_web_app/screens/contact_us_screen.dart';
import 'package:my_web_app/screens/home_screen.dart';
class ResetPassword extends StatefulWidget {

  static String id = 'reset_password_page';

  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  late String _email;
  final _auth = FirebaseAuth.instance;

  Future passwordReset() async {
    try{
      await _auth.sendPasswordResetEmail(email: _email);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Password reset link sent! check your email'),
            );
          }
      );
    } catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.toString()),
            );
          }
      );
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
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: .5*width,
            height: height,
            child: Image.asset('images/password.gif'),
          ),
          Container(
            width: .35*width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFieldContainer(containerColor: Colors.white,
                    onChanged: (value) {
                  _email = value;
                    },
                    iconColor: Colors.grey.shade600,
                    insertedHint: 'insert the confirmed email',
                    insertedIcon: Icons.email),
                SizedBox(height: 10,),
                Container(
                  width: width*.2,
                  child: SignUpBotton(
                      buttonColor: Colors.grey,
                      onPressed: passwordReset,
                      buttonChild: Text(
                        'Reset Password',
                        style: TextStyle(color: Colors.green.shade100),
                      )
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
