import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_page/home/todo/constants/colors.dart';
import 'package:login_page/intro/intro_page_1.dart';
import 'package:login_page/intro/intro_page_2.dart';
import 'package:login_page/intro/intro_page_3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SelfPage extends StatefulWidget {
  SelfPage({Key? key}) : super(key: key);

  @override
  _SelfPageState createState() => _SelfPageState();
}

PageController _controller = PageController();
bool onLastPage = false;

class _SelfPageState extends State<SelfPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //final user = FirebaseAuth.instance.currentUser!;
  //final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
        //appBar: AppBar(),H
        body: Stack(
          children: [
            PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  onLastPage = (index == 2);
                });
              },
              children: [IntroPage1(), IntroPage2(), IntroPage3()],
            ),
            Container(
                alignment: Alignment(0, 0.85),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //skip
                    GestureDetector(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _controller.jumpToPage(2);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blueAccent, shape: StadiumBorder()),
                        icon: Icon(
                          Icons.checklist,
                          size: 35,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        label: Text(
                          "Skip",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    ),

                    SmoothPageIndicator(
                      controller: _controller,
                      count: 3,
                      effect: SwapEffect(
                        activeDotColor: Color.fromARGB(255, 90, 144, 224),
                        dotColor: Colors.deepPurple.shade100,
                        dotHeight: 20,
                        dotWidth: 20,
                      ),
                    ),
                    //Next or done
                    onLastPage
                        ? GestureDetector(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                /* Navigator.of(context)
                                .pushReplacementNamed("selfpage");*/
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    title: const Text('Done !'),
                                    content: const Text(
                                        'We hope you understandand \nyou can begin using the App now!!\n hachemdhawadi1@gmail.com'),
                                    actions: <Widget>[
                                      Center(
                                        child: ElevatedButton.icon(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.blue,
                                          ),
                                          icon: Icon(Icons.check_box),
                                          label: Text(
                                            "OK!!!",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blueAccent,
                                  shape: StadiumBorder()),
                              icon: Icon(
                                Icons.done,
                                size: 35,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              label: Text(
                                "Done",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                _controller.nextPage(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeIn);
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blueAccent,
                                  shape: StadiumBorder()),
                              icon: Icon(
                                Icons.navigate_next,
                                size: 35,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              label: Text(
                                "Next",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                            ),
                          ),
                  ],
                )),
          ],
        ));
  }
}
