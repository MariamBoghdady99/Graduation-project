import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_web_app/screens/add_guest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_web_app/screens/guest_details.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_web_app/screens/principal_screen.dart';
import 'package:curved_drawer_fork/curved_drawer_fork.dart';
import 'package:my_web_app/screens/drug_screen.dart';
import 'package:my_web_app/screens/show_doctors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_web_app/screens/home_screen.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
final double lastPoint = data.last;
final double secondLastPoint = data[data.length - 2];

String name = ""; //user's response will be assigned to this variable
int steps = 0 ;
int heart = 0 ;//will be displayed on the screen once we get the data from the server
int saturation = 0 ;
double saturation1 = 100.0;
double temp = 0 ;
double steps1 = 0.0;
double steps0 = 52000.0;
double heart1 = 0.0;
double heart0 = 100.0;
double temp0 = 40.0;
double temp1 = 37.5;
late double newData;
List<double> data = [20, 37.5, 37.8, 38, 38.01, 38.01];
Future<dynamic> function () async {
  final url = Uri.parse("http://127.0.0.1:5000/name");
  //getting data from the python server script and assigning it to response
  final response = await http.get(url);
  //sending a post request to the url
  steps= json.decode(response.body)['response'];
  steps1 = steps.toDouble();
  // heart = json.decode(response.body)['response']['HRAPI'];
  // heart1 = heart.toDouble();
  // saturation = json.decode(response.body)['response']['SPO2HW'];
  // saturation1 = saturation.toDouble();
  // temp = json.decode(response.body)['response']['TempHW'];
  // temp1 = temp.toDouble();
  // if((temp1 == data.last) || (temp1==data[data.length-1])){
  //   newData=0;
  // }else{
  //   newData=temp1;
  // };
  double newData = steps1;
  updateData(newData);
  print(data);
  // newData = temp1 + 1;
  // updateData(newData);
  // print(data);
  // newData = temp1 + 4;
  // updateData(newData);
  // print(data);
  // FirstPage myChart = FirstPage.of(context); // Get the instance of MyChart
  // myChart.updateData(newData);
  print('here');
  return [temp1,heart1,steps1,saturation1];
}
void updateData(double newData1){

    data.add(newData);
    print('zzz');

}

class ShowGuests extends StatefulWidget {

  static String id = 'show_guests_screen';

  const ShowGuests({Key? key}) : super(key: key);

  @override
  State<ShowGuests> createState() => _ShowGuestsState();
}

class _ShowGuestsState extends State<ShowGuests> {

  String name = '';
  int index = 0;
  double leftWidth = 75.0;
  int leftTextColor = 1;
  int leftBackgroundColor = 0;
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
  initState(){
    super.initState();
    setState(() {
      // print(data);
      function();
      // updateData(temp1);
    });
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
      backgroundColor: Colors.grey.shade100,
      body: Row(
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
                      onPressed: (){},
                      child: Row(
                        children: [
                          Container(
                            height:40,
                            width:10,
                            color:Colors.green.shade300,
                          ),
                          SizedBox(width:20),
                          Icon(Icons.person_pin,color: Colors.green.shade700,),
                          Text('Guests',style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.bold,fontSize: 20,),),
                        ],
                      ),)),
                SizedBox(height:10.0,),
                SizedBox(
                    height:40,
                    child: TextButton(
                      onPressed: (){
                        Navigator.pushNamed(context, ShowDoctors.id);
                      },
                      child: Row(
                        children: [
                          SizedBox(width:30),
                          Icon(Icons.medical_information_outlined,color: Colors.green.shade800,),
                          Text('Doctors',style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.bold,fontSize: 20,),),
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
                          Text('Drugs',style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.bold,fontSize: 20,),),
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
                          Text('Add Guest',style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.bold,fontSize: 20,),),
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
              children: [
                // TextButton(
                //   onPressed: () async {
                //     function();
                //     setState(() {
                //       print(temp);
                //       print(saturation);
                //       print(steps);
                //       print(heart);
                //     });
                //
                //   },
                //   child: Text('GET'),
                //   // style: ButtonStyle(backgroundColor: Color(0xFFE3F2FD)),
                // ),
                // displays the data on the screen
                Container(
                  alignment: Alignment.centerLeft,
                  height:60,
                  width: width*.7,
                  child: Text('Patients List',style: TextStyle(
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
                        width: .27*width*.7,
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
                      SizedBox(
                        width: .18*width*.7,
                        child: Text(
                          'Room',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.green.shade800,
                              fontSize: 19,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: .18*width*.7,
                        child: Row(
                          children: [
                            Text(
                              'Temp (°C)',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.green.shade800,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                            ),
                            // Icon(Icons.ce)
                          ],
                        ),
                      ),
                      SizedBox(
                        width: .18*width*.7,
                        child: Text(
                          'Heart Rate (bpm)',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.green.shade800,
                              fontSize: 19,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: .18*width*.7,
                        child: Text(
                          'SPO2 (%)',
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
                    stream: FirebaseFirestore.instance.collection('Guests').snapshots(),
                    builder: (context, snapshots) {
                      return (snapshots.connectionState == ConnectionState.waiting)
                          ? Center(
                        child: CircularProgressIndicator(),)
                          : ListView.builder(
                          itemCount: snapshots.data!.docs.length,
                          itemBuilder: (context, index){
                            var data = snapshots.data!.docs[index].data() as Map<String,dynamic>;
                            String docItem = snapshots.data!.docs[index].id;
                            Map<String, dynamic> sensors = data['sensors'] as Map<String, dynamic>;
                            if(name.isEmpty) {
                              return SizedBox(
                                width:.7*width,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(width:width*.8*.06),
                                        SizedBox(
                                          width: .28*width*.7,
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundImage: NetworkImage(data['Image']),
                                                minRadius: 20,
                                                maxRadius: 25,),
                                              AutoSizeText(
                                                data['Name'],
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.brown.shade800,
                                                  fontSize: 16,
                                                  // fontWeight: FontWeight.bold
                                                ),
                                                minFontSize: 10,

                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: .18*width*.7,
                                          child: AutoSizeText(
                                            data['Room number'],
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
                                        SizedBox(
                                          width: .18*width*.7,
                                          child: AutoSizeText(
                                            temp.toString(),
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
                                        SizedBox(
                                          width: .18*width*.7,
                                          child: AutoSizeText(
                                            heart.toString(),
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
                                        SizedBox(
                                          width: .18*width*.7,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              AutoSizeText(
                                                sensors['spo2'],
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
                                              Column(
                                                children: [
                                                  IconButton(
                                                    onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                                        GuestDetails(guestDetails: data, docId: docItem,),),);},
                                                    icon: Icon(Icons.edit_outlined,color: Colors.green.shade800,),
                                                  ),
                                                  IconButton(
                                                    onPressed: () async {
                                                      await FirebaseFirestore.instance.collection('Guests').doc(docItem).delete();

                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(
                                                            content: Text(
                                                              '${data['Name']} is deleted',
                                                              style: TextStyle(
                                                                color: Colors.red[100],
                                                              ),
                                                            ),
                                                          action: SnackBarAction(
                                                            label: 'Undo',
                                                            onPressed: () async {
                                                              try{
                                                                await FirebaseFirestore.instance.collection('Guests').doc(docItem).set(data);
                                                              } catch(e){
                                                                print(e);
                                                              }

                                                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                            },
                                                          ),
                                                        )
                                                      );
                                                    },
                                                    icon: Icon(Icons.delete,color: Colors.green.shade800,),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: width*.7,height: 1,child: ColoredBox(color: Colors.green.shade800),),
                                  ],
                                ),
                              );
                            }
                            if((data['Name'].toString().toLowerCase().startsWith(name.toLowerCase()))||
                                (data['Room number'].toString().toLowerCase().startsWith(name.toLowerCase()))){
                              return ListTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width:width*.8*.05),
                                    SizedBox(
                                      width: .28*width*.7,
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(data['Image']),
                                            minRadius: 20,
                                            maxRadius: 25,),
                                          AutoSizeText(
                                            data['Name'],
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.brown.shade800,
                                              fontSize: 16,
                                              // fontWeight: FontWeight.bold
                                            ),
                                            minFontSize: 10,

                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: .18*width*.7,
                                      child: AutoSizeText(
                                        data['Room number'],
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
                                    SizedBox(
                                      width: .18*width*.7,
                                      child: AutoSizeText(
                                        steps.toString(),
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
                                    SizedBox(
                                      width: .18*width*.7,
                                      child: AutoSizeText(
                                        heart.toString(),
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
                                    SizedBox(
                                      width: .18*width*.7,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          AutoSizeText(
                                            sensors['spo2'],
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
                                          IconButton(
                                            onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                                GuestDetails(guestDetails: data, docId: docItem,),),);},
                                            icon: Icon(Icons.edit_outlined,color: Colors.green.shade800,),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                              );
                            }
                            return Container();
                          }
                      );
                    },
                  ),
                ),
              ],
            )
          ),
        ],
      )
    );
  }
}