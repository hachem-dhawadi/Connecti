import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_page/home/homepage.dart';
import 'package:login_page/intro/intro_page_1.dart';
import 'package:login_page/intro/intro_page_2.dart';
import 'package:login_page/intro/intro_page_3.dart';
import 'package:login_page/intro/selfpage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MyButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  MyButton({super.key, required this.text, required this.onPressed});

  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.green,
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
