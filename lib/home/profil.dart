import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:login_page/auth/login.dart';
import 'package:overlay_support/overlay_support.dart';

class Profil extends StatefulWidget {
  Profil({Key? key}) : super(key: key);

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final navigatorKey = GlobalKey<NavigatorState>();
  PageController _controller = PageController();
  bool hasInternet = false;
  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 24.0, right: 55),
          child: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.blueGrey[800],
              size: 30,
            ),
            onPressed: () {
              // open drawer
            },
          ),
        ),
        title: Text(
          "               Profil",
          style: TextStyle(
            fontSize: 25,
            color: Colors.grey,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: IconButton(
              icon: Icon(
                Icons.notifications_active,
                color: Colors.blueGrey[800],
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
          SizedBox(
            height: 35,
          ),
          Center(
            child: CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('lib/images/pp.png'),
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Text(
            "signed in as " + user.email!,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
          ),
          SizedBox(
            height: 60,
          ),
          ElevatedButton.icon(
            onPressed: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  title: Text('Upload'),
                  content: Text(
                    'There is no notification at this moment please',
                  ),
                  actions: <Widget>[
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent,
                      ),
                      label: Text(
                        "Ok",
                        style: TextStyle(fontSize: 18),
                      ),
                      icon: Icon(Icons.done),
                    ),
                  ],
                ),
              );
            },
            style: ElevatedButton.styleFrom(
                fixedSize: Size(370, 45),
                primary: Colors.blueAccent,
                shape: StadiumBorder()),
            icon: Icon(
              Icons.notifications,
              size: 22,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            label: Text(
              "Notification",
              style: TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton.icon(
            onPressed: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  title: Text('Upload'),
                  content: Text('Admin retrive this Role'),
                  actions: <Widget>[
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent,
                      ),
                      label: Text(
                        "Ok",
                        style: TextStyle(fontSize: 18),
                      ),
                      icon: Icon(Icons.done),
                    ),
                  ],
                ),
              );
            },
            style: ElevatedButton.styleFrom(
                fixedSize: Size(370, 45),
                primary: Colors.blueAccent,
                shape: StadiumBorder()),
            icon: Icon(
              Icons.settings,
              size: 22,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            label: Text(
              "Update account ",
              style: TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed("forgetpass");
            },
            style: ElevatedButton.styleFrom(
                fixedSize: Size(370, 45),
                primary: Colors.blueAccent,
                shape: StadiumBorder()),
            icon: Icon(
              Icons.lock_reset,
              size: 22,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            label: Text(
              "Change Password  ",
              style: TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton.icon(
            onPressed: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  title: Text('Upload'),
                  content: Text('Are you sure you want to logout '),
                  actions: <Widget>[
                    ElevatedButton.icon(
                      onPressed: () async {
                        var text;
                        var color;
                        hasInternet =
                            await InternetConnectionChecker().hasConnection;
                        if (hasInternet == true) {
                          text = 'Internet exist';
                          color = Colors.green;
                          showSimpleNotification(Text('$text'),
                              background: color);
                          signOut();
                        } else {
                          text = 'check Your Connexion to sign out !';
                          color = Colors.red;
                          showSimpleNotification(Text('$text'),
                              background: color);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent,
                      ),
                      label: Text(
                        "Yes",
                        style: TextStyle(fontSize: 18),
                      ),
                      icon: Icon(Icons.done),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                      label: Text(
                        "No ",
                        style: TextStyle(fontSize: 18),
                      ),
                      icon: Icon(Icons.clear),
                    ),
                  ],
                ),
              );
            },
            style: ElevatedButton.styleFrom(
                fixedSize: Size(370, 45),
                primary: Colors.blueAccent,
                shape: StadiumBorder()),
            icon: Icon(
              Icons.logout,
              size: 22,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            label: Text(
              "Logout ",
              style: TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ),
        ],
      ));
  signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => Login()), (route) => false);
  }
}
