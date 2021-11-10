import 'package:flutter/material.dart';
import 'package:stapp/Widgets/widgetapp.dart';
import 'package:stapp/helper/constants.dart';
import 'package:stapp/model/AppUser.dart';
import 'package:stapp/services/database.dart';

class FeedHome extends StatefulWidget {
  FeedHome({AppUser appUser});

  @override
  _FeedHomeState createState() => _FeedHomeState();
}

class _FeedHomeState extends State<FeedHome> {
  final String chatRoomId = "mainfeed";

  DatabaseMetheds databaseMetheds = new DatabaseMetheds();
  TextEditingController messageController = new TextEditingController();
  Stream chatMsgStream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Stack(
          children: [
            ChatMessageList(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Color(0x54FFFFFF),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                          hintText: "Message",
                          hintStyle: TextStyle(color: Colors.white54),
                          border: InputBorder.none),
                    )),
                    GestureDetector(
                      onTap: () {
                        if (Constants.myName != null) {
                          sendMessage();
                        } else {
                          print(Constants.myName + "Data Fuck");
                        }
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
                          Icons.send,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void initState() {
    DatabaseMetheds().getConversationMessage(chatRoomId).then((val) {
      setState(() {
        chatMsgStream = val;
      });
    });
    super.initState();
  }

  Widget ChatMessageList() {
    return StreamBuilder(
        stream: chatMsgStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return MessageTile(
                      msg: snapshot.data.docs[index]['message'],
                      isSendByMe: snapshot.data.docs[index]['sendBy'] ==
                          Constants.myName,
                      sender: snapshot.data.docs[index]['sendBy'],
                    );
                  })
              : Container();
        });
  }

  sendMessage() {
    setState(() {});

    if (messageController.text.isNotEmpty) {
      print(Constants.myName + "At feed");
      Map<String, dynamic> messageMap = {
        "message": messageController.text,
        "sendBy": Constants.myName,
        "time": DateTime.now().millisecondsSinceEpoch
      };
      print(messageMap);
      DatabaseMetheds().addConversationMessage(chatRoomId, messageMap);
      messageController.text = "";
    }
  }
}

class MessageTile extends StatelessWidget {
  final String msg;
  final bool isSendByMe;
  final String sender;

  MessageTile({this.msg, this.isSendByMe, this.sender});
  @override
  Widget build(BuildContext context) {
    return isSendByMe
        ? Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            width: MediaQuery.of(context).size.width,
            alignment:
                isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isSendByMe
                      ? [const Color(0xff007EF4), const Color(0xff2A75BC)]
                      : [const Color(0x1AFFFFFF), const Color(0x1AFFFFFF)],
                ),
                borderRadius: isSendByMe
                    ? BorderRadius.only(
                        topLeft: Radius.circular(23),
                        topRight: Radius.circular(23),
                        bottomLeft: Radius.circular(23))
                    : BorderRadius.only(
                        topLeft: Radius.circular(23),
                        topRight: Radius.circular(23),
                        bottomRight: Radius.circular(23)),
              ),
              child: Text(
                msg,
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
          )
        : Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.topLeft,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      const Color(0x1AFFFFFF),
                      const Color(0x1AFFFFFF),
                    ]),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(23),
                        topRight: Radius.circular(23),
                        bottomRight: Radius.circular(23))),
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        sender,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      msg,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ],
                )),
          );
  }
}
