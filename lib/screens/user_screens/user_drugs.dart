import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDrugs extends StatefulWidget {
  static String id = 'user_drugs';

  const UserDrugs({Key? key, required this.userID, required this.userData}) : super(key: key);

  final String userID;
  final Map<String, dynamic> userData;

  @override
  State<UserDrugs> createState() => _UserDrugsState();
}

class _UserDrugsState extends State<UserDrugs> {

  String name = '' ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'the ${widget.userData['Name']}\'s drugs'
        ),
        actions: [
          SizedBox(
            width: 300,
            height: 50,
            child: Card(
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search...',
                ),
                onChanged: (value){
                  setState(() {
                    name = value;
                  });
                },
              ),
            ),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot> (
        stream: FirebaseFirestore.instance.collection('Guests').doc(widget.userID).collection('Drugs').snapshots(),
        builder: (context, snapshots){
          return (snapshots.connectionState == ConnectionState.waiting)
              ? Center(
            child: CircularProgressIndicator(),
          ) : ListView.builder(
            itemCount: snapshots.data!.docs.length,
            itemBuilder: (context, index) {
              var data = snapshots.data!.docs[index].data() as Map<String,dynamic>;
              if (name.isEmpty) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(data['DrugImage']),
                    minRadius: 80,
                    maxRadius: 100,
                  ),
                  title: Row(
                    children: [
                      Text(
                        'Drug name:',
                        style: TextStyle(
                            color: Colors.brown.shade900,
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(width:5,),
                      Text(
                        data['Drug Name'],
                        style: TextStyle(
                          color: Colors.brown.shade900,
                          fontSize: 23,
                          // fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(width:5,),
                      Text(
                        'Serial number:',
                        style: TextStyle(
                            color: Colors.brown.shade900,
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(width:5,),
                      Text(
                        data['Drug Serial Number'],
                        style: TextStyle(
                          color: Colors.brown.shade900,
                          fontSize: 23,
                          // fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      Text(
                        'Drug dose:',
                        style: TextStyle(
                            color: Colors.brown.shade900,
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(width:5,),
                      Text(
                        data['Drug Dose'],
                        style: TextStyle(
                          color: Colors.brown.shade900,
                          fontSize: 23,
                          // fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(width:5,),
                      Text(
                        'Drug measurement:',
                        style: TextStyle(
                            color: Colors.brown.shade900,
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(width:5,),
                      Text(
                        '${data['Drug measurement']} gm',
                        style: TextStyle(
                          color: Colors.brown.shade900,
                          fontSize: 23,
                          // fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                );
              }
              if((data['Drug Name'].toString().toLowerCase().startsWith(name.toLowerCase())) ||
                  (data['Drug Serial Number'].toString().toLowerCase().startsWith(name.toLowerCase()))){
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(data['DrugImage']),
                    minRadius: 80,
                    maxRadius: 100,
                  ),
                  title: Row(
                    children: [
                      Text(
                        'Drug name:',
                        style: TextStyle(
                            color: Colors.brown.shade900,
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(width:5,),
                      Text(
                        data['Drug Name'],
                        style: TextStyle(
                          color: Colors.brown.shade900,
                          fontSize: 23,
                          // fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(width:5,),
                      Text(
                        'Serial number:',
                        style: TextStyle(
                            color: Colors.brown.shade900,
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(width:5,),
                      Text(
                        data['Drug Serial Number'],
                        style: TextStyle(
                          color: Colors.brown.shade900,
                          fontSize: 23,
                          // fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      Text(
                        'Drug dose:',
                        style: TextStyle(
                            color: Colors.brown.shade900,
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(width:5,),
                      Text(
                        data['Drug Dose'],
                        style: TextStyle(
                          color: Colors.brown.shade900,
                          fontSize: 23,
                          // fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(width:5,),
                      Text(
                        'Drug measurement:',
                        style: TextStyle(
                            color: Colors.brown.shade900,
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(width:5,),
                      Text(
                        '${data['Drug measurement']} gm',
                        style: TextStyle(
                          color: Colors.brown.shade900,
                          fontSize: 23,
                          // fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
