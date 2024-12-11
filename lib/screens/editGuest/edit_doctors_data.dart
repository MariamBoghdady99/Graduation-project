import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_web_app/screens/editGuest/edit_specific_doctor.dart';
import 'package:my_web_app/screens/editGuest/add_new_doctor.dart';
import 'package:my_web_app/screens/guest_details.dart';
import 'package:my_web_app/screens/editGuest/edit_relative_data.dart';
import 'package:my_web_app/screens/editGuest/edit_drugs_data.dart';

class DoctorsData extends StatefulWidget {

  static String id = 'doctor_data';

  const DoctorsData({Key? key, required this.docId}) : super(key: key);

  final String docId;

  @override
  State<DoctorsData> createState() => _DoctorsDataState();
}


class _DoctorsDataState extends State<DoctorsData> {
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
      body: Row(
        children: [
          Container(
            width: .2*width,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  width: width*.2,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back,color: Colors.green.shade900,),
                      ),
                      SizedBox(
                          width: width * .05,
                          child: Image.asset('images/OIG.png')
                      ),
                      Text(
                        'CURA',
                        style: TextStyle(
                          color: Colors.green.shade900,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  width: .2*width,
                  height: height*.3,
                  color:Colors.green.shade200,
                  child: Text('The Doctors\' Information',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),
                ),
                SizedBox(
                    width: .2*width,
                    height:40,
                    child: TextButton(
                      onPressed: () async {
                        final snapshot = await FirebaseFirestore.instance.collection('Guests').doc(widget.docId).get();
                        final myMap = snapshot.data() as Map<String, dynamic>;

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context)=> GuestDetails(guestDetails: myMap, docId: widget.docId)));
                      },
                      child: Row(
                        children: [
                          Icon(Icons.person_pin,color: Colors.green.shade800,),
                          Text('Patient',style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.bold,fontSize: 20,),),
                        ],
                      ),)),
                SizedBox(height:10.0,),
                SizedBox(
                    width: .2*width,
                    height:40,
                    child: TextButton(
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                            RelativeEdit(docID: widget.docId)));
                      },
                      child: Row(
                        children: [
                          Icon(Icons.person_pin,color: Colors.green.shade800,),
                          Text('Relative',style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.bold,fontSize: 20,),),
                        ],
                      ),)),
                SizedBox(height:10.0,),
                SizedBox(
                    width: .2*width,
                    height:40,
                    child: TextButton(
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                            NewDoctor(ItemId: widget.docId)));
                      },
                      child: Row(
                        children: [
                          Icon(Icons.person_pin,color: Colors.green.shade800,),
                          Text('Add Doctor',style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.bold,fontSize: 20,),),
                        ],
                      ),)),
                SizedBox(height:10.0,),
                SizedBox(
                    width: .2*width,
                    height:40,
                    child: TextButton(
                      onPressed: (){
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                        //     DoctorsData(docId: widget.docId)));
                      },
                      child: Row(
                        children: [
                          Icon(Icons.medical_information_outlined,color: Colors.green.shade800,),
                          Text('Doctors',style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.bold,fontSize: 20,),),
                        ],
                      ),)),
                SizedBox(height:10.0,),
                SizedBox(
                    width: .2*width,
                    height:40,
                    child: TextButton(
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                            DrugsData(docId: widget.docId)));
                      },
                      child: Row(
                        children: [
                          Icon(Icons.medication_outlined,color: Colors.green.shade800,),
                          Text('Drugs',style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.bold,fontSize: 20,),),
                        ],
                      ),)),
              ],
            ),
          ),
          SizedBox(width: 0.05*width,),
          SizedBox(
            width:width*.7,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Guests').doc(widget.docId).collection('Doctors').snapshots(),
              builder: (context, snapshots) {
                return (snapshots.connectionState == ConnectionState.waiting)
                    ? Center(
                  child: CircularProgressIndicator(),
                ) : GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: snapshots.data!.docs.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount( // The grid delegate
                      mainAxisExtent: height*.6,
                      crossAxisCount: 3, // The number of items per row
                      crossAxisSpacing: width*.03, // The spacing between items along the cross axis
                      mainAxisSpacing: 10, // The spacing between items along the main axis
                    ),
                    itemBuilder: (context, val) {
                      var doctorInfo = snapshots.data!.docs[val].data() as Map<String, dynamic>;
                      String guestDoctorID = snapshots.data!.docs[val].id;
                      String guestID = widget.docId;
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          border: Border.all(width: 1,color: Colors.grey.shade400,),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 15,),
                            Text(
                              doctorInfo['Name: '],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.brown.shade900,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 15,),
                            Text(
                              doctorInfo['Speciality: '],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.brown.shade900,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 15,),
                            Text(
                              doctorInfo['Address: '],
                              style: TextStyle(
                                color: Colors.brown.shade900,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 15,),
                            Text(
                              doctorInfo['Contacts: '],
                              style: TextStyle(
                                color: Colors.brown.shade900,
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                          EditThisDoctor(thisDoctor: doctorInfo, GuestDoctorID:guestDoctorID, GuestID: guestID)));
                                    },
                                    icon: Icon(
                                        Icons.edit
                                    )
                                ),
                                SizedBox(width: 10,),
                                IconButton(
                                    onPressed: () async{
                                      await FirebaseFirestore.instance.collection('Guests').doc(widget.docId).collection('Doctors')
                                          .doc(guestDoctorID).delete();

                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('${doctorInfo['Name: ']} is deleted',
                                              style: TextStyle(
                                                color: Colors.red[100],
                                              ),
                                            ),
                                            action: SnackBarAction(
                                              label: 'Undo',
                                              onPressed: () async {
                                                try{
                                                  await FirebaseFirestore.instance.collection('Guests').doc(widget.docId).collection('Doctors')
                                                      .doc(guestDoctorID).set(doctorInfo);
                                                } catch (e){
                                                  print(e);
                                                }
                                              },
                                            ),
                                          )
                                      );
                                    },
                                    icon: Icon(
                                        Icons.delete
                                    )),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
