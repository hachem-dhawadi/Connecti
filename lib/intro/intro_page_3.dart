import 'package:flutter/material.dart';

class IntroPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 255, 255, 255),
        child: Center(
          child: Column(
            children: [
              Image.asset(
                "lib/images/Telework.gif",
                height: 480,
              ),
              Text(
                "We hope you enjoy using our app\n and find it  useful in your daily life. \nLet us know if you have questions.\n",
                style: TextStyle(
                  fontSize: 16,
                  // color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              Text(
                "You can send email to the Admin\nin your claim page where you \nexplain the probleme.\n Email : Admin@gmail.com",
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
  }
}
