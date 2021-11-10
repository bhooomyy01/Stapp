import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stapp/Widgets/widgetapp.dart';
import 'package:stapp/views/assignment/ViewAssignmentPDF.dart';

class StudentAssignmentView extends StatefulWidget {
  @override
  _StudentAssignmentViewState createState() => _StudentAssignmentViewState();
}

class _StudentAssignmentViewState extends State<StudentAssignmentView> {
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
                            return StudentAssignmentViewTitles(
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

class StudentAssignmentViewTitles extends StatelessWidget {
  final String name, downloadURL;
  StudentAssignmentViewTitles({this.name, this.downloadURL});

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
