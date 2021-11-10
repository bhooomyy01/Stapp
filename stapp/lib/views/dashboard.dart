import 'package:flutter/material.dart';
import 'package:stapp/Widgets/dashbordCard.dart';
import 'package:stapp/helper/authenticate.dart';
import 'package:stapp/helper/constants.dart';
import 'package:stapp/helper/helpfunctions.dart';

import 'package:stapp/services/auth.dart';

import 'package:stapp/views/assignment/studentview.dart';
import 'package:stapp/views/assignment/submithome.dart';

import 'package:stapp/views/feed.dart';
import 'package:stapp/views/search.dart';
import 'package:stapp/views/viewTimeTable.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
        title: Text("STAPP : Dashboard Student"),
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StudentAssignmentView()));
                    },
                    child: dashbordCard(
                        context,
                        Icon(
                          Icons.assignment_rounded,
                          size: 50,
                        ),
                        "View Assignment"),
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
                              builder: (context) => SubmitAssignmentHome()));
                    },
                    child: dashbordCard(
                        context,
                        Icon(
                          Icons.assignment_return_rounded,
                          size: 50,
                        ),
                        "Submitt Assignment"),
                  ),
                  /*GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddSoon()));
                    },
                    child: dashbordCard(
                        context,
                        Icon(
                          Icons.timelapse,
                          size: 50,
                        ),
                        "New Feature"),
                  ),*/
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
