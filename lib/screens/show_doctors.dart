import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_web_app/screens/add_guest.dart';
import 'package:my_web_app/screens/principal_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:curved_drawer_fork/curved_drawer_fork.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:my_web_app/screens/show_guests.dart';
import 'package:my_web_app/screens/drug_screen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:my_web_app/screens/doctor_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_web_app/screens/home_screen.dart';
import 'package:my_web_app/screens/editGuest/edit_drugs_data.dart';
import 'package:my_web_app/screens/editGuest/edit_specific_doctor.dart';
import 'package:my_web_app/screens/edit_doctor.dart';
class ShowDoctors extends StatefulWidget {
  static String id = 'show_doctors';

  const ShowDoctors({Key? key}) : super(key: key);

  @override
  State<ShowDoctors> createState() => _ShowDoctorsState();
}

class _ShowDoctorsState extends State<ShowDoctors> {
  String name = '';
  final List<String> items = [
    'Name: ',
    'Speciality'
  ];
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 2;
  double leftWidth = 75.0;
  int leftTextColor = 1;
  int leftBackgroundColor = 0;
  String selectedValue = 'Name: ';
  final List<Color> colorPallete = <Color>[
    Colors.brown.shade50,
    Colors.cyan.shade900,
  ];
  List<DrawerItem> _drawerItems = <DrawerItem>[
    DrawerItem(icon: Icon(Icons.people_alt_outlined), label: "guests"),
    DrawerItem(icon: Icon(Icons.add_comment_outlined),label: "add guest"),
    DrawerItem(icon: Icon(Icons.medical_information_outlined), label: "doctors"),
    DrawerItem(icon: Icon(Icons.vaccines),label:"drugs"),
    // DrawerItem(icon: Icon(Icons.assignment_ind_outlined),label:"help"),
  ];
  final _auth = FirebaseAuth.instance;
  signOut() async {
    await _auth.signOut();
    Navigator.pushNamed(context, HomePage.id);
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    columnRation: 0.2;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body:
      Row(
        children: [
          Container(
            width: .2*width,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  height: 60,
                  alignment: AlignmentDirectional.center,
                  color: Colors.green.shade50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                ),
                SizedBox(
                    height:40,
                    child: TextButton(
                      onPressed: (){
                        Navigator.pushNamed(context, ShowGuests.id);
                      },
                      child: Row(
                        children: [
                          SizedBox(width:30),
                          Icon(Icons.person_pin,color: Colors.green.shade700,),
                          Text(
                            'Guests',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.bold,fontSize: 20,),
                          ),
                        ],
                      ),)),
                SizedBox(height:10.0,),
                SizedBox(
                    height:40,
                    child: TextButton(
                      onPressed: (){},
                      child: Row(
                        children: [
                          Container(
                            height:40,
                            width:10,
                            color:Colors.green.shade300,
                          ),
                          SizedBox(width:20),
                          Icon(Icons.medical_information_outlined,color: Colors.green.shade800,),
                          Text('Doctors',maxLines: 2,
                            overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.bold,fontSize: 20,),),
                        ],
                      ),)),
                SizedBox(height:10.0,),
                SizedBox(
                    height:40,
                    child: TextButton(
                      onPressed: (){
                        Navigator.pushNamed(context, DrugsSheet.id);
                      },
                      child: Row(
                        children: [
                          SizedBox(width:30),
                          Icon(Icons.medication_outlined,color: Colors.green.shade800,),
                          Text('Drugs',maxLines: 2,
                            overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.bold,fontSize: 20,),),
                        ],
                      ),)),
                SizedBox(height:10.0,),
                SizedBox(
                    height:40,
                    child: TextButton(
                      onPressed: (){
                        Navigator.pushNamed(context, AddGuest.id);
                      },
                      child: Row(
                        children: [
                          SizedBox(width:30),
                          Icon(Icons.add,color: Colors.green.shade800,),
                          Text('Add Guest',maxLines: 2,
                            overflow: TextOverflow.clip,style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.bold,fontSize: 20,),),
                        ],
                      ),)),
                SizedBox(height:height-300),
                SizedBox(
                  height:40,
                  child: TextButton(
                      onPressed: () {
                        signOut();
                      },
                      child: Row(
                        children: [
                          SizedBox(width:30,),
                          Icon(
                            Icons.logout_outlined,
                            color: Colors.green.shade800,
                          ),
                          Text(
                            'SignOut',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.green.shade800,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      )),
                ),
                SizedBox(height:10.0,),
              ],
            ),
          ),
          Container(
            width: width* .8,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  height:60,
                  width: width*.7,
                  child: Text('Doctors List',style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.5),
                          offset: Offset(4, 4),
                          blurRadius: 7,
                        )
                      ]
                    // fontStyle: FontStyle.italic,
                  ),),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  height: 40,
                  width: width*.7,
                  child: TextField(
                    style: TextStyle(fontSize: 15,color: Colors.green.shade900),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.green.shade50,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.green.shade900,
                      ),
                      hintText: 'Search',
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
                      floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                              (Set<MaterialState> states) {
                            final Color color = states.contains(MaterialState.error)
                                ? Theme.of(context).colorScheme.error
                                : Colors.green.shade900;
                            return TextStyle(
                                color: color, letterSpacing: 1.3, fontSize: 15);
                          }),
                      labelStyle: MaterialStateTextStyle.resolveWith(
                              (Set<MaterialState> states) {
                            final Color color = states.contains(MaterialState.error)
                                ? Theme.of(context).colorScheme.error
                                : Colors.green.shade900;
                            return TextStyle(
                                color: color,
                                letterSpacing: 1.3,
                                height: 80,
                                fontSize: 20);
                          }),
                    ),
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                  ),
                ),
                SizedBox(height:10.0),
                SizedBox(width: width*.7,height: 1,child: ColoredBox(color: Colors.green.shade800),),
                SizedBox(
                  width:width*.7,
                  height:30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: .2*width*.7,
                        child: Text(
                          'Name',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.green.shade800,
                              fontSize: 19,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width:width*.7*.01),
                      SizedBox(
                        width: .2*width*.7,
                        child: Text(
                          'Speciality',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.green.shade800,
                              fontSize: 19,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width:width*.7*.01),
                      SizedBox(
                        width: .2*width*.7,
                        child: Text(
                          'Address',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.green.shade800,
                              fontSize: 19,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width:width*.7*.01),
                      SizedBox(
                        width: .2*width*.7,
                        child: Text(
                          'Contacts',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.green.shade800,
                              fontSize: 19,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width:width*.7*.01),
                      SizedBox(
                        width: .15*width*.7,
                        child: Text(
                          'Patients',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.green.shade800,
                              fontSize: 19,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: width*.7,height: 1,child: ColoredBox(color: Colors.green.shade800),),
                Expanded(
                  child: StreamBuilder<QuerySnapshot> (
                    stream: FirebaseFirestore.instance.collection('Doctors').snapshots(),
                    builder: (context, snapshots) {
                      return (snapshots.connectionState == ConnectionState.waiting)
                          ? Center(
                        child: CircularProgressIndicator(),)
                          : ListView.builder(
                          itemCount: snapshots.data!.docs.length,
                          itemBuilder: (context, index){
                            var data = snapshots.data!.docs[index].data() as Map<String,dynamic>;
                            String docItem = snapshots.data!.docs[index].id;
                            var users = data['No. of doctor users'];
                            if(name.isEmpty) {
                              return Column(
                                children: [
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(width:width*.8*.06),
                                        SizedBox(
                                          width: .2*width*.7,
                                          child: AutoSizeText(
                                            data['Name: '],
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
                                        SizedBox(width:width*.01),
                                        SizedBox(
                                          width: .2*width*.7,
                                          child: AutoSizeText(
                                            data['Speciality: '],
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.brown.shade800,
                                                fontSize: 16,
                                                // fontWeight: FontWeight.bold
                                            ),
                                            minFontSize: 10,
                                            // maxFontSize: 20,
                                          ),
                                        ),
                                        SizedBox(width:width*.01),
                                        SizedBox(
                                          width: .2*width*.7,
                                          child: AutoSizeText(
                                            data['Address: '],
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.brown.shade800,
                                                fontSize: 16,
                                                // fontWeight: FontWeight.bold
                                            ),
                                            minFontSize: 10,
                                            // maxFontSize: 20,
                                          ),
                                        ),
                                        SizedBox(width:width*.01),
                                        SizedBox(
                                          width: .2*width*.7,
                                          child: AutoSizeText(
                                            data['Contacts: '],
                                            maxLines: 5,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.brown.shade800,
                                                fontSize: 16,
                                                // fontWeight: FontWeight.bold
                                            ),
                                            minFontSize: 10,
                                            // maxFontSize: 20,
                                          ),
                                        ),
                                        SizedBox(width:width*.01),
                                        SizedBox(
                                          width: .15*width*.7,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              AutoSizeText(
                                                '$users',
                                                maxLines: 5,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.brown.shade800,
                                                  fontSize: 16,
                                                  // fontWeight: FontWeight.bold
                                                ),
                                                minFontSize: 10,
                                                // maxFontSize: 20,
                                              ),
                                              Column(
                                                children: [
                                                  IconButton(
                                                      onPressed: (){
                                                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                                                            EditDoctor(thisDoctor: data, doctorID: docItem)));
                                                      }, icon: Icon(Icons.edit_outlined,color: Colors.green.shade800,)),
                                                  IconButton(
                                                      onPressed: () async{
                                                        if(users == 1){
                                                          await FirebaseFirestore.instance.collection('Doctors').doc(docItem).delete();
                                                        } else{
                                                          await FirebaseFirestore.instance.collection('Doctors').doc(docItem).set({
                                                            'No. of doctor users': FieldValue.increment(-1)
                                                          }, SetOptions(merge: true));
                                                        }

                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              '${data['Name: ']} is deleted',
                                                              style: TextStyle(
                                                                color: Colors.red[100],
                                                              ),
                                                            ),
                                                            action: SnackBarAction(
                                                              label: 'Undo',
                                                              onPressed: () async {
                                                                if(users > 1){
                                                                  await FirebaseFirestore.instance.collection('Doctors').doc(docItem).set({
                                                                    'No. of doctor users': FieldValue.increment(1)
                                                                  }, SetOptions(merge: true));
                                                                } else{
                                                                  await FirebaseFirestore.instance.collection('Doctors').doc(docItem).set(data);
                                                                }
                                                              },
                                                            ),
                                                          )
                                                        );
                                                      },
                                                      icon: Icon(Icons.delete,color: Colors.green.shade800,)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                  SizedBox(width: width*.7,height: 1,child: ColoredBox(color: Colors.green.shade800),),

                                ],
                              );
                            }
                            if((data['Name: '].toString().toLowerCase().startsWith(name.toLowerCase()))||
                                (data['Speciality: '].toString().toLowerCase().startsWith(name.toLowerCase()))){
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(width:width*.8*.06),
                                      SizedBox(
                                        width: .2*width*.7,
                                        child: AutoSizeText(
                                          data['Name: '],
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
                                      SizedBox(width:width*.01),
                                      SizedBox(
                                        width: .2*width*.7,
                                        child: AutoSizeText(
                                          data['Speciality: '],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.brown.shade800,
                                            fontSize: 16,
                                            // fontWeight: FontWeight.bold
                                          ),
                                          minFontSize: 10,
                                          // maxFontSize: 20,
                                        ),
                                      ),
                                      SizedBox(width:width*.01),
                                      SizedBox(
                                        width: .2*width*.7,
                                        child: AutoSizeText(
                                          data['Address: '],
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.brown.shade800,
                                            fontSize: 16,
                                            // fontWeight: FontWeight.bold
                                          ),
                                          minFontSize: 10,
                                          // maxFontSize: 20,
                                        ),
                                      ),
                                      SizedBox(width:width*.01),
                                      SizedBox(
                                        width: .2*width*.7,
                                        child: AutoSizeText(
                                          data['Contacts: '],
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.brown.shade800,
                                            fontSize: 16,
                                            // fontWeight: FontWeight.bold
                                          ),
                                          minFontSize: 10,
                                          // maxFontSize: 20,
                                        ),
                                      ),
                                      SizedBox(width:width*.01),
                                      SizedBox(
                                        width: .15*width*.7,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            AutoSizeText(
                                              '$users',
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.brown.shade800,
                                                fontSize: 16,
                                                // fontWeight: FontWeight.bold
                                              ),
                                              minFontSize: 10,
                                              // maxFontSize: 20,
                                            ),
                                            Column(
                                              children: [
                                                IconButton(
                                                    onPressed: (){
                                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                                                          EditDoctor(thisDoctor: data, doctorID: docItem)));
                                                    }, icon: Icon(Icons.edit_outlined,color: Colors.green.shade800,)),
                                                IconButton(
                                                    onPressed: (){},
                                                    icon: Icon(Icons.delete,color: Colors.green.shade800,)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                  SizedBox(width: width*.7,height: 1,child: ColoredBox(color: Colors.green.shade800),),

                                ],
                              );
                            }
                            return Container();
                          }
                      );
                    },
                  ),
                ),
                SizedBox(width: width,height: 1,child: ColoredBox(color: Colors.grey),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
