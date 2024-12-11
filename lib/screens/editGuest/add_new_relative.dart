import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewRelative extends StatefulWidget {

  static String id = 'new_relative';

  const NewRelative({Key? key, required this.itemId}) : super(key: key);

  final String itemId;

  @override
  State<NewRelative> createState() => _NewRelativeState();
}

final controllerRelativeName = TextEditingController();
final controllerRelativeRelationship = TextEditingController();
final controllerRelativeContacts = TextEditingController();
final controllerRelativeNN = TextEditingController();

class _NewRelativeState extends State<NewRelative> {
  String person = ('https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png').toString();

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
        title: Text('Adding New Relative'),
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

                          }
                        },
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: width*.42,
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
                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height:height*.02),
                    Column(
                      children: [
                        SizedBox(
                          width: width*.42,
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
                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height:height*.02),
                    Column(
                      children: [
                        SizedBox(
                          width: width*.42,
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
                                borderRadius: BorderRadius.all(Radius.circular(20))
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height:height*.02),
                    Column(
                      children: [
                        SizedBox(
                          width: width*.42,
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
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                              ),
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
                        await FirebaseFirestore.instance.collection('Guests').doc(widget.itemId).collection('Relatives').add(
                            {
                              //Image
                              'Name: ' : controllerRelativeName.text,
                              'Relation: ' : controllerRelativeRelationship.text,
                              'Contacts: ' : controllerRelativeContacts.text,
                              'National ID: ': controllerRelativeNN.text,
                              'Image: ': person
                              //National Number
                            }
                        );
                        print('Done');
                        Navigator.pop(context);
                      }catch (e){
                        print(e);
                      }
                    },
                    child: Text(
                      'Add',
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
