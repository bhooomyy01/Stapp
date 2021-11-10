import 'package:flutter/material.dart';
import 'package:stapp/Widgets/widgetapp.dart';

class AddSoon extends StatefulWidget {
  @override
  _AddSoonState createState() => _AddSoonState();
}

class _AddSoonState extends State<AddSoon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Center(
        child: Text(
          "Will Be Added Soon",
          style: TextStyle(fontSize: 28, color: Colors.white),
        ),
      ),
    );
  }
}
