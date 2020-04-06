import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_graph/info.dart';
import 'package:social_graph/login.dart';

class ProfilePage extends StatelessWidget {
  static String user = "hwe";
  static String email = 'exampke@gmail.com';
  static String phone = '+880 847 784 74';

  void getvalue(String na, String mail) {
    user = na;
    email = mail;
  }

  void _showDialog(BuildContext context, {String title, String msg}) {
    final Dialog = AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: <Widget>[
        RaisedButton(
          color: Colors.teal,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Close',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    );
    showDialog(context: context, builder: (x) => Dialog);
  }

  void value() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser mCurrentUser = await _auth.currentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff132240),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/logo.png'),
              ),
              Padding(
                padding: const EdgeInsets.all(2),
              ),
              SizedBox(
                height: 30,
                width: 300,
                child: Divider(
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
              ),
              InfoCard(
                icon: null,
                text: 'Name : $user',
              ),
              Padding(
                padding: const EdgeInsets.all(5),
              ),
              InfoCard(
                icon: null,
                text: 'Email : $email',
              ),
              Padding(
                padding: const EdgeInsets.all(5),
              ),
              InfoCard(
                icon: null,
                text: 'Mobile No: $phone',
              ),
              Padding(
                padding: const EdgeInsets.all(20),
              ),
              FlatButton(
                color: Colors.white,
                onPressed: () => {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (Route<dynamic> route) => false,
                  )
                },
                child: Text(
                  'Sign out',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
