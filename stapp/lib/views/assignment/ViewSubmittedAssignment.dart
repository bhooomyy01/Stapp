import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stapp/Widgets/widgetapp.dart';

import 'ViewAssignmentPDF.dart';

class ViewSubmittedAssignment extends StatefulWidget {
  final String assignmentName;
  ViewSubmittedAssignment({this.assignmentName});
  @override
  _ViewSubmittedAssignmentState createState() =>
      _ViewSubmittedAssignmentState();
}

class _ViewSubmittedAssignmentState extends State<ViewSubmittedAssignment> {
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
                        .doc(widget.assignmentName)
                        .collection("submittedAssignment")
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
                            return SubmittedAssignmentTile(
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

class SubmittedAssignmentTile extends StatelessWidget {
  final String name, downloadURL;
  SubmittedAssignmentTile({this.name, this.downloadURL});
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
                  name,
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
                      builder: (context) => ViewAssignment(
                            urlkey: downloadURL,
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
}
