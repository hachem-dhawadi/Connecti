import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Postes extends StatefulWidget {
  Postes({Key? key}) : super(key: key);

  @override
  _PostesState createState() => _PostesState();
}

class _PostesState extends State<Postes> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    _descriptionController.text = '';
    _dateController.text = '';

    await showModalBottomSheet(
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
                          "Add",
                          style: TextStyle(fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ),
                        ////////////////  //////////////////////////////////////////////////////////////////////////////////////
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final String userpost = _nameController.text;
                            final String descriptionpost =
                                _descriptionController.text;
                            final String date = _dateController.text;
                            if (descriptionpost != null) {
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

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _dateController.text = documentSnapshot['datepost'];
      _descriptionController.text = documentSnapshot['descriptionpost'];
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
            child: Container(
              padding: EdgeInsets.only(bottom: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*Center(
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Color.fromARGB(255, 186, 196, 240),
                        child: Icon(
                          Icons.add_photo_alternate,
                          size: 50,
                        ),
                      ),
                    ),*/

                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Icon(Icons.badge),
                    ),
                    Center(
                        child: Text(
                      "Updating post",
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 18,
                      ),
                    )),
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
                          return 'Please enter your description';
                        }
                        return null;
                      },
                      maxLength: 300,
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.title),
                          labelText: 'description',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 3))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 60,
                        ),
                        ElevatedButton.icon(
                          icon: Icon(Icons.change_circle),
                          label: Text(
                            "Update",
                            style: TextStyle(fontSize: 18),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final String descriptionpost =
                                  _descriptionController.text;
                              final String date = _dateController.text;
                              if (descriptionpost != null) {
                                await _news.doc(documentSnapshot!.id).update({
                                  "datepost": date,
                                  "descriptionpost": descriptionpost
                                });
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
                      height: 400,
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> _delete(String productId) async {
    await _news.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Row(
        children: [
          Text('post have been successfully deleted  '),
          Icon(Icons.done),
        ],
      ),
    ));
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
                                margin: EdgeInsets.only(
                                    top: 10, left: 15, right: 15, bottom: 8),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(left: 25),
                                          child: Icon(
                                            Icons.favorite,
                                            color: Color.fromARGB(
                                                255, 250, 89, 142),
                                          ))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(right: 15),
                                          child: IconButton(
                                              onPressed: () =>
                                                  _update(documentSnapshot),
                                              icon: Icon(
                                                Icons.edit,
                                                color: Colors.black,
                                              ))),
                                      Container(
                                          margin: EdgeInsets.only(right: 15),
                                          child: IconButton(
                                              onPressed: () =>
                                                  showDialog<String>(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      title: const Text(
                                                          'Delete Post'),
                                                      content: const Text(
                                                          'Are you sure to Delete ?'),
                                                      actions: <Widget>[
                                                        ElevatedButton.icon(
                                                          onPressed: () {
                                                            _delete(
                                                                documentSnapshot
                                                                    .id);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary:
                                                                Colors.green,
                                                          ),
                                                          icon: Icon(Icons
                                                              .delete_forever),
                                                          label: Text(
                                                            "Delete",
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          ),
                                                        ),
                                                        ElevatedButton.icon(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary: Colors.red,
                                                          ),
                                                          icon:
                                                              Icon(Icons.close),
                                                          label: Text(
                                                            "Cancel",
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ))),
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
