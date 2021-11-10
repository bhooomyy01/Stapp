import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stapp/Widgets/widgetapp.dart';

class UpdateTimeTable extends StatefulWidget {
  @override
  _UpdateTimeTableState createState() => _UpdateTimeTableState();
}

class _UpdateTimeTableState extends State<UpdateTimeTable> {
  String imageurl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              (imageurl != null)
                  ? Image.network(imageurl)
                  : Placeholder(
                      fallbackHeight: 400,
                      fallbackWidth: double.infinity,
                    ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent, onPrimary: Colors.white),
                child: Text("Upload New TimeTable"),
                onPressed: () {
                  print("pressed");
                  uploadImage();
                },
              ),
            ],
          )),
    );
  }

  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;
    print("uploadhere");
    //1. check permissions
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted) {
      //2. Select Image
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image.path);
      if (image != null) {
        //3. upload to firebase
        var snapshot = await _storage
            .ref()
            .child('TimeTableFloder/TimeTableImage')
            .putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Updated!!"),
                content: Text("TimeTable Updated!!"),
              );
            });
        setState(() {
          imageurl = downloadUrl;
        });
      } else {
        print('No path received');
      }
    } else {
      print('Grant Permission and try again!!!');
    }
  }
}
