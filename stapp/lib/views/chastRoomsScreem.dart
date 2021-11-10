import 'package:flutter/material.dart';
import 'package:stapp/helper/authenticate.dart';
import 'package:stapp/helper/constants.dart';

import 'package:stapp/services/auth.dart';
import 'package:stapp/services/database.dart';
import 'package:stapp/views/search.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = new AuthMethods();
  DatabaseMetheds databaseMetheds = new DatabaseMetheds();
  Stream chatRoomsStream;
  @override
  void initState() {
    getChatRoomInfo();
    super.initState();
  }

  getChatRoomInfo() async {
    setState(() {
      databaseMetheds.getChatRooms(Constants.myName).then((val) {
        setState(() {
          chatRoomsStream = val;
          print(val);
        });
      });
    });
  }

  Widget chatRoomList() {
    return StreamBuilder(
        stream: chatRoomsStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return ChatRoomTiles(
                      userName: snapshot.data.docs[index]['chatRoomId'],
                    );
                  },
                )
              : Container(
                  child: Text(
                    "Use Search For Now",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("STAPP"),
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
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.search,
        ),
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => SearchScreen()));
        },
      ),
      body: Container(
        child: chatRoomList(),
      ),
    );
  }
}

class ChatRoomTiles extends StatelessWidget {
  final String userName;
  ChatRoomTiles({this.userName});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(40)),
            child: Text(
              "${userName.substring(0, 1).toUpperCase()}",
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Text(userName),
        ],
      ),
    );
  }
}
