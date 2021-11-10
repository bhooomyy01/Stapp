import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stapp/Widgets/widgetapp.dart';
import 'package:stapp/helper/constants.dart';
import 'package:stapp/helper/helpfunctions.dart';
import 'package:stapp/services/database.dart';
import 'package:stapp/views/conversationScreen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

String _myName;

class _SearchScreenState extends State<SearchScreen> {
  DatabaseMetheds databaseMetheds = new DatabaseMetheds();
  TextEditingController searchTextEditingController =
      new TextEditingController();

  QuerySnapshot searchSnapspot;
  initiateSearch() {
    databaseMetheds
        .getUserByUsername(searchTextEditingController.text)
        .then((val) {
      setState(() {
        searchSnapspot = val;
      });
    });
  }

  createChatroomAndStartConversation({String userName}) {
    if (userName != _myName) {
      String chatRoomId = getChatRoomId(userName, _myName);
      Constants.myName = _myName;
      List<String> users = [userName, _myName];
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatroomId": chatRoomId
      };
      DatabaseMetheds().createChatRoom(chatRoomId, chatRoomMap);
      Constants.currentChatroomID = chatRoomId;
      print(Constants.currentChatroomID);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConversationScreen(chatRoomId)));
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Message to yourself"),
              content: Text("You cannot send message to yourself"),
            );
          });
      print("You cannot send message to yourself");
    }
  }

  Widget SearchTile({String userName, String userEmail}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: simpleTextStyle(),
              ),
              Text(
                userEmail,
                style: simpleTextStyle(),
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              createChatroomAndStartConversation(userName: userName);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text('Message'),
            ),
          )
        ],
      ),
    );
  }

  Widget searchList() {
    return searchSnapspot != null
        ? ListView.builder(
            itemCount: searchSnapspot.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SearchTile(
                  userName: searchSnapspot.docs[index].get("name"),
                  userEmail: searchSnapspot.docs[index].get("email"));
            })
        : Container();
  }

  getUserInfo() async {
    _myName = await HelperFunctions.getUserNameSharedPereference();
    setState(() {});
    print("${_myName} is Profile Name");
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Column(
          children: [
            Container(
              color: Color(0x54FFFFFF),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: searchTextEditingController,
                    decoration: InputDecoration(
                        hintText: "Search Username",
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none),
                  )),
                  GestureDetector(
                    onTap: () {
                      initiateSearch();
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            const Color(0x36FFFFFF),
                            const Color(0x0FFFFFFF),
                          ]),
                          borderRadius: BorderRadius.circular(40)),
                      child: Icon(
                        Icons.search_outlined,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  )
                ],
              ),
            ),
            searchList(),
          ],
        ),
      ),
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
