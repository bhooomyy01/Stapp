import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stapp/helper/authenticate.dart';
import 'package:stapp/helper/helpfunctions.dart';
import 'package:stapp/views/dashboard.dart';
import 'package:stapp/views/teacherdashboard.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// Student - w2e3r4
// Teacher - 1q2w3e
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoogedIn;
  bool userRole;
  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPereference().then((value) {
      setState(() {
        userIsLoogedIn = value;
      });
    });

    await HelperFunctions.getUserRolePereference().then((value) {
      setState(() {
        if (value == 'student')
          userRole = false;
        else
          userRole = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userIsLoogedIn == null) {
      userIsLoogedIn = false;
      getLoggedInState();
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'STAPP',
      //userIsLoogedIn ? Dashboard() :
      home: userIsLoogedIn
          ? userRole
              ? TeacherDashboard()
              : Dashboard()
          : Authenticate(),
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Color(0Xff1F1F1f)),
    );
  }
}
