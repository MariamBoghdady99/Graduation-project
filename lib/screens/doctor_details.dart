import 'package:flutter/material.dart';

class DoctorDetails extends StatelessWidget {

  static String id = 'doctors_details';

  const DoctorDetails({Key? key, required this.doctorDetails}) : super(key: key);

  final Map<String, dynamic> doctorDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        backgroundColor: Colors.cyan[900],
        title: Text(
          '${doctorDetails['Name: ']}\'s Information',
          style: TextStyle(color:Colors.brown[50]),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                        'Name: ',
                      style: TextStyle(
                          color: Colors.cyan[900],
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5,),
                    Text(
                      doctorDetails['Name: '],
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          // fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15,),
                Row(
                  children: [
                    Text(
                        'Speciality:',
                      style: TextStyle(
                          color: Colors.cyan[900],
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5,),
                    Text(
                      doctorDetails['Speciality: '],
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
                    Text(
                      'Address: ',
                      style: TextStyle(
                          color: Colors.cyan[900],
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5,),
                    Text(
                      doctorDetails['Address: '],
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
                    Text(
                        'Contacts:',
                      style: TextStyle(
                          color: Colors.cyan[900],
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5,),
                    Text(
                      doctorDetails['Contacts: '],
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          // fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
