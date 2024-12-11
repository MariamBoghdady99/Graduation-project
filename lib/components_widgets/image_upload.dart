import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';


class ImageUpload extends StatelessWidget {

  static String imageUrl = '';

  const ImageUpload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child:
            ElevatedButton(
              onPressed: () async {
                ImagePicker imagePicker = ImagePicker();
                XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
                print('${file?.path}');
              },
              child: Text(
                'upload image'
              ),
            ),
        ),
        IconButton(
          icon: Icon(Icons.camera),
          onPressed: () async {
            //step1: pick the picture
            ImagePicker imagePicker = ImagePicker();
            XFile? file = await imagePicker.pickImage(source: ImageSource.camera);
            print('${file?.path}');

            if(file == null) return;
            //step2: upload to firestore storage
            String unigueFileName = DateTime.now().millisecondsSinceEpoch.toString();
            //get a reference to storage root
            Reference referenceRoot = FirebaseStorage.instance.ref();
            Reference referenceDirImages = referenceRoot.child('images');

            //create a reference for the image to be stored
            Reference referenceImageToBeUpload = referenceDirImages.child(unigueFileName);

            try {
              //store the file
              await referenceImageToBeUpload.putFile(File(file!.path));
              //success: step 3: get the doanload URL
              imageUrl = await referenceImageToBeUpload.getDownloadURL();
            }catch(error) {
              print(error);
            }

          },
        ),
      ],
    );
  }
}
