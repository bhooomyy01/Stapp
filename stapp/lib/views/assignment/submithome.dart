import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stapp/Widgets/widgetapp.dart';
import 'package:stapp/views/assignment/submitsecond.dart';

class SubmitAssignmentHome extends StatefulWidget {
  @override
  _SubmitAssignmentHomeState createState() => _SubmitAssignmentHomeState();
}

class _SubmitAssignmentHomeState extends State<SubmitAssignmentHome> {
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
                            return StudentAssignmentListTiles(
                              name: list[index]["assignmentName"],
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

class StudentAssignmentListTiles extends StatelessWidget {
  final String name;
  StudentAssignmentListTiles({this.name});
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SubmitStudentAssignmentToDatabase(assignmentName: name),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text('Summit Now'),
            ),
          )
        ],
      ),
    );
  }
}
