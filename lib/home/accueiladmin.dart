import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_page/home/chat.dart';
import 'package:login_page/home/homepage.dart';
import 'package:login_page/home/listusers.dart';
import 'package:login_page/home/news.dart';
import 'package:login_page/home/newsadmin.dart';
import 'package:login_page/home/profil.dart';
import 'package:login_page/home/todo.dart';
import 'package:login_page/home/todo/postes.dart';
import 'package:login_page/intro/intro_page_1.dart';
import 'package:login_page/intro/intro_page_2.dart';
import 'package:login_page/intro/intro_page_3.dart';
import 'package:login_page/intro/selfpage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class AccueilAdmin extends StatefulWidget {
  AccueilAdmin({Key? key}) : super(key: key);

  @override
  _AccueilAdminState createState() => _AccueilAdminState();
}

class _AccueilAdminState extends State<AccueilAdmin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //final user = FirebaseAuth.instance.currentUser!;
  PageController _controller = PageController();
  bool onLastPage = false;
  int index = 0;
  final screens = [
    ListUsers(),
    ToDo(),
    NewsAdmin(),
    //Chat(),
    Profil(),
  ];
  final navigationkey = GlobalKey<CurvedNavigationBarState>();
  final items = <Widget>[
    Icon(
      Icons.groups,
      size: 30,
    ),
    Icon(
      Icons.fact_check,
      size: 30,
    ),
    Icon(
      Icons.now_widgets_rounded,
      size: 30,
    ),
    /*Icon(
      Icons.video_camera_front_rounded,
      size: 30,
    ),*/
    Icon(
      Icons.manage_accounts,
      size: 30,
    )
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        /*appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 69, 51, 150),
        ),*/
        bottomNavigationBar: Theme(
          data: Theme.of(context)
              .copyWith(iconTheme: IconThemeData(color: Colors.white)),
          child: CurvedNavigationBar(
            key: navigationkey,
            animationDuration: Duration(milliseconds: 400),
            color: Colors.blueAccent,
            backgroundColor: Colors.blueAccent,
            buttonBackgroundColor: Colors.blueAccent,
            index: index,
            height: 60,
            items: items,
            onTap: (index) => setState(() => this.index = index),
          ),
        ),
        /*drawer: Drawer(
          child: Container(
            color: Color.fromARGB(255, 87, 107, 161),
            child: ListView(
              children: [
                DrawerHeader(
                  decoration:
                      BoxDecoration(color: Color.fromARGB(255, 87, 107, 161)),
                  margin: EdgeInsets.all(0.0),
                  padding: EdgeInsets.all(0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 4,
                      ),
                      CircleAvatar(
                        //backgroundColor: Color.fromARGB(255, 78, 42, 42),
                        radius: 50.0,
                        backgroundImage: AssetImage("lib/images/hachem.jpg"),
                        /*child: ClipRRect(
                            child: Image.asset("lib/images/men3.jpg"),
                            borderRadius: BorderRadius.circular(80.0),
                          ),*/
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Hachem Dhawadi",
                        //documentSnapshot['cin'].toString(),
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "ffff",
                        //user.email!,
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(children: <Widget>[
                  Expanded(
                      child: Divider(
                    color: Color.fromARGB(237, 45, 48, 48),
                  )),
                ]),
                ListTile(
                  leading: Icon(
                    Icons.tips_and_updates,
                    color: Color.fromARGB(255, 243, 242, 242),
                    size: 30,
                  ),
                  title: Text(
                    "Introduction",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed("selfpage");
                  },
                ),
                Row(children: <Widget>[
                  Expanded(
                      child: Divider(
                    color: Color.fromARGB(237, 45, 48, 48),
                  )),
                ]),
                ListTile(
                  leading: Icon(
                    Icons.home_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                  title: Text(
                    "Home Page",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed("homepage");
                  },
                ),
                Row(children: <Widget>[
                  Expanded(
                      child: Divider(
                    color: Color.fromARGB(237, 45, 48, 48),
                  )),
                ]),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: 29,
                  ),
                  title: Text(
                    "Logout",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                  },
                ),
              ],
            ),
          ),
        ),*/
        body: screens[index],
      );
}
