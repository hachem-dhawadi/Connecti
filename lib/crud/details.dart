import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/material/input_decorator.dart';

class Details extends StatefulWidget {
  Details({Key? key}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //iconTheme: Icon(icon),
        title: Text("Details"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Form(
                  child: Column(
                children: [
                  Container(
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Color.fromARGB(255, 186, 196, 240),
                      child: Icon(
                        Icons.add_photo_alternate,
                        size: 50,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  /*TextFormField(
                    maxLength: 20,
                    decoration: InputDecoration(
                      labelText: "Nom : " ,
                      label: Text( documentSnapshot['name'],),
                        hintText: "First_name & Last name",
                        prefixIcon: Icon(Icons.title),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3))),
                  ),*/
                  TextFormField(
                    maxLength: 20,
                    decoration: InputDecoration(
                        hintText: "First_name & Last name",
                        prefixIcon: Icon(Icons.title),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3))),
                  ),
                  TextFormField(
                    maxLength: 30,
                    decoration: InputDecoration(
                        hintText: "Email",
                        prefixIcon: Icon(Icons.mail),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3))),
                  ),
                  TextFormField(
                    maxLength: 8,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "Cin",
                        prefixIcon: Icon(Icons.pin),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3))),
                  ),
                  TextFormField(
                    maxLength: 2,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "Age",
                        prefixIcon: Icon(Icons.format_list_numbered),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3))),
                  ),
                  TextFormField(
                    maxLength: 8,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "Phone",
                        prefixIcon: Icon(Icons.add_call),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3))),
                  ),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        //margin: EdgeInsets.only(right: 275),
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          style:
                              ElevatedButton.styleFrom(primary: Colors.green),
                          icon: Icon(
                            Icons.change_circle,
                            size: 22,
                          ),
                          label: Text(
                            "update",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                          icon: Icon(Icons.close),
                          label: Text(
                            "Cancel",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  /*showBottomSheet() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(20),
            height: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Select Image",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.photo_library,
                          size: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "From Galerie",
                          style: TextStyle(fontSize: 17),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.camera_alt,
                          size: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "From Camera",
                          style: TextStyle(fontSize: 17),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }*/

}
