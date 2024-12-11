import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class NewDrug extends StatefulWidget {

  static String id = 'new_Drug';

  const NewDrug({Key? key, required this.ItemId}) : super(key: key);

  final String ItemId;

  @override
  State<NewDrug> createState() => _NewDrugState();
}

late var controllerDrugName = TextEditingController();
late var controllerDrugSerialNumber = TextEditingController();
late var controllerDrugDose = TextEditingController();
late var controllerDrugImage = TextEditingController();

class _NewDrugState extends State<NewDrug> {

  late String drugName;
  late String drugSerialNumber;
  late String drugImage = ('https://static.thenounproject.com/png/3322766-200.png').toString();
  late String drugDose;

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
        title: Text('Add new drug'),
      ),
      body: Row(
        children: [
          SizedBox(
            width: width*.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Ink.image(
                      image: NetworkImage(drugImage),
                      fit: BoxFit.fitHeight,
                      height: .3*(height-225),
                      width: .4*width,
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
                              drugImage = url;
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
                            controller: controllerDrugName,
                            onChanged: (value){
                              drugName = value;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: width*.42,
                          height:25,
                          child: Text('Serial Number',style: TextStyle(color: Colors.brown.shade900),),
                        ),
                        SizedBox(
                          width: width*.4,
                          height: 50,
                          child: TextField(
                            style: TextStyle(color: Colors.brown.shade900),
                            onChanged: (value) {
                              drugSerialNumber = value;
                            },
                            controller: controllerDrugSerialNumber,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: width*.42,
                          height:25,
                          child: Text('Dose',style: TextStyle(color: Colors.brown.shade900),),
                        ),
                        SizedBox(
                          width: width*.4,
                          height: 50,
                          child: TextField(
                            style: TextStyle(color: Colors.brown.shade900),
                            onChanged: (value) {
                              drugDose = value;
                            },
                            controller: controllerDrugDose,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
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
                            .doc(widget.ItemId).collection('Drugs').add(
                            {
                              'Drug Name': controllerDrugName.text,
                              'Drug Serial Number': controllerDrugSerialNumber.text,
                              'DrugImage' : drugImage,
                              'Drug Dose' : controllerDrugDose.text,
                            }
                        );
                        /////startEdit/////
                        final elementExist =  await FirebaseFirestore.instance.collection('Drugs')
                            .where('Drug Name', isEqualTo: controllerDrugName.text).get();
                        if(elementExist.docs.isNotEmpty){
                          final docID = elementExist.docs.first.id;
                          print('This drugs exists in $docID');
                          try{
                            await FirebaseFirestore.instance.collection('Drugs').doc(docID).set({
                              'No. of drug users': FieldValue.increment(1)
                            }, SetOptions(merge: true));
                          }catch(e){
                            print(e);
                          }
                          print('the drugs users are incremented');

                        } else {
                          print('this drug is new');
                          await FirebaseFirestore.instance.collection('Drugs').add(
                              {
                                'Drug Name': controllerDrugName.text,
                                'Drug Serial Number': controllerDrugSerialNumber.text,
                                'DrugImage': drugImage,
                                'No. of drug users': 1
                              }
                          );
                        }
                        /////endEdit/////

                        print('Done');
                        Navigator.pop(context);
                      }catch(e){
                        print(e);
                      }
                    },
                    child: Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
    ),
              ],
            ),
          ),
          SizedBox(
            width: width*.45,
          child: Image.asset('images/adddrug.jpg'),)
        ],
      ),
    );
  }
}
