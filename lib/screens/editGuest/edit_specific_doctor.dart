import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditThisDoctor extends StatefulWidget {
  static String id = 'edit_this_doctor';

  const EditThisDoctor(
      {Key? key, required this.thisDoctor, this.GuestDoctorID, this.GuestID})
      : super(key: key);

  final Map<String, dynamic> thisDoctor;
  final String? GuestDoctorID;
  final String? GuestID;

  @override
  State<EditThisDoctor> createState() => _EditThisDoctorState();
}

late var controllerDoctorName = TextEditingController();
late var controllerDoctorSpecialist = TextEditingController();
late var controllerDoctorAddress = TextEditingController();
late var controllerDoctorContacts = TextEditingController();

class _EditThisDoctorState extends State<EditThisDoctor> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerDoctorName =
        TextEditingController(text: widget.thisDoctor['Name: ']);
    controllerDoctorSpecialist =
        TextEditingController(text: widget.thisDoctor['Speciality: ']);
    controllerDoctorAddress =
        TextEditingController(text: widget.thisDoctor['Address: ']);
    controllerDoctorContacts =
        TextEditingController(text: widget.thisDoctor['Contacts: ']);
  }

  bool _showContainer = true;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade700,
        title: Text('Edit Dr ${widget.thisDoctor['Name: ']}\'s Information'),
      ),
      body: Row(
        children: [
          SizedBox(
            width: width * .5,
            child: Image.asset('images/editdoctor.gif'),
          ),
          Column(
            children: [
              SizedBox(height:height*.05),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     ElevatedButton(
              //       style: ElevatedButton.styleFrom(
              //         shape: const StadiumBorder(),
              //         primary: Colors.grey[800],
              //         onPrimary: Colors.white,
              //         onSurface: Colors.grey[500],
              //       ),
              //       onPressed: () {
              //         setState(() {
              //           _showContainer = true;
              //         });
              //       },
              //       child: Text('Edit',style: TextStyle(color: Colors.white),),
              //     ),
              //     SizedBox(width: 10),
              //     ElevatedButton(
              //       style: ElevatedButton.styleFrom(
              //         shape: const StadiumBorder(),
              //         primary: Colors.grey[800],
              //         onPrimary: Colors.white,
              //         onSurface: Colors.grey[500],
              //       ),
              //       onPressed: () {
              //
              //         setState(() {
              //           _showContainer = false;
              //         });
              //       },
              //       child: Text('Patients',style: TextStyle(color: Colors.white),),
              //     ),
              //   ],
              // ),
              SizedBox(height:height*.05),
              Visibility(
                visible: _showContainer,
                child: Container(
                  width: width * .45,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                width: width * .4,
                                height: 25,
                                child: Text(
                                  'Name',
                                  style:
                                      TextStyle(color: Colors.brown.shade900),
                                ),
                              ),
                              SizedBox(
                                width: width * .4,
                                height: 50,
                                child: TextField(
                                  style:
                                      TextStyle(color: Colors.brown.shade800),
                                  controller: controllerDoctorName,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                    hintText: 'Name ',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: height * .04),
                          Column(
                            children: [
                              SizedBox(
                                width: width * .4,
                                height: 25,
                                child: Text(
                                  'Speciality',
                                  style:
                                      TextStyle(color: Colors.brown.shade900),
                                ),
                              ),
                              SizedBox(
                                width: width * .4,
                                height: 50,
                                child: TextField(
                                  style:
                                      TextStyle(color: Colors.brown.shade900),
                                  controller: controllerDoctorSpecialist,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                    hintText: 'Speciality',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: height * .04),
                          Column(
                            children: [
                              SizedBox(
                                width: width * .4,
                                height: 25,
                                child: Text(
                                  'Address',
                                  style:
                                      TextStyle(color: Colors.brown.shade900),
                                ),
                              ),
                              SizedBox(
                                width: width * .4,
                                height: 50,
                                child: TextField(
                                  style:
                                      TextStyle(color: Colors.brown.shade900),
                                  controller: controllerDoctorAddress,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                    hintText: 'Address ',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: height * .04),
                          Column(
                            children: [
                              SizedBox(
                                width: width * .4,
                                height: 25,
                                child: Text(
                                  'Contacts',
                                  style:
                                      TextStyle(color: Colors.brown.shade900),
                                ),
                              ),
                              SizedBox(
                                width: width * .4,
                                height: 50,
                                child: TextField(
                                  style:
                                      TextStyle(color: Colors.brown.shade900),
                                  controller: controllerDoctorContacts,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                    hintText:
                                        'The contacts (Separate them by (as 01.. - 01..) ) ',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: height*.05,),
                      SizedBox(
                        width: width * .2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            primary: Colors.grey[800],
                            onPrimary: Colors.white,
                            onSurface: Colors.grey[500],
                          ),
                          onPressed: () async {
                            if (widget.GuestID != null) {
                              try {
                                await FirebaseFirestore.instance
                                    .collection('Guests')
                                    .doc(widget.GuestID)
                                    .collection('Doctors')
                                    .doc(widget.GuestDoctorID)
                                    .update({
                                  'Name: ': controllerDoctorName.text,
                                  'Speciality: ': controllerDoctorSpecialist.text,
                                  'Address: ': controllerDoctorAddress.text,
                                  'Contacts: ': controllerDoctorContacts.text,
                                });
                                
                                final doctorExsist = await FirebaseFirestore.instance.collection('Doctors')
                                    .where('Name: ', isEqualTo: controllerDoctorName.text).get();
                                if(doctorExsist.docs.isNotEmpty){
                                  final docID = doctorExsist.docs.first.id;
                                  try{
                                    await FirebaseFirestore.instance.collection('Doctors').doc(docID).update({
                                      'Name: ': controllerDoctorName.text,
                                      'Speciality: ': controllerDoctorSpecialist.text,
                                      'Address: ': controllerDoctorAddress.text,
                                      'Contacts: ': controllerDoctorContacts.text,
                                    });
                                  }catch(e){
                                    print(e);
                                  }
                                }
                                print('Done');
                                Navigator.pop(context);
                              } catch (e) {
                                print(e);
                              }
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
