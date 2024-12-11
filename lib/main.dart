import 'package:flutter/material.dart';
import 'package:my_web_app/screens/doctor_details.dart';
import 'package:my_web_app/screens/editGuest/edit_drugs_data.dart';
import 'package:my_web_app/screens/home_screen.dart';
import 'package:my_web_app/screens/about_us_screen.dart';
import 'package:my_web_app/screens/add_guest.dart';
import 'package:my_web_app/screens/show_doctors.dart';
import 'package:my_web_app/screens/contact_us_screen.dart';
import 'package:my_web_app/screens/log_in_screen.dart';
import 'package:my_web_app/screens/principal_screen.dart';
import 'package:my_web_app/screens/sign_in_screen.dart';
import 'package:my_web_app/screens/show_guests.dart';
import 'package:my_web_app/screens/drug_screen.dart';
import 'package:my_web_app/screens/guest_details.dart';
import 'package:my_web_app/screens/doctor_details.dart';
import 'package:my_web_app/screens/show_doctors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_web_app/screens/user_screens/user_doctor.dart';
import 'firebase_options.dart';
import 'package:my_web_app/screens/reset_screen.dart';
import 'package:my_web_app/screens/editGuest/edit_personal_data.dart';
import 'package:my_web_app/screens/editGuest/edit_specific_relative.dart';
import 'package:my_web_app/screens/editGuest/edit_relative_data.dart';
import 'package:my_web_app/screens/editGuest/add_new_relative.dart';
import 'package:my_web_app/screens/editGuest/add_new_drug.dart';
import 'package:my_web_app/screens/editGuest/edit_drugs_data.dart';
import 'package:my_web_app/screens/user_screens/userPage.dart';
import 'package:my_web_app/screens/editGuest/add_new_doctor.dart';
import 'package:my_web_app/screens/editGuest/edit_doctors_data.dart';
import 'package:my_web_app/screens/editGuest/edit_specific_doctor.dart';
import 'package:my_web_app/screens/api_Screens/first_page.dart';
import 'package:my_web_app/screens/edit_doctor.dart';
import 'package:my_web_app/screens/user_screens/user_drugs.dart';
import 'package:my_web_app/screens/user_screens/user_drugs.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
int sval = 1;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var period =  Duration(minutes: 1, );
  Timer.periodic(period,(arg) async{
    print(sval);
    await function();
    // print(data);
  }
  );
  runApp(const WebApp());
}

class WebApp extends StatelessWidget {
  const WebApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
        // backgroundColor: Colors.brown[100],
        textTheme: TextTheme(
          bodyText1:TextStyle(color: Colors.blueGrey.shade700),
          // bodyText2: TextStyle(color: Colors.green[900]),
        ),
      ),

      initialRoute: ShowGuests.id,

      routes: {
        HomePage.id: (context) => HomePage(),
        AboutUsPage.id: (context) => AboutUsPage(),
        ContactUsPage.id : (context) => ContactUsPage(),
        LogInPage.id: (context) =>LogInPage(),
        SignUpPage.id: (context) => SignUpPage(),
        PrincipalPage.id : (context) => PrincipalPage(), // no need
        AddGuest.id :(context) => AddGuest(),
        ShowDoctors.id : (context) => ShowDoctors(),
        ShowGuests.id : (context) => ShowGuests(),
        DrugsSheet.id : (context) =>DrugsSheet(),
        ShowDoctors.id : (context) => ShowDoctors(),
        GuestDetails.id : (context) => GuestDetails(guestDetails: { }, docId: '',),
        ResetPassword.id : (context) =>ResetPassword(),
        DoctorDetails.id : (context) => DoctorDetails(doctorDetails: { },),
        PersonalEdit.id: (context) =>PersonalEdit(personalData: { }, docID: ''),
        RelativeEdit.id: (context) =>RelativeEdit(docID: ''),
        EditThisRelative.id: (context) => EditThisRelative(theirRelative: {}, DocItem: '', ItemId: ''),
        NewRelative.id: (context) => NewRelative(itemId: ''),
        NewDrug.id: (context) => NewDrug(ItemId: ''),
        DrugsData.id: (context) => DrugsData(docId: ''),
        UserPage.id: (context) => UserPage(theDocID: '', theGuestData: { },),
        FirstPage.id:(context)=> FirstPage(docID: '',),
        NewDoctor.id:(context)=>NewDoctor(ItemId: ''),
        EditThisDoctor.id:(context)=>EditThisDoctor(thisDoctor: { }, GuestDoctorID: '', GuestID: ''),
        DoctorsData.id:(context) =>DoctorsData(docId: ''),
        UserDrugs.id: (context) => UserDrugs(userID: '', userData: {}),
        UserDoctors.id: (context) => UserDoctors(userID: '', userData: {})
      },
    );
  }
}
