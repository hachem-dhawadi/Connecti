import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_page/home/homepage.dart';
import 'package:login_page/home/todo/constants/colors.dart';
import 'package:login_page/home/todo/postes.dart';
import 'package:login_page/intro/intro_page_1.dart';
import 'package:login_page/intro/intro_page_2.dart';
import 'package:login_page/intro/intro_page_3.dart';
import 'package:login_page/intro/selfpage.dart';
import 'package:login_page/newstab/adminEvent.dart';
import 'package:login_page/newstab/adminFile.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../newstab/companytab.dart';
import '../newstab/moneytab.dart';
import '../newstab/worldtab.dart';
import 'package:login_page/news/mytab.dart';

class NewsAdmin extends StatefulWidget {
  NewsAdmin({Key? key}) : super(key: key);

  @override
  _NewsAdminState createState() => _NewsAdminState();
}

class _NewsAdminState extends State<NewsAdmin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;
  PageController _controller = PageController();
  List<Widget> myTabs = const [
    //reunion
    MyTab(
      iconPath: 'lib/images/blog.png',
    ),
    //world
    MyTab(
      iconPath: 'lib/images/folders.png',
    ),
    //micro
    MyTab(
      iconPath: 'lib/images/company.png',
    ),
  ];

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: myTabs.length,
        child: Scaffold(
          //backgroundColor: tdBGColor,
          //backgroundColor: Colors.blue[50],
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: EdgeInsets.only(left: 24.0, right: 55),
              child: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.grey[800],
                  size: 30,
                ),
                onPressed: () {
                  // open drawer
                },
              ),
            ),
            title: Text(
              "   News FOR TODAY",
              style: TextStyle(
                  fontSize: 25, color: Color.fromARGB(255, 136, 132, 132)),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 24.0),
                child: IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.grey[800],
                    size: 30,
                  ),
                  onPressed: () {
                    // account button tapped
                  },
                ),
              )
            ],
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 14,
              ),
              TabBar(tabs: myTabs),
              //tab bar view
              Expanded(
                  child: TabBarView(children: [
                //world page
                Postes(),
                //company page
                AdminFile(),
                //moneypage
                AdminEvent()
              ]))
            ],
          ),
        ),
      );
}
