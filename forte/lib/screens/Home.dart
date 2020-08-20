import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forte/sharedPref.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  static const id = "home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var name;
  var phone;
  var uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => SafeArea(
          child: Stack(
            children: <Widget>[
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: Colors.black45,
                      width: 1.2,
                    ))),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Forte Laundry',
                          style: TextStyle(
                              color: Color(0xff1CB7F0),
                              height: 0.98,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: () =>
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content:
                                    Text('Service is persently not Available'),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 3),
                              ))),
                      Row(children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('images/avatar.png'),
                          radius: 24.0,
                        ),
                        SizedBox(width: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('$name',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w200)),
                            Text('Present Location:',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.red.shade300)),
                            Text('Akure',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w200)),
                          ],
                        ),
                        SizedBox(width: 10.0),
                      ])
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 10,
                  ),
                ],
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset('images/was.png')),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: InkWell(
                    onTap: () async {
                      var url =
                          'http://forte.itusacademy.com/?tel=$phone&&name=$name&&token=qwertyuioplkjhgfdsnm';

                      print(url);

                      // Await the http get response, then decode the json-formatted response.
                      var response = await http.get(
                        url,
                      );
                      if (response.statusCode == 200 &&
                          response.body == 'Message has been sent') {
                        await showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) => CustomDialog(
                            description:
                                'We will contact you soon to pick up the laundry.',
                            buttonText: 'Okay',
                          ),
                        );
                      } else {
                        await showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) => CustomDialog(
                            description:
                                'Please retry few minutes from now, the service is currectly unavailable.',
                            buttonText: 'Okay',
                          ),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black45,
                          width: 1.0,
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(
                                40.0) //         <--- border radius here
                            ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 26.0, vertical: 16.0),
                        child: Text(
                          'Place order',
                          style: TextStyle(
                              fontSize: 18.0, color: Color(0xFF5B7FE1)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 220.0),
                  child: Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black45,
                              width: 1.0,
                            ),
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(
                                    12.0) //         <--- border radius here
                                ),
                          ),
                          width: 60,
                          child: Stack(
                            children: [
                              Image.asset(
                                'images/qwe.png',
                                fit: BoxFit.fill,
                                width: 80.0,
                                height: 700,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      icon: Icon(Icons.bar_chart,
                                          color: Colors.red),
                                      onPressed: () => Scaffold.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                'Service is persently not Available'),
                                            backgroundColor: Colors.red,
                                            duration: Duration(seconds: 3),
                                          ))),
                                  IconButton(
                                      icon: Icon(Icons.credit_card),
                                      onPressed: () => Scaffold.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                'Service is persently not Available'),
                                            backgroundColor: Colors.red,
                                            duration: Duration(seconds: 3),
                                          ))),
                                  IconButton(
                                      icon: Icon(Icons.home),
                                      onPressed: () => Scaffold.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                'Service is persently not Available'),
                                            backgroundColor: Colors.red,
                                            duration: Duration(seconds: 3),
                                          ))),
                                  SizedBox(height: 80.0),
                                ],
                              ),
                            ],
                          )),
                      Expanded(child: SizedBox())
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> show(context) async {
    print('About to show scaffold');
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Service is persently not Available'),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
    ));
  }

  void getUid() async {
    await getAnyFromSharedPref('user').then((value) async {
      print('user value is $value');
      Firestore.instance
          .collection('users')
          .document(value)
          .get()
          .then((value) => setState(() {
                name = value.data['name'];
                phone = value.data['phoneNumber'];
              }));
    });
  }

  @override
  void initState() {
    super.initState();
    getUid();
  }
}

class CustomDialog extends StatelessWidget {
  final String description, buttonText;

  CustomDialog({
    @required this.description,
    @required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        //...bottom card part,
        //...top circlular image part,
        Container(
          padding: EdgeInsets.only(
            top: Consts.avatarRadius + Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding / 2,
            right: Consts.padding / 2,
          ),
          margin: EdgeInsets.only(
            top: Consts.avatarRadius / 3,
            right: Consts.avatarRadius / 3,
            left: Consts.avatarRadius / 3,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            // To make the card compact
            children: <Widget>[
              Center(
                child: Text(
                  'Thank You',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // To close the dialog
                  },
                  child: Text(buttonText),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: Consts.padding / 2,
          right: Consts.padding / 2,
          child: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            radius: Consts.avatarRadius / 1.5,
            child: Icon(
              Icons.sentiment_very_satisfied,
              size: 40.0,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}
