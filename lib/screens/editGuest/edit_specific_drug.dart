import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditThisDrug extends StatefulWidget {

  static String id = 'edit_this_drug';

  const EditThisDrug({Key? key, required this.thisDrug, required this.DocItem, this.ItemId}) : super(key: key);

  final Map<String, dynamic> thisDrug;
  final String DocItem;
  final String? ItemId;

  @override
  State<EditThisDrug> createState() => _EditThisDrugState();
}

late var controllerDrugName = TextEditingController();
late var controllerDrugSerialNumber = TextEditingController();
late var controllerDrugDose = TextEditingController();
late var controllerDrugImage = TextEditingController();

class _EditThisDrugState extends State<EditThisDrug> {

  late String drugName;
  late String drugSerialNumber;
  late String drugImage;
  late String drugDose;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerDrugName = TextEditingController(text: widget.thisDrug['Drug Name']);
    controllerDrugSerialNumber = TextEditingController(text: widget.thisDrug['Drug Serial Number']);
    controllerDrugDose = TextEditingController(text: widget.thisDrug['Drug Dose']);
    controllerDrugImage = TextEditingController(text: widget.thisDrug['DrugImage']);
    drugImage = widget.thisDrug['DrugImage'];
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
            'edit ${widget.thisDrug['Drug Name']}\'s Information'
        ),
      ),
      body: Row(
        children: [
          Container(
            width:width*.55,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Ink.image(
                      image: NetworkImage(drugImage),
                      fit: BoxFit.fitWidth,
                      height: .3*(height-225),
                      width: .4*width,
                      child: InkWell(
                        onTap: ()async {
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
                              setState(() {
                                drugImage = widget.thisDrug['DrugImage'];
                              });
                            }
                          },
                      ),
                      ),
                    SizedBox(height:(height-225)*.7*.04),
                    Column(
                      children: [
                        SizedBox(
                          width: width*.4,
                          height:25,
                          child: Text('Drug Name',style: TextStyle(color: Colors.brown.shade900),),
                        ),
                        SizedBox(
                          width: width*.4,
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
                              hintText: 'Drug Name',
                            ),
                            style: TextStyle(color: Colors.brown.shade900),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height:(height-225)*.7*.04),
                    Column(
                      children: [
                        SizedBox(
                          width: width*.4,
                          height:25,
                          child: Text('Serial Number',style: TextStyle(color: Colors.brown.shade900),),
                        ),
                        SizedBox(
                          width: width*.4,
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
                              hintText: 'Drug Serial Number',
                            ),
                            style: TextStyle(color: Colors.brown.shade900),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height:(height-225)*.7*.04),
                    Column(
                      children: [
                        SizedBox(
                          width: width*.4,
                          height:25,
                          child: Text('Dose',style: TextStyle(color: Colors.brown.shade900),),
                        ),
                        SizedBox(
                          width: width*.4,
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
                              hintText: 'Write no dose if you update the main drug',
                            ),
                            style: TextStyle(color: Colors.brown.shade900),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width:width*.2,
                  height:30,
                  child: ElevatedButton(
                    onPressed: () async {
                      if(widget.ItemId != null){
                        try{
                          await FirebaseFirestore.instance.collection('Guests')
                              .doc(widget.ItemId).collection('Drugs').doc(widget.DocItem).update(
                              {
                                'Drug Name': controllerDrugName.text,
                                'Drug Serial Number': controllerDrugSerialNumber.text,
                                'DrugImage' : drugImage,
                                'Drug Dose' : controllerDrugDose.text,
                              }
                          );
                          print('Done');
                          Navigator.pop(context);
                        }catch(e){
                          print(e);
                        }
                      } else {
                        try{
                          await FirebaseFirestore.instance.collection('Drugs').doc(widget.DocItem).update({
                            'Drug Name': controllerDrugName.text,
                            'Drug Serial Number': controllerDrugSerialNumber.text,
                            'DrugImage': drugImage
                          });
                          print('Done');
                          Navigator.pop(context);
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                    child: Text(
                      'Save Changes',
                      style: TextStyle(color: Colors.brown.shade50),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      primary: Colors.grey[800],
                      onPrimary: Colors.white,
                      onSurface: Colors.grey[500],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: width*.4,
            child: Image.asset('images/editdrug.gif'),
          ),
        ],
      ),
    );
  }
}
