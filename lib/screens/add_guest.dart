//import 'dart:io';
import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_web_app/components_widgets/sign_in_with_google.dart';
import 'package:my_web_app/constants/constants.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:my_web_app/screens/show_guests.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker_web/image_picker_web.dart';
import 'dart:html';
import 'package:path/path.dart' as Path;
import 'package:mime_type/mime_type.dart';
import 'package:my_web_app/components_widgets/guestImage.dart';
import 'package:my_web_app/screens/principal_screen.dart';
import 'package:my_web_app/screens/drug_screen.dart';
import 'package:curved_drawer_fork/curved_drawer_fork.dart';
import 'package:my_web_app/screens/show_guests.dart';
import 'package:my_web_app/screens/show_doctors.dart';
import 'package:my_web_app/screens/home_screen.dart';

late User loggedInUser;


class AddGuest extends StatefulWidget {

  static String id = 'add_guest';

  const AddGuest({Key? key}) : super(key: key);

  @override
  State<AddGuest> createState() => _AddGuestState();
}
final controllerName = TextEditingController();
final controllerAge = TextEditingController();
final controllerDate = TextEditingController();
final controllerRoomNumber = TextEditingController();
final controllerDrugName = TextEditingController();
final controllerDrugSerialNumber = TextEditingController();
final controllerDrugDose = TextEditingController();
final controllerDrugImage = TextEditingController();
final controllerRelativeName = TextEditingController();
final controllerRelativeRelationship = TextEditingController();
final controllerRelativeContacts = TextEditingController();
final controllerDoctorName = TextEditingController();
final controllerDoctorSpecialist = TextEditingController();
final controllerDoctorAddress = TextEditingController();
final controllerDoctorContacts = TextEditingController();
final controllerRelativeNN = TextEditingController();
//final controllerDrugDose = TextEditingController();

class _AddGuestState extends State<AddGuest> {


  late String name;
  late String guestImage;
  late String id;
  late String gender;
  late String age;
  late String roomNumber;

  late String drugName;
  late String drugSerialNumber;
  late String drugImage;
  late String drugDose;

  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  final textFieldControl = TextEditingController();

  String message = 'no one added';
  String imageMessage = 'Please upload the drug image';
  String initialImage = ('https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png').toString();
  String imageUrl = '';
  String relativeImage =('https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png').toString();
  List drugNameList = [];
  List drugSerialNumberList = [];
  List drugImageList = [];
  List drugDoseList = [];
  List relativeNameList = [];
  List relativeRelationList = [];
  List relativeContacts = [];
  List relativeNN = [];
  List relativeImageList = [];
  List doctorNameList = [];
  List doctorAddressList = [];
  List doctorSpecialistList = [];
  List doctorContactList = [];
  int _value = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void getTheUser () async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    }catch(e){
      print(e);
    }
  }
  int index = 1;
  double leftWidth = 75.0;
  int leftTextColor = 1;
  int leftBackgroundColor = 0;
  final List<Color> colorPallete = <Color>[
    Colors.brown.shade50,
    Colors.cyan.shade900,
  ];
  signOut() async {
    await _auth.signOut();
    Navigator.pushNamed(context, HomePage.id);
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            TextButton(
              onPressed: (){
                Navigator.pushNamed(context, ShowGuests.id);
              },
              child: Text('Guests',style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 16),),
            ),
            SizedBox(width: 10.0,),
            TextButton(
              onPressed: (){
                Navigator.pushNamed(context, ShowDoctors.id);
              },
              child: Text('Doctors',style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 16),),
            ),
            SizedBox(width: 10.0,),
            TextButton(
              onPressed: (){
                Navigator.pushNamed(context, DrugsSheet.id);
              },
              child: Text('Drugs',style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 16),),
            ),
            SizedBox(width: 10.0,),
            SizedBox(width: 10.0,),
            SizedBox(
              height: 60.0,
              child: TextButton(
                // style: TextButton.styleFrom(backgroundColor: Colors.grey.shade600,),
                onPressed: (){
                  // Navigator.pushNamed(context, AddGuest.id);
                },
                child: Text('Add Guest',style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 20.0),),
              ),
            ),
          ],),
        actions: [
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    signOut();
                  },
                  child: Row(
                    children: [
                      Text(
                        'SignOut',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                        ),
                      ),
                      Icon(
                        Icons.logout_outlined,
                        color: Colors.green,
                      ),
                    ],
                  )),
              Container(width: .05*width,),
            ],
          ),
        ],
      ),
      body: CustomPaint(
        painter: addPainter(),
        child: Row(
          children: [
            Container(
              width: .4*width,
              child: Image.asset('images/fillOut.gif'),
            ),
            Container(
              width:.6*width,
              child: ListView(
                padding: EdgeInsets.all(16),
                children:  [
                  Container(
                    width: width*.5,
                    padding: EdgeInsets.all(10),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            // topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                            bottomLeft:Radius.circular(40),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        labelText: 'Guest Info',
                        floatingLabelStyle:
                        MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                          final Color color = states.contains(MaterialState.error)
                              ? Theme.of(context).colorScheme.error
                              : Colors.brown.shade900;
                          return TextStyle(color: color, letterSpacing: 1.3);
                        }),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(initialImage),
                                    minRadius: 40,
                                    maxRadius: 50,
                                  ),
                                  SizedBox(height: 5,),
                                  ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        shape: StadiumBorder(),
                                        primary: Colors.grey[600],
                                        onPrimary: Colors.white,
                                        onSurface: Colors.grey,
                                      ),
                                      onPressed: () async {
                                        final picker = ImagePicker();
                                        final PickedFile? image = await picker.getImage(source: ImageSource.gallery);
                                        String name = 'Image-${DateTime.now()}';
                                        Uint8List? bytes = await image?.readAsBytes();
                                        Reference ref = FirebaseStorage.instance.ref().child('${name}.png');
                                        UploadTask uploadTask = ref.putData(bytes!, SettableMetadata(contentType: 'image/png'));

                                        TaskSnapshot taskSnapshot = await uploadTask
                                            .whenComplete(() {
                                          print('done');
                                        })
                                            .catchError((error) => print('something went wrong'));
                                        String url = await taskSnapshot.ref.getDownloadURL();
                                        if(url.isEmpty){
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('Please upload an image')));
                                        }
                                        //drugImageList.add(url);
                                        setState(() {
                                          initialImage = url;
                                        });
                                      },
                                      icon: Icon(Icons.cloud_upload_rounded),
                                      label: Text('upload image',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),)
                                  ),
                                ],
                              ),
                              SizedBox(width: 30),
                              Expanded(
                                child: TextField(
                                  controller: controllerName,
                                  onChanged: (value) {
                                    name = value;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                        bottomLeft:Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                    labelText: 'Please Enter The Guest Name',
                                    floatingLabelStyle:
                                    MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                                      final Color color = states.contains(MaterialState.error)
                                          ? Theme.of(context).colorScheme.error
                                          : Colors.brown.shade900;
                                      return TextStyle(color: color, letterSpacing: 1.3);
                                    }),
                                    labelStyle:
                                    MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                                      final Color color = states.contains(MaterialState.error)
                                          ? Theme.of(context).colorScheme.error
                                          : Colors.brown.shade800;
                                      return TextStyle(color: color, letterSpacing: 1.3);
                                    }),

                                  ),
                                  style: TextStyle(color:Colors.brown.shade900),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    width: width*.5*.5,
                                    child: TextField(
                                      controller: controllerAge,
                                      //editing controller of this TextField
                                      decoration: InputDecoration(
                                        icon: Icon(Icons.calendar_today), //icon of text field
                                        labelText: "Enter Date", //label text of field
                                        floatingLabelStyle:MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                                          final Color color = states.contains(MaterialState.error)
                                              ? Theme.of(context).colorScheme.error
                                              : Colors.brown.shade900;
                                          return TextStyle(color: color, letterSpacing: 1.3);
                                        }),
                                        labelStyle:MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                                          final Color color = states.contains(MaterialState.error)
                                              ? Theme.of(context).colorScheme.error
                                              : Colors.brown.shade800;
                                          return TextStyle(color: color, letterSpacing: 1.3);
                                        }),

                                      ),
                                      style: TextStyle(color:Colors.brown.shade900),
                                      readOnly: true,
                                      //set it true, so that user will not able to edit text
                                      onTap: () async {
                                        DateTime? pickedDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1920),
                                            //DateTime.now() - not to allow to choose before today.
                                            lastDate: DateTime(2025));

                                        if (pickedDate != null) {
                                          print(
                                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                          String formattedDate =
                                          DateFormat('yyyy-MM-dd').format(pickedDate);
                                          print(
                                              formattedDate); //formatted date output using intl package =>  2021-03-16
                                          setState(() {
                                            controllerAge.text =
                                                formattedDate; //set output date to TextField value.
                                          });
                                        } else {}
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  SizedBox(
                                    width: width*.5*.5,
                                    child: TextField(
                                      controller: controllerRoomNumber,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            topLeft: Radius.circular(20),
                                            bottomLeft:Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          ),
                                        ),
                                        labelText: 'Room number ',
                                        floatingLabelStyle:
                                        MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                                          final Color color = states.contains(MaterialState.error)
                                              ? Theme.of(context).colorScheme.error
                                              : Colors.brown.shade900;
                                          return TextStyle(color: color, letterSpacing: 1.3);
                                        }),
                                        labelStyle:
                                        MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                                          final Color color = states.contains(MaterialState.error)
                                              ? Theme.of(context).colorScheme.error
                                              : Colors.brown.shade800;
                                          return TextStyle(color: color, letterSpacing: 1.3);
                                        }),

                                      ),
                                      style: TextStyle(color:Colors.brown.shade900),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: width*.5*.08,),
                              Column(
                                children: [
                                  Container(
                                    width: width*.1*.5,
                                    // height: height*.3,
                                    child: Image.asset('images/male.jpg'),
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                        value: 1,
                                        groupValue: _value,
                                        onChanged: (value){
                                          setState(() {
                                            _value = value!;
                                            gender = 'Male';
                                          });
                                        },
                                      ),
                                      // SizedBox(width: 10,),
                                      AutoSizeText('Male',
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
                                        minFontSize: 5,
                                        maxFontSize: 15,
                                        style: TextStyle(
                                            // fontSize: 15.0,
                                            color:Colors.grey.shade800
                                        ),),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(width: 15,),
                              Column(
                                children: [
                                  Container(
                                    width: width*.5*.1,
                                    child: Image.asset('images/famale.jpg'),
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                        value: 2,
                                        groupValue: _value,
                                        onChanged: (value){
                                          setState(() {
                                            _value = value!;
                                            gender = 'Female';
                                          });
                                        },
                                      ),
                                      SizedBox(width: 10.0,),
                                      AutoSizeText('Female',
                                        maxLines: 5,
                                        overflow: TextOverflow.clip,
                                        minFontSize: 5,
                                        maxFontSize: 15,
                                        style: TextStyle(
                                          // fontSize: 15.0,
                                          color:Colors.grey.shade800,
                                        ),),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // SizedBox(width: 10,),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            bottomLeft:Radius.circular(40),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        labelText: 'Relatives Info',
                        floatingLabelStyle:
                        MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                          final Color color = states.contains(MaterialState.error)
                              ? Theme.of(context).colorScheme.error
                              : Colors.brown.shade900;
                          return TextStyle(color: color, letterSpacing: 1.3);
                        }),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(relativeImage),
                                    minRadius: 40,
                                    maxRadius: 50,
                                  ),
                                  SizedBox(height: 5,),
                                  ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        shape: StadiumBorder(),
                                        primary: Colors.grey[600],
                                        onPrimary: Colors.white,
                                        onSurface: Colors.grey,
                                      ),
                                      onPressed: () async {
                                        final picker = ImagePicker();
                                        final PickedFile? image = await picker.getImage(source: ImageSource.gallery);
                                        String name = 'Image-${DateTime.now()}';
                                        Uint8List? bytes = await image?.readAsBytes();
                                        Reference ref = FirebaseStorage.instance.ref().child('${name}.png');
                                        UploadTask uploadTask = ref.putData(bytes!, SettableMetadata(contentType: 'image/png'));

                                        TaskSnapshot taskSnapshot = await uploadTask
                                            .whenComplete(() {
                                          print('done');
                                        })
                                            .catchError((error) => print('something went wrong'));
                                        String url = await taskSnapshot.ref.getDownloadURL();
                                        if(url.isEmpty){
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('Please upload an image')));
                                        }
                                        //drugImageList.add(url);
                                        setState(() {
                                          relativeImage = url;
                                        });
                                      },
                                      icon: Icon(Icons.cloud_upload_rounded),
                                      label: Text('upload image',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),)
                                  ),
                                ],
                              ),
                              SizedBox(width: 10,),
                              Column(
                                children: [
                                  SizedBox(
                                    width: width*.25,
                                    height: 50,
                                    child: TextField(
                                      controller: controllerRelativeName,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            topLeft: Radius.circular(20),
                                            bottomLeft:Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          ),
                                        ),
                                        labelText: 'Name ',
                                        floatingLabelStyle:
                                        MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                                          final Color color = states.contains(MaterialState.error)
                                              ? Theme.of(context).colorScheme.error
                                              : Colors.brown.shade900;
                                          return TextStyle(color: color, letterSpacing: 1.3);
                                        }),
                                        labelStyle:
                                        MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                                          final Color color = states.contains(MaterialState.error)
                                              ? Theme.of(context).colorScheme.error
                                              : Colors.brown.shade800;
                                          return TextStyle(color: color, letterSpacing: 1.3);
                                        }),
                                      ),
                                      style: TextStyle(color:Colors.brown.shade900),
                                    ),
                                  ),
                                  SizedBox(height: 15,),
                                  SizedBox(
                                    width: width*.25,
                                    height: 50,
                                    child: TextField(
                                      controller: controllerRelativeRelationship,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            topLeft: Radius.circular(20),
                                            bottomLeft:Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          ),
                                        ),
                                        labelText: 'The Relationship ',
                                        floatingLabelStyle:
                                        MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                                          final Color color = states.contains(MaterialState.error)
                                              ? Theme.of(context).colorScheme.error
                                              : Colors.brown.shade900;
                                          return TextStyle(color: color, letterSpacing: 1.3);
                                        }),
                                        labelStyle:
                                        MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                                          final Color color = states.contains(MaterialState.error)
                                              ? Theme.of(context).colorScheme.error
                                              : Colors.brown.shade800;
                                          return TextStyle(color: color, letterSpacing: 1.3);
                                        }),
                                      ),
                                      style: TextStyle(color:Colors.brown.shade900),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 10,),
                            ],
                          ),
                          SizedBox(height: 15,),
                          SizedBox(
                            width: (width-110)*.5,
                            height: 50,
                            child: TextField(
                              controller: controllerRelativeNN,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                    bottomLeft:Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                ),
                                labelText: 'National Number',
                                floatingLabelStyle:
                                MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                                  final Color color = states.contains(MaterialState.error)
                                      ? Theme.of(context).colorScheme.error
                                      : Colors.brown.shade900;
                                  return TextStyle(color: color, letterSpacing: 1.3);
                                }),
                                labelStyle:
                                MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                                  final Color color = states.contains(MaterialState.error)
                                      ? Theme.of(context).colorScheme.error
                                      : Colors.brown.shade800;
                                  return TextStyle(color: color, letterSpacing: 1.3);
                                }),

                              ),
                              style: TextStyle(color:Colors.brown.shade900),
                            ),
                          ),
                          SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: (width-110)*.5,
                                height: 50,
                                child: TextField(
                                  controller: controllerRelativeContacts,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                        bottomLeft:Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                    labelText: 'The contacts (Separate them by (as 01.. - 01..) ) ',
                                    floatingLabelStyle:
                                    MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                                      final Color color = states.contains(MaterialState.error)
                                          ? Theme.of(context).colorScheme.error
                                          : Colors.brown.shade900;
                                      return TextStyle(color: color, letterSpacing: 1.3);
                                    }),
                                    labelStyle:
                                    MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                                      final Color color = states.contains(MaterialState.error)
                                          ? Theme.of(context).colorScheme.error
                                          : Colors.brown.shade800;
                                      return TextStyle(color: color, letterSpacing: 1.3);
                                    }),

                                  ),
                                  style: TextStyle(color:Colors.brown.shade900),
                                ),
                              ),
                              SizedBox(
                                width:60,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: StadiumBorder(),
                                    primary: Colors.grey[600],
                                    onPrimary: Colors.white,
                                    onSurface: Colors.grey,
                                  ),
                                  onPressed: (){
                                    relativeNameList.add(controllerRelativeName.text);
                                    relativeRelationList.add(controllerRelativeRelationship.text);
                                    relativeContacts.add(controllerRelativeContacts.text);
                                    relativeNN.add(controllerRelativeNN.text);
                                    relativeImageList.add(relativeImage);

                                    controllerRelativeName.clear();
                                    controllerRelativeRelationship.clear();
                                    controllerRelativeContacts.clear();
                                    controllerRelativeNN.clear();
                                    setState(() {
                                      relativeImage =('https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png').toString();
                                    });
                                  },
                                  child: Text(
                                    'add',
                                  ),
                                ),
                              ),
                              SizedBox(width:10,),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24,),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            // topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                            bottomLeft:Radius.circular(40),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        labelText: 'Drugs Info',
                        floatingLabelStyle:
                        MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                          final Color color = states.contains(MaterialState.error)
                              ? Theme.of(context).colorScheme.error
                              : Colors.brown.shade900;
                          return TextStyle(color: color, letterSpacing: 1.3);
                        }),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 400,
                                height: 50,
                                child: TextField(
                                  controller: controllerDrugName,
                                  onChanged: (value){
                                    drugName = value;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                        bottomLeft:Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                    labelText: 'Drug Name',
                                    floatingLabelStyle:
                                    MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                                      final Color color = states.contains(MaterialState.error)
                                          ? Theme.of(context).colorScheme.error
                                          : Colors.brown.shade900;
                                      return TextStyle(color: color, letterSpacing: 1.3);
                                    }),
                                    labelStyle:
                                    MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                                      final Color color = states.contains(MaterialState.error)
                                          ? Theme.of(context).colorScheme.error
                                          : Colors.brown.shade800;
                                      return TextStyle(color: color, letterSpacing: 1.3);
                                    }),
                                  ),
                                  style: TextStyle(color:Colors.brown.shade900),
                                ),
                              ),
                              SizedBox(height: 15,),
                              SizedBox(
                                width: 400,
                                height: 50,
                                child: TextField(
                                  onChanged: (value) {
                                    drugSerialNumber = value;
                                  },
                                  controller: controllerDrugSerialNumber,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                        bottomLeft:Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                    labelText: 'Drug Serial Number',
                                    floatingLabelStyle:
                                    MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                                      final Color color = states.contains(MaterialState.error)
                                          ? Theme.of(context).colorScheme.error
                                          : Colors.brown.shade900;
                                      return TextStyle(color: color, letterSpacing: 1.3);
                                    }),
                                    labelStyle:
                                    MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                                      final Color color = states.contains(MaterialState.error)
                                          ? Theme.of(context).colorScheme.error
                                          : Colors.brown.shade800;
                                      return TextStyle(color: color, letterSpacing: 1.3);
                                    }),

                                  ),
                                  style: TextStyle(color:Colors.brown.shade900),
                                ),
                              ),
                              SizedBox(height: 15,),
                              SizedBox(
                                width: 400,
                                height: 50,
                                child: TextField(
                                  onChanged: (value) {
                                    drugDose = value;
                                  },
                                  controller: controllerDrugDose,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                        bottomLeft:Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                    labelText: 'Drug Dose',
                                    floatingLabelStyle:
                                    MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                                      final Color color = states.contains(MaterialState.error)
                                          ? Theme.of(context).colorScheme.error
                                          : Colors.brown.shade900;
                                      return TextStyle(color: color, letterSpacing: 1.3);
                                    }),
                                    labelStyle:
                                    MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                                      final Color color = states.contains(MaterialState.error)
                                          ? Theme.of(context).colorScheme.error
                                          : Colors.brown.shade800;
                                      return TextStyle(color: color, letterSpacing: 1.3);
                                    }),

                                  ),style: TextStyle(color:Colors.brown.shade900),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    shape: StadiumBorder(),
                                    primary: Colors.grey[600],
                                    onPrimary: Colors.white,
                                    onSurface: Colors.grey,
                                  ),
                                  onPressed: () async {
                                    final picker = ImagePicker();
                                    final PickedFile? image = await picker.getImage(source: ImageSource.gallery);
                                    String name = 'Image-${DateTime.now()}';
                                    Uint8List? bytes = await image?.readAsBytes();
                                    Reference ref = FirebaseStorage.instance.ref().child('${name}.png');
                                    UploadTask uploadTask = ref.putData(bytes!, SettableMetadata(contentType: 'image/png'));

                                    TaskSnapshot taskSnapshot = await uploadTask
                                        .whenComplete(() {
                                      print('done');
                                    })
                                        .catchError((error) => print('something went wrong'));
                                    String url = await taskSnapshot.ref.getDownloadURL();
                                    if(url.isEmpty){
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('Please upload an image')));
                                    }
                                    drugImageList.add(url);
                                    setState(() {
                                      imageMessage = '${name}.png is uploaded';
                                    });
                                  },
                                  icon: Icon(Icons.cloud_upload_rounded),
                                  label: Text(
                                    'Upload Image',
                                  ),
                                ),
                                Container(
                                  // width: 200,
                                  height: 100,
                                  child: Text(imageMessage,style:TextStyle(color:Colors.brown.shade800)),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: StadiumBorder(),
                                    primary: Colors.grey[600],
                                    onPrimary: Colors.white,
                                    onSurface: Colors.grey,
                                  ),
                                  onPressed: (){
                                    drugNameList.add(controllerDrugName.text);
                                    drugSerialNumberList.add(controllerDrugSerialNumber.text);
                                    drugDoseList.add(controllerDrugDose.text);

                                    controllerDrugName.clear();
                                    controllerDrugSerialNumber.clear();
                                    controllerDrugDose.clear();
                                    print('$drugName is saved');

                                    setState(() {
                                      imageMessage = 'upload another Image';
                                    });
                                  },
                                  child: Text(
                                    'add',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: width*.03,),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24,),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            // topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                            bottomLeft:Radius.circular(40),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        labelText: 'Doctors Info',
                        floatingLabelStyle:
                        MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                          final Color color = states.contains(MaterialState.error)
                              ? Theme.of(context).colorScheme.error
                              : Colors.brown.shade900;
                          return TextStyle(color: color, letterSpacing: 1.3);
                        }),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: width*.25,
                                height: 50,
                                child: TextField(
                                  controller: controllerDoctorName,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                        bottomLeft:Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                    labelText: 'Doctor Name ',
                                    floatingLabelStyle:
                                    MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                                      final Color color = states.contains(MaterialState.error)
                                          ? Theme.of(context).colorScheme.error
                                          : Colors.brown.shade900;
                                      return TextStyle(color: color, letterSpacing: 1.3);
                                    }),
                                    labelStyle:
                                    MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                                      final Color color = states.contains(MaterialState.error)
                                          ? Theme.of(context).colorScheme.error
                                          : Colors.brown.shade800;
                                      return TextStyle(color: color, letterSpacing: 1.3);
                                    }),

                                  ),
                                  style: TextStyle(color:Colors.brown.shade900),
                                ),
                              ),
                              // SizedBox(width: 10,),
                              SizedBox(
                                width: width*.25,
                                height: 50,
                                child: TextField(
                                  controller: controllerDoctorSpecialist,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                        bottomLeft:Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                    labelText: 'The Speciality ',
                                    floatingLabelStyle:
                                    MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                                      final Color color = states.contains(MaterialState.error)
                                          ? Theme.of(context).colorScheme.error
                                          : Colors.brown.shade900;
                                      return TextStyle(color: color, letterSpacing: 1.3);
                                    }),
                                    labelStyle:
                                    MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                                      final Color color = states.contains(MaterialState.error)
                                          ? Theme.of(context).colorScheme.error
                                          : Colors.brown.shade800;
                                      return TextStyle(color: color, letterSpacing: 1.3);
                                    }),

                                  ),style: TextStyle(color:Colors.brown.shade900),
                                ),
                              ),
                              SizedBox(width: 10,),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: width*.3,
                                height: 50,
                                child: TextField(
                                  controller: controllerDoctorAddress,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                        bottomLeft:Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                    labelText: 'The Address ',
                                    floatingLabelStyle:
                                    MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                                      final Color color = states.contains(MaterialState.error)
                                          ? Theme.of(context).colorScheme.error
                                          : Colors.brown.shade900;
                                      return TextStyle(color: color, letterSpacing: 1.3);
                                    }),
                                    labelStyle:
                                    MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                                      final Color color = states.contains(MaterialState.error)
                                          ? Theme.of(context).colorScheme.error
                                          : Colors.brown.shade800;
                                      return TextStyle(color: color, letterSpacing: 1.3);
                                    }),

                                  ),
                                  style: TextStyle(color:Colors.brown.shade900),
                                ),

                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: (width-110)*.5,
                                height: 50,
                                child: TextField(
                                  controller: controllerDoctorContacts,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                        bottomLeft:Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                    labelText: 'The contacts (Separate them by (as add1.. - add1..) ) ',
                                    floatingLabelStyle:
                                    MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                                      final Color color = states.contains(MaterialState.error)
                                          ? Theme.of(context).colorScheme.error
                                          : Colors.brown.shade900;
                                      return TextStyle(color: color, letterSpacing: 1.3);
                                    }),
                                    labelStyle:
                                    MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                                      final Color color = states.contains(MaterialState.error)
                                          ? Theme.of(context).colorScheme.error
                                          : Colors.brown.shade800;
                                      return TextStyle(color: color, letterSpacing: 1.3);
                                    }),

                                  ),
                                  style: TextStyle(color:Colors.brown.shade900),
                                ),
                              ),
                              SizedBox(
                                width: 60,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: StadiumBorder(),
                                    primary: Colors.grey[600],
                                    onPrimary: Colors.white,
                                    onSurface: Colors.grey,
                                  ),
                                  onPressed: (){
                                    doctorNameList.add(controllerDoctorName.text);
                                    doctorSpecialistList.add(controllerDoctorSpecialist.text);
                                    doctorAddressList.add(controllerDoctorAddress.text);
                                    doctorContactList.add(controllerDoctorContacts.text);

                                    controllerDoctorName.clear();
                                    controllerDoctorSpecialist.clear();
                                    controllerDoctorAddress.clear();
                                    controllerDoctorContacts.clear();
                                  },
                                  child: Text(
                                    'add',
                                  ),
                                ),
                              ),
                              SizedBox(width: 10,),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24,),
                  Center(
                    child: SizedBox(
                      width: .3*width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          primary: Colors.grey[600],
                          onPrimary: Colors.white,
                          onSurface: Colors.grey,
                        ),
                        onPressed: () async{
                          int drugNumber = drugNameList.length;
                          int relativesNumber = relativeNameList.length;
                          int doctorsNumber = doctorNameList.length;
                          await _fireStore.collection('Guests').add({
                            'Name' :controllerName.text,
                            'Age' : controllerAge.text,
                            'Gender' : gender,
                            'Room number' : controllerRoomNumber.text,
                            'Image' : initialImage,
                          },).then((value) async {
                            var id = value.id;
                            print(value.id);
                            for(var no = 0; no < relativesNumber; no ++){
                              await _fireStore.collection('Guests').doc(value.id).collection('Relatives').add(
                                  {
                                    'Name: ' : relativeNameList[no],
                                    'Relation: ' : relativeRelationList[no],
                                    'Contacts: ' : relativeContacts[no],
                                    'National ID: ': relativeNN[no],
                                    'Image: ': relativeImageList[no]
                                  }
                              );
                            }
                            for(var no = 0; no < doctorsNumber; no ++){
                              await _fireStore.collection('Guests').doc(value.id).collection('Doctors').add(
                                  {
                                    'Name: ': doctorNameList[no],
                                    'Speciality: ': doctorSpecialistList[no],
                                    'Address: ': doctorAddressList[no],
                                    'Contacts: ': doctorContactList[no],
                                  }
                              );
                              /////startEdit////
                              final doctorExist =  await _fireStore.collection('Doctors')
                                  .where('Name: ', isEqualTo: doctorNameList[no]).get();
                              if(doctorExist.docs.isNotEmpty){
                                final docID = doctorExist.docs.first.id;
                                print('This doctor exists in $docID');
                                try{
                                  await _fireStore.collection('Doctors').doc(docID).set({
                                    'No. of doctor users': FieldValue.increment(1)
                                  }, SetOptions(merge: true));
                                  await _fireStore.collection('Doctors').doc(docID).collection('Followers').add({
                                    'Guest Name': controllerName.text,
                                  });
                                }catch(e){
                                  print(e);
                                }
                                print('the doctor\'d users are incremented');

                              } else {
                                print('this doctor is new');
                                await _fireStore.collection('Doctors').add(
                                    {
                                      'Name: ': doctorNameList[no],
                                      'Speciality: ': doctorSpecialistList[no],
                                      'Address: ': doctorAddressList[no],
                                      'Contacts: ': doctorContactList[no],
                                      'No. of doctor users': 1
                                    }
                                ).then((value) async {
                                  await _fireStore.collection('Doctors').doc(value.id).collection('Followers').add({
                                    'Guest Name': controllerName.text,
                                  });
                                });
                              }
                              /////endEdit/////
                              /*
                                await _fireStore.collection('Doctors').add(
                                  {
                                    'Name: ': doctorNameList[no],
                                    'Speciality: ': doctorSpecialistList[no],
                                    'Address: ': doctorAddressList[no],
                                    'Contacts: ': doctorContactList[no],
                                  }
                                );
                                */
                            }
                            for(var no = 0; no < drugNumber; no ++){
                              await _fireStore.collection('Guests').doc(value.id).collection('Drugs').add(
                                  {
                                    'Drug Name': drugNameList[no],
                                    'Drug Serial Number': drugSerialNumberList[no],
                                    'DrugImage': drugImageList[no],
                                    'Drug Dose': drugDoseList[no],
                                  }
                              );

                              /////startEdit/////
                              final elementExist =  await _fireStore.collection('Drugs')
                                  .where('Drug Name', isEqualTo: drugNameList[no]).get();
                              if(elementExist.docs.isNotEmpty){
                                final docID = elementExist.docs.first.id;
                                print('This drugs exists in $docID');
                                try{
                                  await _fireStore.collection('Drugs').doc(docID).set({
                                    'No. of drug users': FieldValue.increment(1)
                                  }, SetOptions(merge: true));
                                }catch(e){
                                  print(e);
                                }
                                print('the drugs users are incremented');

                              } else {
                                print('this drug is new');
                                await _fireStore.collection('Drugs').add(
                                    {
                                      'Drug Name': drugNameList[no],
                                      'Drug Serial Number': drugSerialNumberList[no],
                                      'DrugImage': drugImageList[no],
                                      'No. of drug users': 1
                                    }
                                );
                              }
                              /////endEdit/////

                              /*await _fireStore.collection('Drugs').add(
                                    {
                                      'Drug Name': drugNameList[no],
                                      'Drug Serial Number': drugSerialNumberList[no],
                                      'DrugImage': drugImageList[no],
                                    }
                                );*/
                            }
                          });


                          setState(() {
                            message = '$name is saved';
                            drugNameList = [];
                            drugSerialNumberList = [];
                            drugDoseList = [];
                            relativeNameList = [];
                            relativeContacts = [];
                            relativeRelationList = [];
                            relativeNN =[];
                            relativeImageList = [];
                            doctorContactList = [];
                            doctorAddressList = [];
                            doctorSpecialistList = [];
                            doctorNameList = [];
                          });

                          controllerName.clear();
                          controllerDate.clear();
                          controllerAge.clear();
                          controllerRoomNumber.clear();
                        },
                        child: SizedBox(width:100,child: Center(child: const Text('Create'))),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      message,
                    ),
                  ),
                ],

              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*class BluePainter extends CustomPainter {
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
    ovalPath.moveTo(width * .83, height);
    //paint a curve from current position to middle of the screen
    ovalPath.quadraticBezierTo(width * .85, height * .8, width, height * .8);
    //draw remaining line to bottom left side
    ovalPath.lineTo(width, height);
    //close line to reset it back
    ovalPath.close();
    paint.color = Colors.green.shade100;
    canvas.drawPath(ovalPath, paint);
  }


  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}*/
void uploadToStorage(User user){
  final dateTime = DateTime.now();
  final userId = user.uid;
  final path = '$userId/$dateTime';

  Reference reference = FirebaseStorage.instance.ref().child(Uuid().v1());

}


class guest {
  String id;
  final String name;
  final int age ;
  final String birthday;
  guest({
    this.id ='',
    required this.name,
    required this.age,
    required this.birthday,
  });
  Map<String,dynamic> toJson()=>{
    'id':id,
    'name':name,
    'age':age,
    'birthday':birthday,
  };
}