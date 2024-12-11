import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_web_app/screens/editGuest/edit_personal_data.dart';
import 'package:my_web_app/screens/editGuest/edit_relative_data.dart';
import 'package:my_web_app/screens/editGuest/edit_drugs_data.dart';
import 'package:my_web_app/screens/editGuest/edit_doctors_data.dart';
import 'package:my_web_app/screens/show_guests.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GuestDetails extends StatefulWidget {
  static String id = 'guests_details';

  const GuestDetails({Key? key, required this.guestDetails, required this.docId}) : super(key: key);

  final Map<String, dynamic> guestDetails;
  final String docId;

  @override
  State<GuestDetails> createState() => _GuestDetailsState();
}

class _GuestDetailsState extends State<GuestDetails> {
  List<Color> gradientColors = [
    Colors.cyan,
    Colors.blue,
  ];
  bool showAvg = false;
  initState(){
    super.initState();
    setState(() {
      // print(data);
      function();
      // updateData(temp1);
      // updateData(temp1+1);
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

    DateTime today = DateTime.now();
    String guestBirthDate = widget.guestDetails['Age'];
    DateTime birthDate = DateFormat('yyyy-MM-dd').parse(guestBirthDate);
    int guestAge = today.year - birthDate.year;

    return Scaffold(
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
                          Navigator.pushNamed(context, ShowGuests.id);
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
                  child: Text('${widget.guestDetails['Name']}\'s Information',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),
                ),
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
                            DoctorsData(docId: widget.docId)));
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
          Container(
            width:width*.8,
            child: ListView(
                children : [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: width*.4,
                        height:height*.4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: height*.4,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(widget.guestDetails['Image']),
                                minRadius: 80,
                                maxRadius: 100,),
                            ),
                            SizedBox(width: 20.0,),
                            Container(
                              width:.15*width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Patient',
                                    style: TextStyle(
                                        color: Colors.brown.shade900,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(height:5,),
                                  Text(
                                    widget.guestDetails['Name'],
                                    style: TextStyle(
                                      color: Colors.brown.shade900,
                                      fontSize: 23,
                                      // fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(height:10,),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                          PersonalEdit(personalData: widget.guestDetails, docID: widget.docId)));
                                    },
                                    child: Text('Edit',style: TextStyle(color: Colors.brown.shade50),),
                                    style: ElevatedButton.styleFrom(
                                      shape: StadiumBorder(),
                                      primary: Colors.grey,
                                      onPrimary: Colors.white,
                                      onSurface: Colors.grey.shade300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: width*.3,
                        height:height*.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text('Gender: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                Text(
                                  widget.guestDetails['Gender'],
                                  style: TextStyle(
                                      color: Colors.green.shade700,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text('Age: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                Text(
                                  '$guestAge',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.green.shade700,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text('Room Number: ',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                  ),
                                ),
                                Text(
                                  widget.guestDetails['Room number'],
                                  style: TextStyle(
                                      color: Colors.green.shade700,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  AspectRatio(
                    aspectRatio: 2.0,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 18,
                        left: 12,
                        top: 24,
                        bottom: 12,
                      ),
                      child: LineChart(
                        showAvg ? avgData() : mainData(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    height: 34,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          showAvg = !showAvg;
                        });
                      },
                      child: Text(
                        'avg',
                        style: TextStyle(
                          fontSize: 12,
                          color: showAvg ? Colors.black.withOpacity(0.5) : Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: width*.25,
                        height: height*.4,
                        color: Colors.yellow,
                        child: Text('temp'),
                      ),
                      Container(
                        width: width*.25,
                        height: height*.4,
                        color: Colors.yellow.shade800,
                        child: Text('temp'),
                      ),
                      Container(
                        width: width*.25,
                        height: height*.4,
                        color: Colors.yellow.shade50,
                        child: Text('temp'),
                      ),
                    ],
                  ),
                  SizedBox(height: 24,),
                ]
            ),
          ),
        ],
      ),
    );
  }
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.brown,
      fontWeight: FontWeight.bold,

      fontSize: 16,

    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('1', style: style);
        break;
      case 2:
        text = const Text('2', style: style);
        break;
      case 3:
        text = const Text('3', style: style);
        break;
      case 4:
        text = const Text('4', style: style);
        break;
      case 5:
        text = const Text('5', style: style);
        break;
      case 6:
        text = const Text('6', style: style);
        break;
      case 7:
        text = const Text('7', style: style);
        break;
      case 8:
        text = const Text('8', style: style);
        break;
      case 9:
        text = const Text('9', style: style);
        break;
      case 10:
        text = const Text('10', style: style);
        break;
      case 11:
        text = const Text('11', style: style);
        break;
      case 12:
        text = const Text('12', style: style);
        break;
    // case 13:
    //   text = const Text('13', style: style);
    //   break;
    // case 14:
    //   text = const Text('14', style: style);
    //   break;
    // case 15:
    //   text = const Text('15', style: style);
    //   break;
    // case 16:
    //   text = const Text('16', style: style);
    //   break;
    // case 17:
    //   text = const Text('17', style: style);
    //   break;
    // case 18:
    //   text = const Text('18', style: style);
    //   break;
    // case 19:
    //   text = const Text('19', style: style);
    //   break;
    // case 20:
    //   text = const Text('20', style: style);
    //   break;
    // case 21:
    //   text = const Text('21', style: style);
    //   break;
    // case 22:
    //   text = const Text('22', style: style);
    //   break;
    // case 23:
    //   text = const Text('23', style: style);
    //   break;
    // case 24:
    //   text = const Text('24', style: style);
    //   break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.brown,
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 10:
        text = '10%';
        break;
      case 20:
        text = '20%';
        break;
      case 30:
        text = '30%';
        break;
      case 40:
        text = '40%';
        break;
      case 50:
        text = '50%';
        break;
      case 60:
        text = '60%';
        break;
      case 70:
        text = '70%';
        break;
      case 80:
        text = '80%';
        break;
      case 90:
        text = '90%';
        break;
      case 100:
        text = '100%';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      backgroundColor: Colors.grey.shade200,
      gridData: FlGridData(
        show: false,
        drawVerticalLine: false,
        // space betwween lines
        horizontalInterval: .5,
        verticalInterval: 1,
        //size of lines
        // getDrawingHorizontalLine: (value) {
        //   return FlLine(
        //     color: Colors.blueGrey,
        //     strokeWidth: 1,
        //   );
        // },
        // getDrawingVerticalLine: (value) {
        //   return FlLine(
        //     color: Colors.grey,
        //     strokeWidth: 1,
        //   );
        // },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 12,
      minY: 0,
      maxY: 100,
      lineBarsData: [
        LineChartBarData(
          // spots: [ // data of the curver
          //   FlSpot(0, 20),
          //   FlSpot(2, 37.5),
          //   FlSpot(4, 37.8),
          //   FlSpot(6, 38.01),
          //   FlSpot(8, 38.01),
          //   FlSpot(9, 38),
          //   FlSpot(11, 38.01),
          //   FlSpot(12, 38.01),
          // ],
          spots: data.map((e)=>FlSpot(data.indexOf(e).toDouble(), e)).toList(),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          // width of curve
          barWidth: 5,
          isStrokeCapRound: false,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: false,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


// class GuestDetails extends StatelessWidget {
//
//   static String id = 'guests_details';
//
//   const GuestDetails({Key? key, required this.guestDetails, required this.docId}) : super(key: key);
//
//   final Map<String, dynamic> guestDetails;
//   final String docId;
//   //final Map drugs;
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     double height = MediaQuery
//         .of(context)
//         .size
//         .height;
//     double width = MediaQuery
//         .of(context)
//         .size
//         .width;
//
//     DateTime today = DateTime.now();
//     String guestBirthDate = guestDetails['Age'];
//     DateTime birthDate = DateFormat('yyyy-MM-dd').parse(guestBirthDate);
//     int guestAge = today.year - birthDate.year;
//
//     return Scaffold(
//       body: Row(
//         children: [
//           Container(
//             width: .2*width,
//             color: Colors.white,
//             child: Column(
//               children: [
//                 Container(
//                   color: Colors.white,
//                   width: width*.2,
//                   child: Row(
//                     children: [
//                       IconButton(
//                         onPressed: (){
//                           Navigator.pushNamed(context, ShowGuests.id);
//                         },
//                         icon: Icon(Icons.arrow_back,color: Colors.green.shade900,),
//                       ),
//                       SizedBox(
//                         width: width * .05,
//                         child: Image.asset('images/OIG.png')
//                       ),
//                       Text(
//                         'CURA',
//                         style: TextStyle(
//                           color: Colors.green.shade900,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           fontStyle: FontStyle.italic,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   alignment: Alignment.bottomCenter,
//                   width: .2*width,
//                   height: height*.3,
//                   color:Colors.green.shade200,
//                   child: Text('${guestDetails['Name']}\'s Information',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),
//                 ),
//                 SizedBox(
//                     width: .2*width,
//                     height:40,
//                     child: TextButton(
//                       onPressed: (){
//                         Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
//                             RelativeEdit(docID: docId)));
//                       },
//                       child: Row(
//                         children: [
//                           Icon(Icons.person_pin,color: Colors.green.shade800,),
//                           Text('Relative',style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.bold,fontSize: 20,),),
//                         ],
//                       ),)),
//                 SizedBox(height:10.0,),
//                 SizedBox(
//                     width: .2*width,
//                     height:40,
//                     child: TextButton(
//                       onPressed: (){
//                         Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
//                             DoctorsData(docId: docId)));
//                       },
//                       child: Row(
//                         children: [
//                           Icon(Icons.medical_information_outlined,color: Colors.green.shade800,),
//                           Text('Doctors',style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.bold,fontSize: 20,),),
//                         ],
//                       ),)),
//                 SizedBox(height:10.0,),
//                 SizedBox(
//                     width: .2*width,
//                     height:40,
//                     child: TextButton(
//                       onPressed: (){
//                         Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
//                             DrugsData(docId: docId)));
//                       },
//                       child: Row(
//                         children: [
//                           Icon(Icons.medication_outlined,color: Colors.green.shade800,),
//                           Text('Drugs',style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.bold,fontSize: 20,),),
//                         ],
//                       ),)),
//               ],
//             ),
//           ),
//           Container(
//             width:width*.8,
//             child: ListView(
//                 children : [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Container(
//                         width: width*.4,
//                         height:height*.4,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Container(
//                               height: height*.4,
//                               child: CircleAvatar(
//                                 backgroundImage: NetworkImage(guestDetails['Image']),
//                                 minRadius: 80,
//                                 maxRadius: 100,),
//                             ),
//                             SizedBox(width: 20.0,),
//                             Container(
//                               width:.15*width,
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Patient',
//                                     style: TextStyle(
//                                         color: Colors.brown.shade900,
//                                         fontSize: 25,
//                                         fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                   SizedBox(height:5,),
//                                   Text(
//                                     guestDetails['Name'],
//                                     style: TextStyle(
//                                       color: Colors.brown.shade900,
//                                       fontSize: 23,
//                                       // fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                   SizedBox(height:10,),
//                                   ElevatedButton(
//                                     onPressed: () {
//                                       Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
//                                           PersonalEdit(personalData: guestDetails, docID: docId)));
//                                     },
//                                     child: Text('Edit',style: TextStyle(color: Colors.brown.shade50),),
//                                     style: ElevatedButton.styleFrom(
//                                       shape: StadiumBorder(),
//                                       primary: Colors.grey,
//                                       onPrimary: Colors.white,
//                                       onSurface: Colors.grey.shade300,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         width: width*.3,
//                         height:height*.4,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Row(
//                               children: [
//                                 Text('Gender: ',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 14.0,
//                                     color: Colors.grey.shade600,
//                                   ),
//                                 ),
//                                 Text(
//                                   guestDetails['Gender'],
//                                   style: TextStyle(
//                                       color: Colors.green.shade700,
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 10),
//                             Row(
//                               children: [
//                                 Text('Age: ',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 14.0,
//                                     color: Colors.grey.shade600,
//                                   ),
//                                 ),
//                                 Text(
//                                   '$guestAge',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 14,
//                                     color: Colors.green.shade700,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 10),
//                             Row(
//                               children: [
//                                 Text('Room Number: ',
//                                   style: TextStyle(
//                                     color: Colors.grey.shade600,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 14.0,
//                                   ),
//                                 ),
//                                 Text(
//                                   guestDetails['Room number'],
//                                   style: TextStyle(
//                                       color: Colors.green.shade700,
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         width: width*.25,
//                         height: height*.4,
//                         color: Colors.yellow,
//                         child: Text('temp'),
//                       ),
//                       Container(
//                         width: width*.25,
//                         height: height*.4,
//                         color: Colors.yellow.shade800,
//                         child: Text('temp'),
//                       ),
//                       Container(
//                         width: width*.25,
//                         height: height*.4,
//                         color: Colors.yellow.shade50,
//                         child: Text('temp'),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 24,),
//                 ]
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
