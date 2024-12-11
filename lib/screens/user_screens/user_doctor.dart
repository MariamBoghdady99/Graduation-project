import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDoctors extends StatefulWidget {

  static String id = 'user_doctors';

  const UserDoctors({Key? key, required this.userID, required this.userData}) : super(key: key);

  final String userID;
  final Map<String, dynamic> userData;

  @override
  State<UserDoctors> createState() => _UserDoctorsState();
}

class _UserDoctorsState extends State<UserDoctors> {

  String name = '' ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'the ${widget.userData['Name']}\'s doctors'
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
        stream: FirebaseFirestore.instance.collection('Guests').doc(widget.userID).collection('Doctors').snapshots(),
        builder: (context, snapshots) {
          return (snapshots.connectionState == ConnectionState.waiting)
              ? Center(
                  child: CircularProgressIndicator(),
          ) : ListView.builder(
              itemCount: snapshots.data!.docs.length,
              itemBuilder: (context, index){
                var data = snapshots.data!.docs[index].data() as Map<String,dynamic>;

                if(name.isEmpty){
                  return ListTile(
                    title: Text(
                      data['Name: '],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      data['Speciality: '],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                }

                if((data['Name: '].toString().toLowerCase().startsWith(name.toLowerCase()))||
                    (data['Speciality: '].toString().toLowerCase().startsWith(name.toLowerCase()))){
                  return ListTile(
                    title: Text(
                      data['Name: '],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      data['Speciality: '],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                }
                return Container();
              }
              );
        },
      ),
    );
  }
}
