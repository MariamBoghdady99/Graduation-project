import 'dart:html';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class NewReport extends StatefulWidget {
  const NewReport({Key? key, required this.docID, this.userData}) : super(key: key);

  final String docID;
  final Map<String, dynamic>? userData;

  @override
  State<NewReport> createState() => _NewReportState();
}

final fileNameController = TextEditingController();
late final pdfFile;

class _NewReportState extends State<NewReport> {

  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  late String fileName;
  String message = 'no file selected';

  String? _fileUrl;
  FilePickerResult? result;

  FileUploadInputElement input = FileUploadInputElement();

  // Future<String?> uploadPdf( File pdffile) async {
  //   try{
  //     final reference = FirebaseStorage.instance.ref().child("reports/$fileName.pdf");
  //
  //     // UploadTask  uploadTask = reference.putFile(pdffile, SettableMetadata(contentType: 'pdf'));
  //
  //     // TaskSnapshot snapshot = await uploadTask;
  //
  //     // String url = await snapshot.ref.getDownloadURL();
  //
  //     // print("url:$url");
  //
  //     return url;
  //   } catch(e) {
  //     return null;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add new report',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(pickedFile != null)
              Expanded(
                  child: Container(
                    child: Text(pickedFile!.name),
                  )
              ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 400,
                  height: 50,
                  child: TextField(
                    controller: fileNameController,
                    onChanged: (value) {
                      fileName = value;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'File Name',
                    ),
                  ),
                ),
                SizedBox(width: 15,),
                TextButton(
                    onPressed: () async{
                      // final result = await FilePicker.platform.pickFiles();
                      // if(result == null) return;
                      //
                      // setState(() {
                      //   pickedFile = result.files.first;
                      // });
                      // print('Done');

                      FilePickerResult? result = await FilePicker.platform.pickFiles(
                        type: FileType.any,
                        allowMultiple: false,
                      );

                      try{
                        if(result != null && result.files.isNotEmpty) {
                          setState(() {
                            pdfFile = result.files.first.bytes;
                          });
                          print('done');
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text(
                      'Select file'
                    ),
                )
              ],
            ),
            SizedBox(height: 20,),
            TextButton(
                onPressed: () async {
                  Reference ref = FirebaseStorage.instance.ref().child('Reports').child('${fileName}.pdf');

                  try {
                    await ref.putData(pdfFile);
                    print('done');

                    await ref.getDownloadURL().then((value) {
                      setState(() {
                        _fileUrl = value;
                      });
                      print(value);
                    });
                  } catch (e) {
                    print(e);
                  }




                  // Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('reports/$fileName');
                  // uploadTask = firebaseStorageRef.putFile(_pdfFile! as io.File);
                  //
                  // TaskSnapshot? taskSnapshot = await uploadTask?.whenComplete(() {
                  //   print ('done');
                  // });
                  //
                  // taskSnapshot?.ref.getDownloadURL().then((value) {
                  //   setState(() {
                  //     _fileUrl = value;
                  //   });
                  // });


                  // final path = 'reports/${pickedFile!.name}';
                  // final report = File(pickedFile!.path!);


                  // Reference ref = FirebaseStorage.instance.ref().child('pdfs').child('${fileName}.pdf');
                  // UploadTask uploadTask = ref.putFile(ref);
                  // final snapshot = await task.whenComplete(() {
                  //   print('Done');
                  // }).catchError((error) => print(error));
                  // String url = await snapshot.ref.getDownloadURL();
                  //
                  // setState(() {
                  //   _fileUrl = url;
                  // });

                  try{
                    await FirebaseFirestore.instance.collection('Guests').doc(widget.docID)
                        .collection('Reports').doc('${fileName}').set({
                      'Report name' : fileName.toString(),
                      'Url' : _fileUrl
                    });
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text(
                  'Upload the file'
                ))
          ],
        ),
      ),
    );
  }
}
