import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forte/constants.dart';
import 'package:forte/screens/sign_up.dart';

import '../sharedPref.dart';
import 'Home.dart';

class LoginPage extends StatefulWidget {
  static const id = "login_page";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  GlobalKey keyF = GlobalKey<ScaffoldState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 250,
                child: Form(
                  autovalidate: true,
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
                      SizedBox(height: 30.0),
                      Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.w200,
                          color: Color(0xff083E9E),
                        ),
                      ),
                      Text("Securely login to your Forte"),
                      SizedBox(
                        height: 40.0,
                      ),
                      Text("Email Address"),
                      SizedBox(height: 8.0),
                      TextFormField(
                          controller: emailController,
                          autovalidate: false,
                          validator: (value) {
                            var regx = RegExp(
                                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
                                caseSensitive: false);

                            if (!regx.hasMatch(value)) {
                              return 'This email is not valid';
                            }

                            return '';
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: kInputDecoration.copyWith(
                              hintText: "user@example.com")),
                      SizedBox(
                        height: 25.0,
                      ),
                      Text("Your Password"),
                      SizedBox(height: 8.0),
                      TextFormField(
                        controller: pwdController,
                        autovalidate: true,
                        obscureText: true,
                        decoration:
                            kInputDecoration.copyWith(hintText: "***********"),
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
                                  final pwd = pwdController.value.text;
                                  final email = pwdController.value.text;
                                  FirebaseUser user;
                                  setState(() {
                                    isLoading = true;
                                  });
                                  try {
                                    if (pwd.isNotEmpty && email.isNotEmpty) {
                                      user = (await _auth
                                              .signInWithEmailAndPassword(
                                        email: emailController.text,
                                        password: pwdController.text,
                                      ))
                                          .user;
                                      if (user != null) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        setAnyinSharedPref(user.uid, 'user');
                                        Navigator.pushNamedAndRemoveUntil(
                                            context, Home.id, (r) => false);
                                      } else {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        final snackBar = SnackBar(
                                          content: Text(
                                            'Error logging in at the moment',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          duration: Duration(seconds: 5),
                                        );
                                        Scaffold.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    } else {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      final snackBar = SnackBar(
                                        content: Text(
                                          'One of the fields is empty',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        duration: Duration(seconds: 5),
                                      );
                                      Scaffold.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  } catch (_) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    final snackBar = SnackBar(
                                      content: Text(
                                        'Error logging in at the moment',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      duration: Duration(seconds: 5),
                                    );
                                    Scaffold.of(context).showSnackBar(snackBar);
                                  }
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
                                    Text("LOG IN"),
                                  ],
                                )
                              : Text("LOG IN"),
                          color: Color(0xff083E9E),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                            onTap: () =>
                                Navigator.pushNamed(context, SignUp.id),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 3.0),
                              child: Text(
                                "Don't have an account? Register",
                                style: TextStyle(color: kMainColor),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              Image.asset('images/2650152.png', height: 80.0)
            ],
          ),
        ),
      ),
    );
  }
}
