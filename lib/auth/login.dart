//import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:login_page/auth/google_sign_in.dart';
import 'package:login_page/auth/signup.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:login_page/home/accueil.dart';
import 'package:login_page/home/accueiladmin.dart';
import 'package:login_page/home/homepage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_page/home/profil.dart';
import 'package:provider/provider.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool hasInternet = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final navigatorKey = GlobalKey<NavigatorState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  /*StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Navigator.of(context).pushReplacementNamed("homepage");
              } else {
                Navigator.of(context).pushReplacementNamed("login");
                ;
              }
            },
          ),*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _emailController.text = '';
                _passwordController.text = '';
                return Accueil();
              } else {
                print("hh");
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    //Text("Login Now",style: TextStyle(fontStyle: FontStyle.italic),),
                    Center(
                      child: Container(
                        // margin: EdgeInsets.only(top: 50),
                        child: Image.asset(
                          "lib/images/login2.jpg",
                          height: 353,
                        ),
                        /*Image.network(
                    "https://asitive.com/wp-content/uploads/2022/06/istockphoto-1281150061-612x612-1.jpg",
                    height: 300,
                    width: 500,
                  ),*/
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
                      child: Column(
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _emailController,
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        !RegExp(r"[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@gmail.com")
                                            .hasMatch(value)) {
                                      return 'Please enter your Email Or check @ and .com';
                                    } else {
                                      print("true");
                                    }
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Email",
                                      prefixIcon: Icon(Icons.mail_lock),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(width: 3))),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: _passwordController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your Password ';
                                    }
                                    return null;
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: "Password",
                                      prefixIcon: Icon(Icons.lock),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(width: 3))),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: (() {
                                    Navigator.of(context)
                                        .pushNamed("forgetpass");
                                  }),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Forget password ",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color:
                                              Color.fromARGB(255, 70, 75, 80),
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      Icon(
                                        Icons.lock_reset_outlined,
                                        color:
                                            Color.fromARGB(255, 126, 142, 155),
                                        size: 25,
                                      )
                                    ],
                                  ),
                                ),
                                Spacer(
                                  flex: 2,
                                ),
                                InkWell(
                                  onTap: (() {
                                    Navigator.of(context).pushNamed("signup");
                                  }),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Create account ",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color:
                                              Color.fromARGB(255, 70, 75, 80),
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      Icon(
                                        Icons.add_circle,
                                        color:
                                            Color.fromARGB(255, 126, 142, 155),
                                        size: 20,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              child: SizedBox(
                            height: 50,
                            width: 300,
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                final text;
                                final color;
                                hasInternet = await InternetConnectionChecker()
                                    .hasConnection;
                                // final color =
                                //hasInternet ? Colors.green : Colors.red;
                                if (hasInternet == true) {
                                  text = 'Internet exist';
                                  color = Colors.green;
                                  showSimpleNotification(Text('$text'),
                                      background: color);
                                  if (_formKey.currentState!.validate()) {
                                    signIn2();
                                  }
                                } else {
                                  text = 'check Your Connexion to sign Up !';
                                  color = Colors.red;
                                  showSimpleNotification(Text('$text'),
                                      background: color);
                                }
                                //final text =
                                //  hasInternet ? 'Internet exist' : 'Please check Your Connexion !';
                                // showSimpleNotification(Text('$text'),
                                //background: color);
                                // if () {}
                                //signIn();
                                //signIn2();
                                //signInAdmin();
                                //Navigator.of(context).pushNamed("login");
                                //Navigator.of(context)
                                //.pushReplacementNamed("accueil");
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 55, 152, 243),
                                  shape: StadiumBorder()),
                              icon: Icon(
                                Icons.login,
                                size: 25,
                              ),
                              label: Text(
                                "Login in",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          )),
                          SizedBox(
                            height: 10,
                          ),
                          Row(children: <Widget>[
                            Expanded(
                                child: Divider(
                              color: Color.fromARGB(237, 45, 48, 48),
                            )),
                            Text("OR"),
                            Expanded(
                                child: Divider(
                              color: Color.fromARGB(237, 45, 48, 48),
                            )),
                          ]),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              child: SizedBox(
                            height: 50,
                            width: 300,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                //Navigator.of(context).pushReplacementNamed("homepage");
                                final provider =
                                    Provider.of<GoogleSignInProvider>(context,
                                        listen: false);
                                provider.googleLogin();
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 255, 255, 255),
                                  shape: StadiumBorder()),
                              icon: FaIcon(
                                FontAwesomeIcons.google,
                                size: 25,
                                color: Colors.red,
                              ),
                              label: Text(
                                " Sign up with google",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          )),
                          /*SizedBox(
                            height: 10,
                          ),
                          Container(
                              child: SizedBox(
                            height: 50,
                            width: 300,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed("accueil");
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xff3b5998),
                                  shape: StadiumBorder()),
                              icon: Icon(
                                Icons.facebook,
                                size: 35,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              label: Text(
                                "Sign up with Facebook",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                            ),
                          )),*/
                          /*SizedBox(
                            height: 10,
                          ),
                          Container(
                              child: SizedBox(
                            height: 50,
                            width: 300,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed("accueil");
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 96, 102, 107),
                                  shape: StadiumBorder()),
                              icon: Icon(
                                Icons.email_rounded,
                                size: 35,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              label: Text(
                                "Sign up with email",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                            ),
                          )),*/
                          Center(
                            child: Container(
                              // margin: EdgeInsets.only(top: 50),
                              child: Image.asset(
                                "lib/images/cim.png",
                                height: 200,
                                width: 200,
                              ),
                              /*Image.network(
                    "https://asitive.com/wp-content/uploads/2022/06/istockphoto-1281150061-612x612-1.jpg",
                    height: 300,
                    width: 500,
                  ),*/
                            ),
                          ),
                          /* SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Text(
                              "© Copyright 2022",
                              //© Copyright 2022 Rurutek Private Limited. All Rights Reserved
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 97, 92, 92),
                                //decoration: TextDecoration.underline,
                              ),
                            ),
                          ),*/
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }));
  }

  Future signIn() async {
    //try {
    //} on FirebaseAuthException catch (e) {}
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());

      Navigator.of(context).pop();
      if (Navigator.canPop(context)) {
        /*Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false);*/
        //Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
        // print("user login");
        //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: contex), (route) => false)
        //Navigator.popUntil(context, ModalRoute.withName("homepage"));
        //Navigator.of(context).pushReplacementNamed("homepage");
        //return Navigator.popUntil(context, ModalRoute.withName("homepage"));
        /*MaterialPageRoute(
          builder: (context) {
            return HomePage();
          },
        );*/
      } else {
        print("user ghalet login");
      }
      //Navigator.of(context).pop();
    } catch (e) {
      Navigator.of(context).pop();
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          title: const Text('Incorrect'),
          content: const Text('Email or Password inccorect'),
          actions: <Widget>[
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                icon: Icon(Icons.key_off),
                label: Text(
                  "try again",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      );
    }

    //navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future signIn2() async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      if (_emailController.text.trim() == "admin@gmail.com" &&
          _passwordController.text.trim() == "adminowner") {
        Navigator.of(context).pop();
        print("admin logged in");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => AccueilAdmin()),
            (route) => false);
      } else {
        Navigator.of(context).pop();
        print("no login");
      }
    } catch (e) {
      Navigator.of(context).pop();
      print(e);
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          title: const Text('Incorrect'),
          content: const Text('Email or Password inccorect'),
          actions: <Widget>[
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                icon: Icon(Icons.key_off),
                label: Text(
                  "try again",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}

/*
 await FirebaseFirestore.instance
          .collection("admin")
          .doc("adminLogin")
          .snapshots()
          .forEach((element) {
        if (element.data()?['adminEmail'] == _emailController.text &&
            element.data()?['adminPassword'] == _passwordController.text) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false);
          print("admin login");
        }
      });

*/


  /*StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Navigator.of(context).pushReplacementNamed("homepage");
              } else {
                Navigator.of(context).pushReplacementNamed("login");
                ;
              }
            },
          ),*/

/* showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          title: const Text('Incorrect'),
          content: const Text('Email or Password inccorect'),
          actions: <Widget>[
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                icon: Icon(Icons.key_off),
                label: Text(
                  "try again",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
           
          ],
        ),
      );*/

       // final dbRef = FirebaseDatabase.instance.ref().child("admin");
  /*Future signInAdmin() async {
    //try {
    //} on FirebaseAuthException catch (e) {}

    try {
      await FirebaseFirestore.instance
          .collection("admin")
          .doc("adminLogin")
          .snapshots()
          .forEach((element) {
        if (element.data()?['adminEmail'] == _emailController.text &&
            element.data()?['adminPassword'] == _passwordController.text) {
          print("admin login");
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Profil()),
              (route) => false);
        }
        FirebaseFirestore.instance
            .collection("admin")
            .doc("userLogin")
            .snapshots()
            .forEach((element) {
          if (element.data()?['userEmail'] == _emailController.text &&
              element.data()?['userPassword'] == _passwordController.text) {
            print("User login");
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Accueil()),
                (route) => false);
          }
        });
      });
      //Navigator.of(context).pop();
      /*await FirebaseFirestore.instance
          .collection("admin")
          .doc("adminLogin")
          .snapshots()
          .forEach((element) {
        Navigator.of(context).pop();
        if (element.data()?['adminEmail'] == _emailController.text &&
            element.data()?['adminPassword'] == _passwordController.text) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Accueil()),
              (route) => false);
          print("admin login");
        }
      });*/
      //Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }

    //navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }*/

  