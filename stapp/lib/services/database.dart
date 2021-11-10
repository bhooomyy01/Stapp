import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:stapp/Widgets/widgetapp.dart';
import 'package:stapp/views/assignment/submithome.dart';

class DatabaseMetheds {
  getUserByUsername(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .get();
  }

  getUserByUserEmail(String userEmail) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: userEmail)
        .get();
  }

  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection("users").add(userMap).catchError((e) {
      print(e.toString());
    });
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .set(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addConversationMessage(String chatRoomId, messageMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      print(e.toString() + "asaspas");
    });
  }

  getConversationMessage(String chatRoomId) async {
    return await FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("time", descending: false)
        .snapshots();
  }

  getChatRooms(String username) async {
    return await FirebaseFirestore.instance
        .collection("ChatRoom")
        .where("users", arrayContains: username)
        .snapshots();
  }

  getAssignment() async {
    return await FirebaseFirestore.instance.collection("Assignment");
  }

  UploadTask uploadAssignmentFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on Exception catch (e) {
      print(e);
    }
  }

  saveAssignment(String name, mapData) {
    FirebaseFirestore.instance
        .collection("Assignment")
        .doc(name)
        .set(mapData)
        .catchError((e) {
      print(e.toString());
    });
  }

  saveStudentAssignment(String name, mapData) {
    FirebaseFirestore.instance
        .collection("Assignment")
        .doc(name)
        .collection("submittedAssignment")
        .add(mapData)
        .catchError((e) {
      print(e.toString());
    });
  }
}
