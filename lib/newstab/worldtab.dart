import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../news/worldtitle.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class WorldTab extends StatefulWidget {
  WorldTab({Key? key}) : super(key: key);

  @override
  _WorldTabState createState() => _WorldTabState();
}

class _WorldTabState extends State<WorldTab> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    _nameController.text = '';
    _descriptionController.text = '';
    _dateController.text = '';

    await showModalBottomSheet(
        backgroundColor: Colors.white,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              //bottom: MediaQuery.of(ctx).viewInsets.bottom + 20
            ),
            child: Form(
              key: _formKey,
              //autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Icon(Icons.article),
                  ),
                  Center(
                      child: Text(
                    "Add New post",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 18,
                    ),
                  )),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Date';
                      }
                      return null;
                    },
                    controller: _dateController,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today_rounded),
                        labelText: 'Date inscription',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3))),
                    onTap: () async {
                      DateTime? pickeddate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));
                      if (pickeddate != null) {
                        setState(() {
                          _dateController.text =
                              DateFormat('yyyy-MM-dd').format(pickeddate);
                        });
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Description';
                      }
                      return null;
                    },
                    maxLength: 300,
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.title),
                        labelText: 'Description',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 80,
                      ),
                      ElevatedButton.icon(
                        icon: Icon(Icons.post_add),
                        label: Text(
                          "Create",
                          style: TextStyle(fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ),
                        ////////////////  //////////////////////////////////////////////////////////////////////////////////////
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final String name = _nameController.text;
                            final String descriptionpost =
                                _descriptionController.text;
                            final String date = _dateController.text;
                            if (name != null) {
                              _news.add({
                                "userpost": user.email!,
                                "datepost": date,
                                "descriptionpost": descriptionpost
                              });

                              _nameController.text = '';
                              _descriptionController.text = '';
                              _dateController.text = '';
                              Navigator.of(context).pop();
                            }
                          } else {
                            print("invalide");
                          }
                        },
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                        ),
                        icon: Icon(Icons.close),
                        label: Text(
                          "Cancel",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 320,
                  )
                ],
              ),
            ),
          );
        });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final CollectionReference _news =
      FirebaseFirestore.instance.collection('news');

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final double borderRadius = 12;

  @override
  Widget build(BuildContext) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          _create();
        },
        child: const Icon(Icons.post_add),
      ),
      body: StreamBuilder(
          //future: _products.get(),
          stream: _news.snapshots(),
          builder: (context, AsyncSnapshot streamSnapshot) {
            if (streamSnapshot.hasData) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: StaggeredGridView.countBuilder(
                    crossAxisCount: 1,
                    staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                    /*gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      //childAspectRatio: 1.8,
                    ),*/
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius:
                                  BorderRadius.circular(borderRadius)),
                          child: Column(
                            children: [
                              //date
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          padding: EdgeInsets.all(12),
                                          child: Text(
                                            // user.email!,
                                            documentSnapshot['userpost'] + ' :',
                                            style: TextStyle(
                                                color: Colors.blue[800],
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
                                            color: Colors.blue[100],
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(
                                                    borderRadius),
                                                topRight: Radius.circular(
                                                    borderRadius)),
                                          ),
                                          padding: EdgeInsets.all(12),
                                          child: Text(
                                            documentSnapshot['datepost'],
                                            style: TextStyle(
                                                color: Colors.blue[800],
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Text(
                                  documentSnapshot['descriptionpost'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(
                                              left: 330, bottom: 10),
                                          child: Icon(
                                            Icons.favorite,
                                            color: Color.fromARGB(
                                                255, 250, 89, 142),
                                          ))
                                    ],
                                  ),
                                ],
                              )
                              //love icon + add button
                            ],
                          ),
                        ),
                      );
                    }),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
