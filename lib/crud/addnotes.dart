import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:login_page/home/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/material/input_decorator.dart';
import 'package:validators/validators.dart';

class AddNotes extends StatefulWidget {
  AddNotes({Key? key}) : super(key: key);

  @override
  _AddNotesState createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  final CollectionReference _products =
      FirebaseFirestore.instance.collection('products');

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cinController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Form(
              //autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    maxLength: 20,
                    controller: _nameController,
                    decoration: InputDecoration(
                        labelText: 'First_Name & Last_Name',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3))),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    maxLength: 8,
                    keyboardType: TextInputType.number,
                    controller: _cinController,
                    decoration: const InputDecoration(
                        labelText: 'Cin',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3))),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    maxLength: 30,
                    //keyboardType: TextInputType.number,
                    controller: _emailController,
                    decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3))),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    maxLength: 2,
                    keyboardType: TextInputType.number,
                    controller: _ageController,
                    decoration: const InputDecoration(
                        labelText: 'Age',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3))),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    maxLength: 8,
                    keyboardType: TextInputType.number,
                    controller: _phoneController,
                    decoration: const InputDecoration(
                        labelText: 'Phone',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3))),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    child: const Text('Create'),
                    onPressed: () async {
                      final String name = _nameController.text;
                      final String email = _emailController.text;
                      final String cin = _cinController.text;
                      final String age = _ageController.text;
                      final String phone = _phoneController.text;
                      if (cin != null) {
                        await _products.add({
                          "name": name,
                          "cin": cin,
                          "email": email,
                          "age": age,
                          "phone": phone
                        });

                        _nameController.text = '';
                        _cinController.text = '';
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //iconTheme: Icon(icon),
        title: Text("Add Person"),
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
                          onPressed: () {
                            //Navigator.of(context).pop();
                            _create();
                          },
                          style:
                              ElevatedButton.styleFrom(primary: Colors.green),
                          icon: Icon(
                            Icons.person_add,
                            size: 22,
                          ),
                          label: Text(
                            "Add",
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
