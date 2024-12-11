import 'dart:async';
import 'package:flutter/material.dart';


class UserName {
  String name1 = '';
  UserName(String name) {
    this.name1 = name;
  }
}

class PrincipalPage extends StatefulWidget {
  // final String user;
  static String id = 'principal_screen';
  const PrincipalPage({Key? key}) : super(key: key);

  @override
  State<PrincipalPage> createState() => _PrincipalPageState();
}
class _PrincipalPageState extends State<PrincipalPage> {
  // late List<LiveData> chartData;
  // late ChartSeriesController _chartSeriesController;
  // int time = 60;
  // void updateDataSource(Timer timer) {
  //   chartData.add(LiveData(time+1, temp1));
  //   chartData.removeAt(0);
  //   _chartSeriesController.updateDataSource(
  //       addedDataIndex: chartData.length - 1, removedDataIndex: 0);
  // }
  // List<LiveData> getChartData() {
  //   return <LiveData>[
  //     LiveData(0, 37),
  //     LiveData(15, 38),
  //     LiveData(30, 37.5),
  //     LiveData(45, 37.6),
  //     LiveData(60, 37.4),
  //     // LiveData(5, temp1),
  //     // LiveData(6, temp1),
  //     // LiveData(7, 51),
  //     // LiveData(8, 98),
  //     // LiveData(9, 41),
  //     // LiveData(10, 53),
  //     // LiveData(11, 72),
  //     // LiveData(12, 86),
  //     // LiveData(13, 52),
  //     // LiveData(14, 94),
  //     // LiveData(15, temp1),
  //     // LiveData(16, 86),
  //     // LiveData(30, temp1),
  //     // LiveData(45, temp1),
  //     // LiveData(60, temp1),
  //   ];
  // }
  // void initState(){
  //   chartData = getChartData();
  //   Timer.periodic(const Duration(minutes: 1),updateDataSource);
  //   super.initState();
  // }
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
        appBar: AppBar(
          title: const Text('Trials'),
        ),
        body: Container(
          color:Colors.green.shade100,
          width:width*.5,
          height:height*.5,
          child: Text('Welcome'),
        ),
    );
  }
}
class LiveData {
  LiveData(this.time, this.speed);
  final int time;
  final num speed;
}


//trials
// class _BarChart extends StatelessWidget {
//   const _BarChart();
//
//   @override
//   Widget build(BuildContext context) {
//     return BarChart(
//       BarChartData(
//         barTouchData: barTouchData,
//         titlesData: titlesData,
//         borderData: borderData,
//         barGroups: barGroups,
//         gridData: FlGridData(show: false),
//         alignment: BarChartAlignment.spaceAround,
//         maxY: 20,
//       ),
//     );
//   }
//
//   BarTouchData get barTouchData => BarTouchData(
//     enabled: false,
//     touchTooltipData: BarTouchTooltipData(
//       tooltipBgColor: Colors.transparent,
//       tooltipPadding: EdgeInsets.zero,
//       tooltipMargin: 8,
//       getTooltipItem: (
//           BarChartGroupData group,
//           int groupIndex,
//           BarChartRodData rod,
//           int rodIndex,
//           ) {
//         return BarTooltipItem(
//           rod.toY.round().toString(),
//           const TextStyle(
//             color: Colors.cyan,
//             fontWeight: FontWeight.bold,
//           ),
//         );
//       },
//     ),
//   );
//
//   Widget getTitles(double value, TitleMeta meta) {
//     final style = TextStyle(
//       color: Colors.blue,
//       fontWeight: FontWeight.bold,
//       fontSize: 14,
//     );
//     String text;
//     switch (value.toInt()) {
//       case 0:
//         text = 'Mn';
//         break;
//       case 1:
//         text = 'Te';
//         break;
//       case 2:
//         text = 'Wd';
//         break;
//       case 3:
//         text = 'Tu';
//         break;
//       case 4:
//         text = 'Fr';
//         break;
//       case 5:
//         text = 'St';
//         break;
//       case 6:
//         text = 'Sn';
//         break;
//       default:
//         text = '';
//         break;
//     }
//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       space: 4,
//       child: Text(text, style: style),
//     );
//   }
//
//   FlTitlesData get titlesData => FlTitlesData(
//     show: true,
//     bottomTitles: AxisTitles(
//       sideTitles: SideTitles(
//         showTitles: true,
//         reservedSize: 30,
//         getTitlesWidget: getTitles,
//       ),
//     ),
//     leftTitles: AxisTitles(
//       sideTitles: SideTitles(showTitles: true),
//     ),
//     topTitles: AxisTitles(
//       sideTitles: SideTitles(showTitles: false),
//     ),
//     rightTitles: AxisTitles(
//       sideTitles: SideTitles(showTitles: false),
//     ),
//   );
//
//   FlBorderData get borderData => FlBorderData(
//     show: true,
//   );
//
//   LinearGradient get _barsGradient => LinearGradient(
//     colors: [
//       Colors.blue,
//       Colors.cyan,
//     ],
//     begin: Alignment.bottomCenter,
//     end: Alignment.topCenter,
//   );
//
//   List<BarChartGroupData> get barGroups => [
//     BarChartGroupData(
//       x: 0,
//       barRods: [
//         BarChartRodData(
//           toY: temp1,
//           gradient: _barsGradient,
//         )
//       ],
//       showingTooltipIndicators: [0],
//     ),
//     BarChartGroupData(
//       x: 1,
//       barRods: [
//         BarChartRodData(
//           toY: 10,
//           gradient: _barsGradient,
//         )
//       ],
//       showingTooltipIndicators: [0],
//     ),
//     BarChartGroupData(
//       x: 2,
//       barRods: [
//         BarChartRodData(
//           toY: 14,
//           gradient: _barsGradient,
//         )
//       ],
//       showingTooltipIndicators: [0],
//     ),
//     BarChartGroupData(
//       x: 3,
//       barRods: [
//         BarChartRodData(
//           toY: 15,
//           gradient: _barsGradient,
//         )
//       ],
//       showingTooltipIndicators: [0],
//     ),
//     BarChartGroupData(
//       x: 4,
//       barRods: [
//         BarChartRodData(
//           toY: 13,
//           gradient: _barsGradient,
//         )
//       ],
//       showingTooltipIndicators: [0],
//     ),
//     BarChartGroupData(
//       x: 5,
//       barRods: [
//         BarChartRodData(
//           toY: 10,
//           gradient: _barsGradient,
//         )
//       ],
//       showingTooltipIndicators: [0],
//     ),
//     BarChartGroupData(
//       x: 6,
//       barRods: [
//         BarChartRodData(
//           toY: 16,
//           gradient: _barsGradient,
//         )
//       ],
//       showingTooltipIndicators: [0],
//     ),
//   ];
// }
//
// class PrincipalPage extends StatefulWidget {
//   static String id = 'principal_screen';
//   const PrincipalPage({Key? key}) : super(key: key);
//   // const PrincipalPage({super.key});
//
//   @override
//   State<StatefulWidget> createState() => PrincipalPageState();
// }
//
// class PrincipalPageState extends State<PrincipalPage> {
//   @override
//   Widget build(BuildContext context) {
//     return const AspectRatio(
//       aspectRatio: 1.6,
//       child: _BarChart(),
//     );
//   }
// }