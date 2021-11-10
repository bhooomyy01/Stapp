import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stapp/Widgets/widgetapp.dart';
import 'package:stapp/helper/helpfunctions.dart';
import 'package:stapp/model/AppUser.dart';
import 'package:stapp/services/auth.dart';
import 'package:stapp/services/database.dart';

import 'package:stapp/views/teacherdashboard.dart';

import 'dashboard.dart';

class SignIn extends StatefulWidget {
  final Function toogle;
  SignIn(this.toogle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isLoadong = false;
  AuthMethods authMethods = new AuthMethods();
  DatabaseMetheds databaseMetheds = new DatabaseMetheds();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();
  final formkey = GlobalKey<FormState>();
  String setRole;
  bool isLoading = false;
  QuerySnapshot snapshotUserInfo;
  signMeIn() {
    if (formkey.currentState.validate()) {
      HelperFunctions.saveUserEmailPereference(emailTextEditingController.text);
      // HelperFunctions.saveUserNameSharedPereference(usernameTextEditingController.text);

      databaseMetheds
          .getUserByUserEmail(emailTextEditingController.text)
          .then((val) {
        snapshotUserInfo = val;
        HelperFunctions.saveUserNameSharedPereference(
            snapshotUserInfo.docs[0]["name"]);
        HelperFunctions.saveUserRolePereference(
            snapshotUserInfo.docs[0]["role"]);
        print(snapshotUserInfo.docs[0]["name"]);
        print(snapshotUserInfo.docs[0]["role"]);
        String setRole = snapshotUserInfo.docs[0]["role"];
      });
      setState(() {
        isLoading = true;
      });
      AppUser appUser = new AppUser();
      appUser.userName = snapshotUserInfo.docs[0]["name"];
      appUser.userEmail = snapshotUserInfo.docs[0]["email"];
      authMethods
          .signInWithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text, context)
          .then((value) {
        if (value != null) {
          HelperFunctions.saveUserLoggedInSharedPereference(true);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      snapshotUserInfo.docs[0]["role"] == "student"
                          ? Dashboard()
                          : TeacherDashboard()));
        }
      }).catchError((e) {
        print(e.toString() + "Hi");
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Alert Dialog"),
                content: Text("Dialog Content"),
              );
            });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 50,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    validator: (val) {
                      return RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(val)
                          ? null
                          : "Enter correct email";
                    },
                    style: simpleTextStyle(),
                    controller: emailTextEditingController,
                    decoration: textFieldInputDecoration("Email"),
                  ),
                  TextFormField(
                    validator: (val) {
                      return val.length < 6
                          ? "Enter Password 6+ characters"
                          : null;
                    },
                    style: simpleTextStyle(),
                    obscureText: true,
                    controller: passwordTextEditingController,
                    decoration: textFieldInputDecoration("Password"),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        "Forget Password",
                        style: simpleTextStyle(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: signMeIn,
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            const Color(0xff007EF4),
                            const Color(0xff2A758C),
                          ]),
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        "Sign In",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Don't Have Account?",
                        style: whiteTextStyle(),
                      ),
                      GestureDetector(
                        onTap: () {
                          widget.toogle();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          child: Text(
                            " Register Now",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 200,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stapp/Widgets/widgetapp.dart';
import 'package:stapp/helper/helpfunctions.dart';
import 'package:stapp/model/AppUser.dart';
import 'package:stapp/services/auth.dart';
import 'package:stapp/services/database.dart';

import 'package:stapp/views/teacherdashboard.dart';

import 'dashboard.dart';

class SignIn extends StatefulWidget {
  final Function toogle;
  SignIn(this.toogle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isLoadong = false;
  AuthMethods authMethods = new AuthMethods();
  DatabaseMetheds databaseMetheds = new DatabaseMetheds();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();
  final formkey = GlobalKey<FormState>();
  String setRole;
  bool isLoading = false;
  QuerySnapshot snapshotUserInfo;
  signMeIn() {
    if (formkey.currentState.validate()) {
      HelperFunctions.saveUserEmailPereference(emailTextEditingController.text);
      // HelperFunctions.saveUserNameSharedPereference(usernameTextEditingController.text);

      databaseMetheds
          .getUserByUserEmail(emailTextEditingController.text)
          .then((val) {
        snapshotUserInfo = val;
        HelperFunctions.saveUserNameSharedPereference(
            snapshotUserInfo.docs[0]["name"]);
        HelperFunctions.saveUserRolePereference(
            snapshotUserInfo.docs[0]["role"]);
        print(snapshotUserInfo.docs[0]["name"]);
        print(snapshotUserInfo.docs[0]["role"]);
        String setRole = snapshotUserInfo.docs[0]["role"];
      });
      setState(() {
        isLoading = true;
      });
      AppUser appUser = new AppUser();
      appUser.userName = snapshotUserInfo.docs[0]["name"];
      appUser.userEmail = snapshotUserInfo.docs[0]["email"];
      authMethods
          .signInWithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((value) {
        if (value != null) {
          HelperFunctions.saveUserLoggedInSharedPereference(true);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      snapshotUserInfo.docs[0]["role"] == "student"
                          ? Dashboard()
                          : TeacherDashboard()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 50,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    validator: (val) {
                      return RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(val)
                          ? null
                          : "Enter correct email";
                    },
                    style: simpleTextStyle(),
                    controller: emailTextEditingController,
                    decoration: textFieldInputDecoration("Email"),
                  ),
                  TextFormField(
                    validator: (val) {
                      return val.length < 6
                          ? "Enter Password 6+ characters"
                          : null;
                    },
                    style: simpleTextStyle(),
                    obscureText: true,
                    controller: passwordTextEditingController,
                    decoration: textFieldInputDecoration("Password"),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        "Forget Password",
                        style: simpleTextStyle(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: signMeIn,
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            const Color(0xff007EF4),
                            const Color(0xff2A758C),
                          ]),
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        "Sign In",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Don't Have Account?",
                        style: whiteTextStyle(),
                      ),
                      GestureDetector(
                        onTap: () {
                          widget.toogle();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          child: Text(
                            " Register Now",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 200,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}*/
