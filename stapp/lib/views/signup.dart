import 'package:flutter/material.dart';
import 'package:stapp/Widgets/widgetapp.dart';
import 'package:stapp/helper/authenticate.dart';
import 'package:stapp/helper/helpfunctions.dart';
import 'package:stapp/services/auth.dart';
import 'package:stapp/services/database.dart';
import 'package:stapp/views/sigin.dart';

class SignUp extends StatefulWidget {
  final Function toogle;
  SignUp(this.toogle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoadong = false;
  AuthMethods authMethods = new AuthMethods();
  final formkey = GlobalKey<FormState>();
  DatabaseMetheds databaseMetheds = new DatabaseMetheds();
  String setRole;
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();
  TextEditingController usernameTextEditingController =
      new TextEditingController();

  signMeUp() {
    if (formkey.currentState.validate()) {
      Map<String, String> userInfoMap = {
        "name": usernameTextEditingController.text,
        "email": emailTextEditingController.text,
        "role": setRole
      };
      HelperFunctions.saveUserEmailPereference(emailTextEditingController.text);
      HelperFunctions.saveUserNameSharedPereference(
          usernameTextEditingController.text);
      HelperFunctions.saveUserRolePereference(setRole);

      setState(() {
        isLoadong = true;
      });
      authMethods
          .signUpWithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((val) {
        //print("{$val.uid}");

        databaseMetheds.uploadUserInfo(userInfoMap);
        HelperFunctions.saveUserLoggedInSharedPereference(true);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => SignIn(widget.toogle)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoadong
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height - 50,
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Form(
                        key: formkey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              validator: (val) {
                                return val.isEmpty || val.length < 4
                                    ? "Please Provider Username"
                                    : null;
                              },
                              style: simpleTextStyle(),
                              controller: usernameTextEditingController,
                              decoration: textFieldInputDecoration("Username"),
                            ),
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
                              obscureText: true,
                              validator: (val) {
                                return val.length < 6
                                    ? "Enter Password 6+ characters"
                                    : null;
                              },
                              style: simpleTextStyle(),
                              controller: passwordTextEditingController,
                              decoration: textFieldInputDecoration("Password"),
                            ),
                            TextFormField(
                              obscureText: false,
                              validator: (val) {
                                print(val);
                                if (val.length == 6) {
                                  if (val == "1q2w3e") {
                                    setRole = "teacher";
                                    return null;
                                  } else if (val == "w2e3r4") {
                                    setRole = "student";
                                    return null;
                                  } else {
                                    return "Enter valid code";
                                  }
                                } else {
                                  return "Enter text 6+ characters";
                                }
                              },
                              style: simpleTextStyle(),
                              decoration: textFieldInputDecoration("Code"),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            //child: Text(
                            //  "Forget Password",
                            //  style: simpleTextStyle(),
                            //),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: () => {signMeUp()},
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
                            "Sign Up",
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
                            "Already Have Account?",
                            style: whiteTextStyle(),
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.toogle();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                "Login Now",
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
    );
  }
}
