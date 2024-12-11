import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class NewDoctor extends StatefulWidget {

  static String id = 'new_doctor';

  const NewDoctor({Key? key, required this.ItemId}) : super(key: key);

  final String ItemId;

  @override
  State<NewDoctor> createState() => _NewDoctorState();
}

final controllerDoctorName = TextEditingController();
final controllerDoctorSpecialist = TextEditingController();
final controllerDoctorAddress = TextEditingController();
final controllerDoctorContacts = TextEditingController();

class _NewDoctorState extends State<NewDoctor> {
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
        title: Text('add new doctor'),
      ),
      body: Row(
        children: [
          SizedBox(
            width: width*.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
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
                            controller: controllerDoctorName,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height*.04,),
                    Column(
                      children: [
                        SizedBox(
                          width: width*.42,
                          height:25,
                          child: Text('Speciality',style: TextStyle(color: Colors.brown.shade900),),
                        ),
                        SizedBox(
                          width: width*.4,
                          height: 50,
                          child: TextField(
                            style: TextStyle(color: Colors.brown.shade900),
                            controller: controllerDoctorSpecialist,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height*.04,),
                    Column(
                      children: [
                        SizedBox(
                          width: width*.42,
                          height:25,
                          child: Text('Address',style: TextStyle(color: Colors.brown.shade900),),
                        ),
                        SizedBox(
                          width: width*.4,
                          height: 50,
                          child: TextField(
                            style: TextStyle(color: Colors.brown.shade900),
                            controller: controllerDoctorAddress,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height*.04,),
                    Column(
                      children: [
                        SizedBox(
                          width: width*.42,
                          height:25,
                          child: Text('Contacts (spearated by "-")',style: TextStyle(color: Colors.brown.shade900),),
                        ),
                        SizedBox(
                          width: width*.4,
                          height: 50,
                          child: TextField(
                            style: TextStyle(color: Colors.brown.shade900),
                            controller: controllerDoctorContacts,
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
                  width: width*.2,
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
                                .doc(widget.ItemId).collection('Doctors').add(
                                {
                                  'Name: ': controllerDoctorName.text,
                                  'Speciality: ': controllerDoctorSpecialist.text,
                                  'Address: ': controllerDoctorAddress.text,
                                  'Contacts: ': controllerDoctorContacts.text,
                                }
                            );

                            final doctorExist =  await FirebaseFirestore.instance.collection('Doctors')
                                .where('Name: ', isEqualTo: controllerDoctorName.text).get();
                            if(doctorExist.docs.isNotEmpty){
                              final docID = doctorExist.docs.first.id;
                              print('This doctor exists in $docID');

                              DocumentSnapshot  guestName = await FirebaseFirestore.instance.collection('Guests').doc(widget.ItemId)
                                  .get();
                              try{
                                await FirebaseFirestore.instance.collection('Doctors').doc(docID).set({
                                  'No. of doctor users': FieldValue.increment(1)
                                }, SetOptions(merge: true)
                                );
                                await FirebaseFirestore.instance.collection('Doctors').doc(docID)
                                    .collection('Followers').add({
                                  'Guest Name': guestName.get('Name'),
                                });
                              }catch(e){
                                print(e);
                              }
                              print('the doctor\'d users are incremented');

                            } else {
                              print('this doctor is new');
                              DocumentSnapshot  guestName = await FirebaseFirestore.instance.collection('Guests').doc(widget.ItemId)
                                  .get();
                              await FirebaseFirestore.instance.collection('Doctors').add(
                                  {
                                    'Name: ': controllerDoctorName.text,
                                    'Speciality: ': controllerDoctorSpecialist.text,
                                    'Address: ': controllerDoctorAddress.text,
                                    'Contacts: ': controllerDoctorContacts.text,
                                    'No. of doctor users': 1
                                  }
                              ).then((value) async {
                                await FirebaseFirestore.instance.collection('Doctors').doc(value.id).collection('Followers').add({
                                  'Guest Name': guestName.get('Name'),
                                });
                              });
                            }
                            Navigator.pop(context);
                          }catch(e){
                            print(e);
                          }
                        },
                        child: Text(
                          'Save Changes',
                          style: TextStyle(color: Colors.white),
                        ),
                    )
                )
              ],
            ),
          ),
          SizedBox(
            width: width*.45,
            child: Image.asset('images/adddoctor.gif'),
          ),
        ],
      ),
    );
  }
}
