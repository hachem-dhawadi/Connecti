import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_page/intro/intro_page_1.dart';
import 'package:login_page/intro/intro_page_2.dart';
import 'package:login_page/intro/intro_page_3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

//import '../intro/self_page.dart';

class IntroPage2 extends StatelessWidget {
  //final FirebaseAuth auth = FirebaseAuth.instance;
  //final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 255, 255, 255),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Image.asset(
                "lib/images/login.gif",
                height: 430,
              ),
              Text(
                "    create to-do lists, and manage it\n   as you see fit.You can update\n or delete them at any time you wnat. \n",
                style: TextStyle(
                  fontSize: 16,
                  // color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              Text(
                "For your convenience,you have the \n ability to reset your password,\nrequest help and log out at any time.\n",
                style: TextStyle(
                  fontSize: 16,
                  // color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    /*Text(user.email!),
        SizedBox(height: 50,),
          ElevatedButton.icon(
                    onPressed: () async{
                      //Navigator.of(context).pushReplacementNamed("homepage");
                     await FirebaseAuth.instance.signOut();
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 55, 152, 243),
                        shape: StadiumBorder()),
                    icon: Icon(
                      Icons.login,
                      size: 25,
                    ),
                    label: Text(
                      "Logout button",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),*/
  }
}
