import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forte/constants.dart';
import 'package:forte/models/userModel.dart';
import 'package:forte/screens/login.dart';

import '../sharedPref.dart';
import 'Home.dart';

class SignUp extends StatefulWidget {
  static const id = "signup_page";

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Container(
          padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 200,
                child: Form(
                  child: ListView(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.close,
                              size: 32.0,
                            )),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        "Create Account",
                        style: TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.w200,
                          color: Color(0xff083E9E),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text("Full Name"),
                      SizedBox(height: 2.0),
                      Container(
                        height: 40.0,
                        child: TextFormField(
                            controller: name,
                            decoration: kInputDecoration.copyWith(
                                hintText: "Full Name")),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Text("Email Address"),
                      SizedBox(height: 8.0),
                      Container(
                        height: 40.0,
                        child: TextFormField(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: kInputDecoration.copyWith(
                              hintText: "Email address"),
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text("Phone Number"),
                      SizedBox(height: 8.0),
                      Container(
                        height: 40.0,
                        child: TextFormField(
                            controller: phone,
                            keyboardType: TextInputType.phone,
                            decoration: kInputDecoration.copyWith(
                                hintText: "0812xxxxxxx")),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text("Password"),
                      SizedBox(height: 8.0),
                      Container(
                        height: 40.0,
                        child: TextFormField(
                          obscureText: true,
                          controller: password,
                          decoration: kInputDecoration.copyWith(
                              hintText: "***********"),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      ButtonTheme(
                        height: 50.0,
                        child: RaisedButton(
                          textColor: Colors.white,
                          shape: kBoxDecoration,
                          onPressed: isLoading
                              ? null
                              : () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: email.text,
                                          password: password.text)
                                      .then((value) {
                                    if (value.user.uid != null) {
                                      var a = UserModel(
                                          name: name.text,
                                          phoneNumber: phone.text,
                                          userId: value.user.uid);
                                      Firestore.instance
                                          .collection('users')
                                          .document(value.user.uid)
                                          .setData(a.toMap())
                                          .then((v) {
                                        setAnyinSharedPref(
                                            value.user.uid, 'user');

                                        Navigator.pushNamedAndRemoveUntil(
                                            context, Home.id, (r) => false);
                                      });
                                    } else {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      print('error');
                                    }
                                  });
                                },
                          child: isLoading
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text("CREATE ACCOUNT"),
                                  ],
                                )
                              : Text("CREATE ACCOUNT"),
                          color: Color(0xff083E9E),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      FlatButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "Already have an account? Log in",
                          style: TextStyle(color: kMainColor),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      )
                    ],
                  ),
                ),
              ),
              Image.asset('images/2650152.png', height: 50.0)
            ],
          ),
        ),
      ),
    );
  }
}
