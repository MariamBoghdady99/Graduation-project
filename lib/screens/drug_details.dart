import 'package:flutter/material.dart';

class DrugsDetails extends StatelessWidget {

  static String id = 'drugs_details';

  const DrugsDetails({Key? key, required this.drugsDetails}) : super(key: key);

  final Map<String, dynamic> drugsDetails;
  //final String DocItem;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        backgroundColor: Colors.cyan[900],
        title: Text(
          '${drugsDetails['Drug Name']}\'s Information',
          style: TextStyle(color:Colors.brown[50]),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                SizedBox(
                  height: .3*height,
                  width: .3 * width,
                  child: InputDecorator(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    child: Container(
                      child: Image.network('${drugsDetails['DrugImage']}',
                      fit: BoxFit.cover,
                      ),
                      height: .3*height,
                      width: .3 * width,

                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Name:',style: TextStyle(color: Colors.cyan[900],fontWeight: FontWeight.bold),),
                        SizedBox(width: 5,),
                        Text(
                          drugsDetails['Drug Name'],
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              // fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text('Serial Number',style: TextStyle(color: Colors.cyan[900],fontWeight: FontWeight.bold),),
                        SizedBox(width: 5,),
                        Text(
                          drugsDetails['Drug Serial Number'],
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              // fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
