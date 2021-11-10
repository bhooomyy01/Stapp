import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stapp/Widgets/widgetapp.dart';
import 'package:stapp/views/assignment/ViewAssignmentPDF.dart';
import 'package:stapp/views/assignment/ViewSubmittedAssignment.dart';
import 'package:stapp/views/assignment/submitsecond.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewAssignmentDemo extends StatefulWidget {
  @override
  _ViewAssignmentDemoState createState() => _ViewAssignmentDemoState();
}

class _ViewAssignmentDemoState extends State<ViewAssignmentDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("Assignment")
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> querySnapshot) {
                      if (querySnapshot.hasError) return Text("Error");
                      if (querySnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else {
                        final list = querySnapshot.data.docs;
                        return ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            return AssignmentListTiles(
                              name: list[index]["assignmentName"],
                              downloadURL: list[index]["displayUrl"],
                            );
                          },
                        );
                      }
                    }))
          ],
        ),
      ),
    );
  }
}

class AssignmentListTiles extends StatefulWidget {
  final String name, downloadURL;
  AssignmentListTiles({this.name, this.downloadURL});

  @override
  _AssignmentListTilesState createState() => _AssignmentListTilesState();
}

class _AssignmentListTilesState extends State<AssignmentListTiles> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: simpleTextStyle(),
                ),
              ],
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              //launchURL(widget.downloadURL);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ViewSubmittedAssignment(
                            assignmentName: widget.name,
                          )));
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text('View'),
            ),
          )
        ],
      ),
    );
  }

  void launchURL(url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
    await launch(url);
    print(url);
  }
}
