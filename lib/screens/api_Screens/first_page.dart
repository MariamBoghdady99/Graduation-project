import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:my_web_app/screens/user_screens/user_doctor.dart';
import 'package:my_web_app/screens/user_screens/add_new_report.dart';
import 'package:my_web_app/screens/user_screens/userPage.dart';
// import 'package:draw_graph/draw_graph.dart';
// import 'package:draw_graph/models/feature.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
List<double> data1 = [10.0,20.0,30.0,40];
Future<dynamic> fun () async {
  final url = Uri.parse("http://127.0.0.1:5000/name");
  //getting data from the python server script and assigning it to response
  final response = await http.get(url);
  steps= json.decode(response.body)['response']['StepsAPI'];
  steps1 = steps.toDouble();
  heart = json.decode(response.body)['response']['HRHW'];
  heart1 = heart.toDouble();
  saturation = json.decode(response.body)['response']['SPO2HW'];
  saturation1 = saturation.toDouble();
  temp = json.decode(response.body)['response']['TempHW'];
  temp1 = temp.toDouble();
  // double newData = temp1;
  // data.add(temp1);
  // FirstPage myChart = FirstPage.of(context); // Get the instance of MyChart
  // myChart.updateData(newData);
  print('here');
  return [temp1,heart1,steps1,saturation1];
}



class FirstPage extends StatefulWidget {
  // fun(double) updateData{};
  static String id = 'API_page';

  const FirstPage({Key? key,required this.docID}) : super(key: key);

  final String docID;



  @override
  State<FirstPage> createState() => _FirstPageState();

  // final fun(double) updateData;

}

class _FirstPageState extends State<FirstPage> {


  final _formkey = GlobalKey<FormState>(); //key created to interact with the form


  //fun to validate and save user form
  Future<void> _savingData() async{
    final validation = _formkey.currentState?.validate();
    if (!validation!){
      return;
    }
    _formkey.currentState?.save();
  }

  //fun to add border and rounded edges to our form
  OutlineInputBorder _inputformdeco(){
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide:
      BorderSide(width: 1.0, color: Colors.blue, style: BorderStyle.solid),
    );
  }
  List<Color> gradientColors = [
  Colors.cyan,
  Colors.blue,
  ];
  bool showAvg = false;
  @override
  initState(){
    super.initState();
    setState(() {
      print('hh');
      updateData(temp1);
    });
  }


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
      appBar: AppBar(
        // leading: IconButton(onPressed: (){}, icon: Icons.add),
        title: Text('data'),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: 4,
        items: [
          Icon(Icons.medication_outlined, size: 30,),
          Icon(Icons.local_hospital_outlined, size: 30),
          Icon(Icons.home_outlined, size: 30),
          Icon(Icons.medical_information_outlined, size: 30),
          Icon(Icons.auto_graph_outlined, size: 30),
        ],
        color: Colors.green.shade200,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() async{
            if (index == 0 ){
              // final snapshot = await FirebaseFirestore.instance.collection('Guests').doc(widget.docId).get();
              // final myMap = snapshot.data() as Map<String, dynamic>;
              // Navigator.pushNamed(context, FirstPage.id);
            }
            else if (index == 1 ){
              // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
              //     UserDoctors(userID: widget.theDocID, userData: widget.theGuestData)));
            }
            else if (index == 2 ){
              // var userData  = FirebaseFirestore.instance.collection('Guests').doc(password);
              // DocumentSnapshot data = await userData.get();
              // final finalData = data.data() as Map<String, dynamic>;

              // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
              //     UserPage(theDocID: widget.docID, theGuestData: widget.finalData)));
            }
            else if (index == 3 ){
              // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
              //     NewReport(docID: widget.theDocID, userData: widget.theGuestData)));
            }
            else if (index == 4 ){
              Navigator.pushNamed(context, FirstPage.id);
            }
          });
        },
        letIndexChange: (index) => true,
      ),

      body: ListView(
        children: [
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
          SizedBox(
          width: double.infinity,
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // TextButton(
              //   onPressed: () async {
              //     // _sendDataBack(context);
              //     //url to send the get request to
              //     final url = Uri.parse("http://127.0.0.1:5000/name");
              //
              //     //getting data from the python server script and assigning it to response
              //     final response = await http.get(url);
              //     // final response = await http.get(url);
              //     // final decodedzz = json.decode(response.body);
              //     steps= json.decode(response.body)['response']['StepsAPI'];
              //     // final_response = steps;
              //     steps1 = steps.toDouble();
              //     heart = json.decode(response.body)['response']['HRHW'];
              //     heart1 = heart.toDouble();
              //     saturation = json.decode(response.body)['response']['SPO2HW'];
              //     temp = json.decode(response.body)['response']['TempHW'];
              //     temp1 = temp.toDouble();
              //     //converting the fetched data from json to key value pair that can be displayed on the screen
              //     //changing the UI be reassigning the fetched data to final response
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
              //displays the data on the screen
              Text('Your Activity',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 19,color:Colors.grey.shade600),),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: width*.3,
                    height: height * .3,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // SizedBox(height:15,),
                        Text('Heart Rate',style: TextStyle(fontSize: 18),),
                        SizedBox(height: width * .2,child: Image.asset('images/HR.png',)),
                        Text(heart.toString(),style: TextStyle(fontSize: 18),),
                        // SizedBox(height:15,),
                      ],
                    ),
                  ),
                  Container(
                    width: width*.3,
                    height: height * .3,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // SizedBox(height:15,),
                        Text('Steps',style: TextStyle(fontSize: 18),),
                        SizedBox(height:width*.2,child: Image.asset('images/steps.png',)),
                        Text(steps.toString(),style: TextStyle(fontSize: 18),),
                        // SizedBox(height:15,),
                      ],
                    ),
                  ),
                  Container(
                    width: width*.3,
                    height: height * .3,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // SizedBox(height:15,),
                        Text('Temperature',style: TextStyle(fontSize: 18),),
                        // SizedBox(height:15,),
                        SizedBox(height:width*.2,child: Image.asset('images/celsius.png',)),
                        // SizedBox(height:15,),
                        Text(temp.toString(),style: TextStyle(fontSize: 18),),
                        // SizedBox(height:15,),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: (width*.05)/3,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: width*.3,
                    height: height * .3,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // SizedBox(height:15,),
                        Text('Oxygen Saturation',style: TextStyle(fontSize: 18),),
                        // SizedBox(height:15,),
                        SizedBox(height:width*.2,child: Image.asset('images/pressure.png',)),
                        // SizedBox(height:15,),
                        Text(saturation.toString(),style: TextStyle(fontSize: 18),),
                        // SizedBox(height:15,),
                      ],
                    ),
                  ),
                  SizedBox(width: width*.1/3,),
                  Container(
                    width: width*.3,
                    height: height * .3,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // SizedBox(height:15,),
                        Text('Sensor 5',style: TextStyle(fontSize: 18),),
                        // SizedBox(height:15,),
                        SizedBox(height:width*.2,child: Image.asset('images/celsius.png',)),
                        // SizedBox(height:15,),
                        Text('data 5',style: TextStyle(fontSize: 18),),
                        // SizedBox(height:15,),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        ]
      ),
    );
  }

  // void _sendDataBack(BuildContext context) {
  //   String textToSendBack = final_response.toString();
  //   Navigator.pop(context, textToSendBack);
  // }
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
          //   FlSpot(0, 30),
          //   FlSpot(2, 20),
          //   FlSpot(4, 50),
          //   FlSpot(6, 31),
          //   FlSpot(8, 40),
          //   FlSpot(9, 30),
          //   FlSpot(11, 40),
          //   FlSpot(12, (temp)),
          // ],
          spots: data1.map((e)=>FlSpot(data1.indexOf(e).toDouble(), e)).toList(),
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
  void updateData(double newData1){
    setState(() {
      data1.add(newData1);
      print('zzz');
    });
  }

}
