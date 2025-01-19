import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WorldTitle extends StatelessWidget {
  final String postTitle;
  final String worldTitle;
  final String worldDate;
  final worldColor;
  final String imageName;

  final double borderRadius = 12;

 WorldTitle({
    super.key,
    required this.postTitle,
    required this.worldTitle,
    required this.worldDate,
    required this.worldColor,
    required this.imageName,
  });

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

 

  @override
  Widget build(BuildContext) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
            color: worldColor[50],
            borderRadius: BorderRadius.circular(borderRadius)),
        child: Column(
          children: [
            //date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          postTitle + ' :',
                          style: TextStyle(
                              color: worldColor[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: worldColor[100],
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(borderRadius),
                              topRight: Radius.circular(borderRadius)),
                        ),
                        padding: EdgeInsets.all(12),
                        child: Text(
                          worldDate,
                          style: TextStyle(
                              color: worldColor[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        )),
                  ],
                ),
              ],
            ),
            //SizedBox(height: 10,),
            //picture
            /*Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
              child: Image.asset(
                imageName,
                height: 20,
                width: 20,
              ),
            )*/
            //title
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                worldTitle,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 25),
                        child: Icon(
                          Icons.favorite,
                          color: Color.fromARGB(255, 250, 89, 142),
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 15),
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blueAccent, shape: StadiumBorder()),
                        icon: Icon(
                          Icons.info,
                          size: 18,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        label: Text(
                          "Details",
                          style: TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                      /*Text(
                          "Details",
                          style: TextStyle(
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                          ),
                        )*/
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 15),
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 30,
                      ),
                    )
                  ],
                ),
              ],
            )
            //love icon + add button
          ],
        ),
      ),
    );
  }
}
