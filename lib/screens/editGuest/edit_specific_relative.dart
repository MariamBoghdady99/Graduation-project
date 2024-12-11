import 'dart:html';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

class EditThisRelative extends StatefulWidget {
  static String id = 'specific_relatve';

  const EditThisRelative({Key? key, required this.theirRelative, required this.DocItem, required this.ItemId}) : super(key: key);

  final Map<String, dynamic> theirRelative;
  final String DocItem;
  final String ItemId;

  @override
  State<EditThisRelative> createState() => _EditThisRelativeState();
}

late var controllerRelativeName = TextEditingController();
late var controllerRelativeRelationship = TextEditingController();
late var controllerRelativeContacts = TextEditingController();
late var controllerRelativeNN = TextEditingController();

class _EditThisRelativeState extends State<EditThisRelative> {
  String person = ('https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png').toString();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerRelativeName = TextEditingController(text: widget.theirRelative['Name: ']);
    controllerRelativeRelationship = TextEditingController(text: widget.theirRelative['Relation: ']);
    controllerRelativeContacts = TextEditingController(text: widget.theirRelative['Contacts: ']);
    controllerRelativeNN = TextEditingController(text: widget.theirRelative['National ID: ']);
    setState(() {
      person = widget.theirRelative['Image: '];
    });
    // National Number
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
          backgroundColor: Colors.grey.shade700,
          title: Text(
              'Edit ${widget.theirRelative['Name: ']}\'s Information'
          )
      ),
      body: Row(
        children: [
          SizedBox(
            width:width*.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Ink.image(
                      image: NetworkImage(person),
                      fit: BoxFit.fitHeight,
                      height: .3*(height-225),
                      width: .2*width,
                      child: InkWell(
                        onTap: () async {
                          final picker = ImagePicker();
                          final PickedFile? image = await picker.getImage(source: ImageSource.gallery);
                          String name = 'Drug -${DateTime.now()}';
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
                              person = url;
                            });
                          }else{
                            setState(() {
                              person = widget.theirRelative['Image: '];
                            });
                          }
                        },
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: width*.4,
                          height:25,
                          child: Text('Name',style: TextStyle(color: Colors.brown.shade900),),
                        ),
                        SizedBox(
                          width: width*.4,
                          height: 50,
                          child: TextField(
                            style: TextStyle(color: Colors.brown.shade900),
                            controller: controllerRelativeName,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              // hintText: 'Name ',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height:height*.02),
                    Column(
                      children: [
                        SizedBox(
                          width: width*.4,
                          height:25,
                          child: Text('RelationShip',style: TextStyle(color: Colors.brown.shade900),),
                        ),
                        SizedBox(
                          width: width*.4,
                          height: 50,
                          child: TextField(
                            style: TextStyle(color: Colors.brown.shade900),
                            controller: controllerRelativeRelationship,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              // hintText: 'The Relationship ',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height:height*.02),
                    Column(
                      children: [
                        SizedBox(
                          width: width*.4,
                          height:25,
                          child: Text('Contacts (Separate them by "-")',style: TextStyle(color: Colors.brown.shade900),),
                        ),
                        SizedBox(
                          width: width*.4,
                          height: 50,
                          child: TextField(
                            style: TextStyle(color: Colors.brown.shade900),
                            controller: controllerRelativeContacts,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              hintText: 'The contacts (Separate them by (as 01.. - 01..) ) ',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height:height*.02),
                    Column(
                      children: [
                        SizedBox(
                          width: width*.4,
                          height:25,
                          child: Text('National Number',style: TextStyle(color: Colors.brown.shade900),),
                        ),
                        SizedBox(
                          width: width*.4,
                          height: 50,
                          child: TextField(
                            style: TextStyle(color: Colors.brown.shade900),
                            controller: controllerRelativeNN,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              // hintText: 'Name ',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width:width*.2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      primary: Colors.grey[800],
                      onPrimary: Colors.white,
                      onSurface: Colors.grey[500],
                    ),
                    onPressed: () async {
                      try{
                        await FirebaseFirestore.instance.collection('Guests')
                            .doc(widget.ItemId).collection('Relatives').doc(widget.DocItem).update({
                          'Name: ' : controllerRelativeName.text,
                          'Relation: ': controllerRelativeRelationship.text,
                          'Contacts: ' : controllerRelativeContacts.text,
                          'National ID: ': controllerRelativeNN.text,
                          'Image: ': person
                        });
                        print('Done');
                        Navigator.pop(context);
                      }catch(e){
                        print(e);
                      }
                    },
                    child: Text(
                      'Save Changes',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: width*.45,
            child: Image.asset('images/editrelative.gif'),
          ),
        ],
      ),
    );
  }
}
