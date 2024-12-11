import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditDoctor extends StatefulWidget {
  static String id = 'edit_doctor';


  const EditDoctor(
      {Key? key, required this.thisDoctor, required this.doctorID})
      : super(key: key);

  final Map<String, dynamic> thisDoctor;
  final String doctorID;

  @override
  State<EditDoctor> createState() => _EditDoctorState();
}

late var controllerDoctorName = TextEditingController();
late var controllerDoctorSpecialist = TextEditingController();
late var controllerDoctorAddress = TextEditingController();
late var controllerDoctorContacts = TextEditingController();

class _EditDoctorState extends State<EditDoctor> {

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

  bool _showFollowers = true;
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      primary: Colors.grey[800],
                      onPrimary: Colors.white,
                      onSurface: Colors.grey[500],
                    ),
                    onPressed: () {
                      setState(() {
                        _showFollowers = true;
                      });
                    },
                    child: Text('Edit',style: TextStyle(color: Colors.white),),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      primary: Colors.grey[800],
                      onPrimary: Colors.white,
                      onSurface: Colors.grey[500],
                    ),
                    onPressed: () {
                      setState(() {
                        _showFollowers = false;
                      });
                    },
                    child: Text('Patients',style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
              SizedBox(height:height*.05),
              Visibility(
                visible: _showFollowers,
                  child: Container(
                    width: width * .45,
                    child: Column(
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
                              try{
                                await FirebaseFirestore.instance.collection('Doctors').doc(widget.doctorID).update({
                                  'Name: ': controllerDoctorName.text,
                                  'Speciality: ': controllerDoctorSpecialist.text,
                                  'Address: ': controllerDoctorAddress.text,
                                  'Contacts: ': controllerDoctorContacts.text,
                                });
                              } catch (e){
                                print(e);
                              }
                              print('Done');
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Save Changes',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
              ),
              Visibility(
                visible: !_showFollowers,
                  child: Expanded(
                    child: SizedBox(
                      width: width*.2,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection('Doctors').doc(widget.doctorID).collection('Followers').snapshots(),
                        builder: (context, snapshots){
                          return (snapshots.connectionState == ConnectionState.waiting)
                              ? Center(
                            child: CircularProgressIndicator(),
                          ) : ListView.builder(
                            itemCount: snapshots.data!.docs.length,
                            itemBuilder: (context, index){
                              var data = snapshots.data!.docs[index].data() as Map<String,dynamic>;

                              return ListTile(
                                title: Text(
                                  'Guest Name:',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.green.shade800,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: SizedBox(
                                  // width: .2*width*.7,
                                  child: AutoSizeText(
                                    data['Guest Name'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.brown.shade800,
                                      fontSize: 16,
                                      // fontWeight: FontWeight.bold
                                    ),
                                    minFontSize: 10,
                                  ),
                                ),
                              );
                              // return Row(
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   children: [
                              //     SizedBox(
                              //       // width: .2*width*.7,
                              //       child: Text(
                              //         'Guest Name:',
                              //         maxLines: 1,
                              //         overflow: TextOverflow.ellipsis,
                              //         style: TextStyle(
                              //             color: Colors.green.shade800,
                              //             fontSize: 19,
                              //             fontWeight: FontWeight.bold),
                              //       ),
                              //     ),
                              //     SizedBox(width:width*.7*.01),
                              //     SizedBox(
                              //       // width: .2*width*.7,
                              //       child: AutoSizeText(
                              //         data['Guest Name'],
                              //         maxLines: 2,
                              //         overflow: TextOverflow.ellipsis,
                              //         style: TextStyle(
                              //           color: Colors.brown.shade800,
                              //           fontSize: 16,
                              //           // fontWeight: FontWeight.bold
                              //         ),
                              //         minFontSize: 10,
                              //       ),
                              //     ),
                              //   ],
                              // );
                            },
                          );
                        },
                      ),
                    ),
                  )
              )
            ],
          )
        ],
      ),
    );
  }
}
