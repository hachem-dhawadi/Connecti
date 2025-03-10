import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:email_auth/email_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Forgetpass extends StatefulWidget {
  Forgetpass({Key? key}) : super(key: key);

  @override
  _ForgetpassState createState() => _ForgetpassState();
}

class _ForgetpassState extends State<Forgetpass> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final navigatorKey = GlobalKey<NavigatorState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            //Text("Login Now",style: TextStyle(fontStyle: FontStyle.italic),),
            Center(
              child: Column(
                  // margin: EdgeInsets.only(top: 50),
                  children: [
                    SizedBox(
                      height: 17,
                    ),
                    Image.asset(
                      "lib/images/email_check5.gif",
                      height: 280,
                      //width: 600,
                    ),
                    Text(
                      "An Email will send to your account\n to verify the same User ther you can\n click a link and reset your password ",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 70, 75, 80),
                      ),
                    ),
                    /*Image.network(
                    "https://asitive.com/wp-content/uploads/2022/06/istockphoto-1281150061-612x612-1.jpg",
                    height: 300,
                    width: 500,
                  ),*/
                  ]),
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              child: Container(
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
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: InkWell(
                          onTap: (() {
                            Navigator.of(context)
                                .pushReplacementNamed("signup");
                          }),
                          child: Row(
                            children: [
                              Text(
                                "Create another account ",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 70, 75, 80),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              Icon(
                                Icons.add_circle,
                                color: Color.fromARGB(255, 126, 142, 155),
                                size: 20,
                              )
                            ],
                          ),
                        ),
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
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            resetPassword();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 55, 152, 243),
                            shape: StadiumBorder()),
                        icon: Icon(
                          Icons.forward_to_inbox,
                          size: 25,
                        ),
                        label: Text(
                          "Rest Password",
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
                      height: 15,
                    ),
                    Container(
                        child: SizedBox(
                      height: 50,
                      width: 300,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed("homepage");
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
                      height: 15,
                    ),
                    Container(
                        child: SizedBox(
                      height: 50,
                      width: 300,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed("homepage");
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff3b5998), shape: StadiumBorder()),
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
                    /* SizedBox(
                      height: 15,
                    ),
                    Container(
                        child: SizedBox(
                      height: 50,
                      width: 300,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed("homepage");
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
                    /*SizedBox(
                      height: 20,
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
                    )*/
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          title: Text('email sent'),
          content:
              Text("An email have been sent succefully ,check your account "),
          actions: <Widget>[
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed("login");
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              label: Text(
                "Login again",
                style: TextStyle(fontSize: 18),
              ),
              icon: Icon(Icons.replay),
            ),
          ],
        ),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          title: Text('email failed'),
          content: Text(e.message.toString()),
          actions: <Widget>[
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              label: Text(
                "Try again",
                style: TextStyle(fontSize: 18),
              ),
              icon: Icon(Icons.no_accounts_sharp),
            ),
          ],
        ),
      );
    }
  }
}
