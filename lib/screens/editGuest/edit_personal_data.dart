import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:age_calculator/age_calculator.dart';
import 'package:my_web_app/used_components/main_Button.dart';


class PersonalEdit extends StatefulWidget {

  static String id = 'edit_guest_Info';

  PersonalEdit({Key? key, required this.personalData,required this.docID}) : super(key: key);

  final Map<String, dynamic> personalData;
  final String docID;

  @override
  State<PersonalEdit> createState() => _PersonalEditState();
}

late var controllerName = TextEditingController();
late var controllerAge = TextEditingController();
late var controllerDate = TextEditingController();
late var controllerRoomNumber = TextEditingController();

class _PersonalEditState extends State<PersonalEdit> {

  late String initialImage;



  late String name;
  late String guestImage;
  late String id;
  late String gender;
  late String age;
  late String roomNumber;

  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  GlobalKey<FormState> key = GlobalKey();
  int _value = 1;
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    controllerName = TextEditingController(text: widget.personalData['Name']);
    controllerRoomNumber = TextEditingController(text: widget.personalData['Room number']);
    controllerAge = TextEditingController(text: widget.personalData['Age']);
    initialImage = widget.personalData['Image'];
    gender = widget.personalData['Gender'];
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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade800,
        title: Text(
            'Edit ${widget.personalData['Name']}\'s Information',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Row(
        children: [
          SizedBox(
            width:width*.45,
            child: Image.asset('images/editpersonal.gif'),
          ),
          SizedBox(
            width:width*.52,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  width: width*.22,
                                  height:25,
                                  child: Text('Name',style: TextStyle(color: Colors.brown.shade900),),
                                ),
                                SizedBox(
                                  width: .2*width,
                                  child: TextField(
                                    style: TextStyle(color: Colors.brown.shade900),
                                    controller: controllerName,
                                    onChanged: (value) {
                                      name = value;
                                    },
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          topLeft: Radius.circular(20),
                                          bottomLeft:Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                      ),
                                      hintText: 'Enter The Guest Name',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height:height*.01),
                            Column(
                              children: [
                                SizedBox(
                                  width: width*.22,
                                  height:25,
                                  child: Text('Room Number',style: TextStyle(color: Colors.brown.shade900),),
                                ),
                                SizedBox(
                                  width: width*.2,
                                  child: TextField(
                                    style: TextStyle(color: Colors.brown.shade900),
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
                                      hintText: 'Room number ',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height:height*.01),
                            SizedBox(
                              width: width*.2,
                              child: TextField(
                                style: TextStyle(color: Colors.brown.shade900),
                                controller: controllerAge,
                                //editing controller of this TextField
                                decoration: InputDecoration(
                                  icon: const Icon(Icons.calendar_today), //icon of text field
                                  labelText: "Enter Date", //label text of field
                                  floatingLabelStyle:
                                  MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                                    final Color color = states.contains(MaterialState.error)
                                        ? Theme.of(context).colorScheme.error
                                        : Colors.brown.shade900;
                                    return TextStyle(color: color, letterSpacing: 1.3);}),

                                ),
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
                                    String guestAge = AgeCalculator.age(pickedDate).years.toString();
                                    print(
                                        formattedDate); //formatted date output using intl package =>  2021-03-16
                                    setState(() {
                                      controllerAge.text = guestAge; //set output date to TextField value.
                                    });
                                  } else {}
                                },
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              width: width * .3 ,
                              height: height * .3,
                              child: CircleAvatar(
                                // backgroundImage: AssetImage('images/p1.jpg'),
                                backgroundImage: NetworkImage(initialImage),
                                minRadius: 25,
                                maxRadius: 57,),
                            ),
                            SizedBox(height:height*.04),
                            SizedBox(
                              width:width*.2,
                              child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    shape: StadiumBorder(),
                                    primary: Colors.grey[800],
                                    onPrimary: Colors.white,
                                    onSurface: Colors.grey[200],
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
                                    if(url!=null){
                                      setState(() {
                                        initialImage = url;
                                      });
                                    }else{
                                      setState(() {
                                        initialImage = widget.personalData['Image'];
                                      });
                                    }
                                  },
                                  icon: Icon(Icons.upload),
                                  label: Text('update the image',
                                    style: TextStyle(
                                      color: Colors.brown.shade50,
                                    ),)
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height:height*.04),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height:height*.2,
                              child: Image.asset('images/male.jpg',),
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
                                Text('Male',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.brown.shade900,
                                  ),),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(width: 15,),
                        Column(
                          children: [
                            SizedBox(
                              height:height*.2,
                              child: Image.asset('images/famale.jpg',),
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
                                Text('Female',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                      color: Colors.brown.shade900,
                                  ),),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width:width*.2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      primary: Colors.grey[800],
                      onPrimary: Colors.white,
                      onSurface: Colors.grey[200],
                    ),
                    onPressed: () async {
                      try{
                        await FirebaseFirestore.instance.collection('Guests').doc(widget.docID).update(
                            {
                              'Name' :controllerName.text,
                              'Age' : controllerAge.text,
                              'Gender' : gender,
                              'Room number' : controllerRoomNumber.text,
                              'Image' : initialImage,
                            });
                        print('Done');
                        Navigator.pop(context);
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: const Text(
                      'Save Changes',
                      style: TextStyle(color: Colors.white),
                    ),
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
