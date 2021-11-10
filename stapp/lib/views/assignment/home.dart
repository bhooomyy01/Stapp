import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:stapp/Widgets/widgetapp.dart';
import 'package:stapp/services/database.dart';

class NewAssignmentHome extends StatefulWidget {
  @override
  _NewAssignmentHomeState createState() => _NewAssignmentHomeState();
}

class _NewAssignmentHomeState extends State<NewAssignmentHome> {
  TextEditingController filenamecontroller = new TextEditingController();
  DatabaseMetheds databaseMetheds = new DatabaseMetheds();
  UploadTask task;
  File file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: filenamecontroller,
                decoration: InputDecoration(
                  hintText: 'Assignment Name',
                  hintStyle: simpleTextStyle(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueAccent,
                  onPrimary: Colors.white,
                ),
                child: Text("Select File"),
                onPressed: () {
                  print("pressed");
                  selectFile();
                },
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent, onPrimary: Colors.white),
                child: Text("upload Assignment"),
                onPressed: () {
                  print("pressed");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future selectFile() async {
    final String filename = filenamecontroller.text;
    File file;
    FilePickerResult result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
    );
    if (result != null) {
      file = File(result.files.single.path);
    } else {
      // User canceled the picker
    }
    final destination = 'Assignment/$filename';
    task = databaseMetheds.uploadAssignmentFile(destination, file);
    if (task == null) return;
    final snapshot = await task.whenComplete(() {});
    final downloadURL = await snapshot.ref.getDownloadURL();
    Map<String, String> messageMap = {
      "assignmentName": filename,
      "displayUrl": downloadURL
    };
    databaseMetheds.saveAssignment(filename, messageMap);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Upload Complete!!"),
            content: Text(""),
          );
        });
  }
}
