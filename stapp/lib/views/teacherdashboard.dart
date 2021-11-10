import 'package:flutter/material.dart';
import 'package:stapp/Widgets/dashbordCard.dart';
import 'package:stapp/helper/authenticate.dart';
import 'package:stapp/helper/constants.dart';
import 'package:stapp/helper/helpfunctions.dart';
import 'package:stapp/model/AppUser.dart';
import 'package:stapp/services/auth.dart';
import 'package:stapp/views/addsoon.dart';
import 'package:stapp/views/assignment/ViewAssignmentPDF.dart';

import 'package:stapp/views/assignment/home.dart';
import 'package:stapp/views/chastRoomsScreem.dart';
import 'package:stapp/views/feed.dart';
import 'package:stapp/views/search.dart';
import 'package:stapp/views/updateTimeTable.dart';
import 'package:stapp/views/viewTimeTable.dart';

import 'assignment/ViewSubmittedAssignmentList.dart';

class TeacherDashboard extends StatefulWidget {
  @override
  _TeacherDashboardState createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  AuthMethods authMethods = new AuthMethods();

  void init() {
    super.initState();
    getUserInfo();
  }

  getUserInfo() async {
    setState(() {});

    Constants.myName = await HelperFunctions.getUserNameSharedPereference();
    print("Get user Info " + Constants.myName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("STAPP : Dashboard Teacher"),
        actions: [
          GestureDetector(
              onTap: () {
                authMethods.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Authenticate()));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app),
              ))
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                children: [
                  Container(
                    child: Center(
                      child: Card(
                        child: GestureDetector(
                          onTap: () {
                            getUserInfo();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FeedHome()));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2 - 10,
                            height: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.dynamic_feed,
                                  size: 50,
                                ),
                                Text("Feed"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchScreen()));
                    },
                    child: dashbordCard(
                        context,
                        Icon(
                          Icons.chat,
                          size: 50,
                        ),
                        "ChatRoom"),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdateTimeTable()));
                    },
                    child: dashbordCard(
                        context,
                        Icon(
                          Icons.timelapse,
                          size: 50,
                        ),
                        "Update TimeTable"),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewTimeTable()));
                    },
                    child: dashbordCard(
                        context,
                        Icon(
                          Icons.timelapse,
                          size: 50,
                        ),
                        "View TimeTable"),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewAssignmentHome()));
                    },
                    child: dashbordCard(
                        context,
                        Icon(
                          Icons.assignment_rounded,
                          size: 50,
                        ),
                        "Add Assignment"),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewAssignmentDemo()));
                    },
                    child: dashbordCard(
                        context,
                        Icon(
                          Icons.assignment_turned_in,
                          size: 50,
                        ),
                        "Submitted Assignment"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
