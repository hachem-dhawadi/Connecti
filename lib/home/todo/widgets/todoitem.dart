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
import 'package:flutter_slidable/flutter_slidable.dart';


//import '../intro/self_page.dart';

class ToDoItem extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onchanged;
  Function(BuildContext)? deleteFunction;

  ToDoItem({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onchanged,
    required this.deleteFunction,
  });
  //ToDoTitle
  //final FirebaseAuth auth = FirebaseAuth.instance;
  //final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Slidable(
          endActionPane: ActionPane(motion: StretchMotion(), children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade500,
              borderRadius: BorderRadius.circular(12),
            ),
          ]),
          child: ListTile(
            onTap: () {},
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            contentPadding: EdgeInsets.only(top: 10, right: 8, bottom: 10),
            tileColor: Colors.white,
            leading: Checkbox(
              value: taskCompleted,
              onChanged: onchanged,
            ),
            /*Icon(
                Icons.check_box,
                color: tdBlue,
              ),*/
            title: Text(
              taskName,
              style: TextStyle(
                  fontSize: 15,
                  color: tdBlack,
                  decoration: taskCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
            ),
          ),
        ));
  }
}
