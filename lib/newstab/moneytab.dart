import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class MoneyTab extends StatefulWidget {
  const MoneyTab({Key? key}) : super(key: key);
  @override
  _MoneyTabState createState() => _MoneyTabState();
}

class _MoneyTabState extends State<MoneyTab> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  String? value;
  String _displayValue = '';
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _TitleController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    final controller = TextEditingController();
    _nameController.text = '';
    _dateController.text = '';
    _TitleController.text = '';
    _placeController.text = '';
    _descriptionController.text = '';

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
                    "Add New Event",
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
                        return 'Please enter the title of Event';
                      }
                      return null;
                    },
                    //maxLength: 300,
                    controller: _TitleController,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.title),
                        labelText: 'Event Title',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Date of Post';
                      }
                      return null;
                    },
                    controller: _dateController,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today_rounded),
                        labelText: 'Date Event',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3))),
                    onTap: () async {
                      TimeOfDay? pickedtime = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                      DateTime? pickeddate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));
                      if (pickeddate != null && pickedtime != null) {
                        setState(() {
                          _dateController.text = DateFormat('yyyy-MM-dd-HH:mm')
                              .format(DateTime(
                                  pickeddate.year,
                                  pickeddate.month,
                                  pickeddate.day,
                                  pickedtime.hour,
                                  pickedtime.minute));
                        });
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Description';
                      }
                      return null;
                    },
                    //maxLength: 300,
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.text_format),
                        labelText: 'Description',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Location of Event';
                      }
                      return null;
                    },
                    //maxLength: 300,
                    controller: _placeController,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.place),
                        labelText: 'Location',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3))),
                  ),
                  /* TextFormField(
                    controller: _phoneController,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.length < 2 ||
                          value.length > 2) {
                        return 'Please enter your countity';
                      }
                      return null;
                    },
                    //maxLength: 8,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "Phone",
                        icon: Icon(Icons.title),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3))),
                  ),*/
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
                            final String title = _TitleController.text;
                            final String date = _dateController.text;
                            final String place = _placeController.text;
                            final String descriptionpost =
                                _descriptionController.text;

                            if (name != null) {
                              _users.add({
                                "user": user.email!,
                                "date_event": date,
                                "Title_event": title,
                                "descriptionpost": descriptionpost,
                                "place": place
                              });

                              _nameController.text = '';
                              _dateController.text = '';
                              _TitleController.text = '';
                              _descriptionController.text = '';
                              _placeController.text = '';

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
      _TitleController.text = documentSnapshot['Title_event'];
      _dateController.text = documentSnapshot['date_event'];
      _descriptionController.text = documentSnapshot['descriptionpost'];
      _placeController.text = documentSnapshot['place'];
      _nameController.text = documentSnapshot['user'];
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
                    Center(
                      child: Icon(Icons.article),
                    ),
                    Center(
                        child: Text(
                      "Add New Event",
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
                          return 'Please enter the title of Event';
                        }
                        return null;
                      },
                      //maxLength: 300,
                      controller: _TitleController,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.title),
                          labelText: 'Event Title',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 3))),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Date of Post';
                        }
                        return null;
                      },
                      controller: _dateController,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_today_rounded),
                          labelText: 'Date Event',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 3))),
                      onTap: () async {
                        TimeOfDay? pickedtime = await showTimePicker(
                            context: context, initialTime: TimeOfDay.now());
                        DateTime? pickeddate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101));
                        if (pickeddate != null && pickedtime != null) {
                          setState(() {
                            _dateController.text =
                                DateFormat('yyyy-MM-dd-HH:mm').format(DateTime(
                                    pickeddate.year,
                                    pickeddate.month,
                                    pickeddate.day,
                                    pickedtime.hour,
                                    pickedtime.minute));
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Description';
                        }
                        return null;
                      },
                      //maxLength: 300,
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.text_format),
                          labelText: 'Description',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 3))),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Location of Event';
                        }
                        return null;
                      },
                      //maxLength: 300,
                      controller: _placeController,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.place),
                          labelText: 'Location',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 3))),
                    ),
                    /* TextFormField(
                    controller: _phoneController,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.length < 2 ||
                          value.length > 2) {
                        return 'Please enter your countity';
                      }
                      return null;
                    },
                    //maxLength: 8,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "Phone",
                        icon: Icon(Icons.title),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3))),
                  ),*/
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
                              final String title = _TitleController.text;
                              final String date = _dateController.text;
                              final String place = _placeController.text;
                              final String descriptionpost =
                                  _descriptionController.text;
                              final String name = _nameController.text;
                              if (title != null) {
                                await _users.doc(documentSnapshot!.id).update({
                                  "Title_event": title,
                                  "date_event": date,
                                  "descriptionpost": descriptionpost,
                                  "place": place,
                                  "user": name,
                                });

                                _nameController.text = '';
                                _dateController.text = '';
                                _TitleController.text = '';
                                _descriptionController.text = '';
                                _placeController.text = '';

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
                      height: 130,
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> _delete(String productId) async {
    await _users.doc(productId).delete();

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

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );

  final user = FirebaseAuth.instance.currentUser!;

  Future uploadFile() async {
    final path = 'fiels/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Donwloaded link : $urlDownload');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.green,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Downloaded Complete 100/100"),
          Icon(Icons.done),
        ],
      ),
    ));
  }

  Future SelectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.green,
      content: Row(
        children: [
          Text(pickedFile!.name),
          Icon(Icons.done),
        ],
      ),
    ));
  }

  late Future<ListResult> futureFiles;
  final double borderRadius = 12;
  Map<int, double> downloadProgress = {};

  @override
  void initState() {
    super.initState();
    futureFiles = FirebaseStorage.instance.ref('/fiels').listAll();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        /*floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            _create();
          },
          child: const Icon(Icons.post_add),
        ),*/
        body: StreamBuilder(
            //future: _products.get(),
            stream: _users.snapshots(),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                            padding: EdgeInsets.all(12),
                                            child: Text(
                                              // user.email!,
                                              documentSnapshot['user'] + ' :',
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
                                              "Coming soon",
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
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Text(
                                    "Tilte : " +
                                        documentSnapshot['Title_event'],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      //fontSize: 15
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: Text(
                                    "Date : " + documentSnapshot['date_event'],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      //fontSize: 15
                                    ),
                                  ),
                                ),
                                /*Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 60, vertical: 10),
                                    child: Image.asset(
                                      'lib/images/conference.png',
                                      height: 100,
                                      width: 200,
                                    )),*/
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 60, vertical: 10),
                                  child: Text(
                                    documentSnapshot['descriptionpost'],
                                    style: TextStyle(
                                      height: 2,

                                      ///color: Colors.blue[800],
                                      fontWeight: FontWeight.bold,
                                      //fontSize: 15
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: Text(
                                    "Location : " + documentSnapshot['place'],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      //fontSize: 15
                                    ),
                                  ),
                                ),

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

  Future downloadFile(int index, Reference ref) async {
    final url = await ref.getDownloadURL();

    final tempDir = await getTemporaryDirectory();
    final path = '${tempDir.path}/${ref.name}';
    final response = await Dio().download(
      url,
      path,
      onReceiveProgress: (count, total) {
        double progress = count / total;
        setState(() {
          downloadProgress[index] = progress;
        });
      },
    );

    if (url.contains('.PNG')) {
      await GallerySaver.saveImage(path, toDcim: true);
    } else if (url.contains('.png')) {
      await GallerySaver.saveImage(path, toDcim: true);
    } else if (url.contains('.jpg')) {
      await GallerySaver.saveImage(path, toDcim: true);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Download ${ref.name} Done 100/100'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future deleteFile(String path) async {
    final ref = FirebaseStorage.instance.ref().child(path);
    try {
      await ref.delete();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${ref.name} successfully deleted"),
            Icon(Icons.done),
          ],
        ),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Error Deleting File"),
            Icon(Icons.priority_high),
          ],
        ),
      ));
    }
  }
}

/*
  @override
  Widget build(BuildContext) {
    return GridView.builder(
      itemCount: moneynews.length,
      padding: EdgeInsets.all(12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.04 / 1.35,
      ),
      itemBuilder: (context, index) {
        return MoneyTitle(
          moneyTitle: moneynews[index][0],
          moneyDate: moneynews[index][1],
          moneyColor: moneynews[index][2],
          imageName: moneynews[index][3],
          moneygold: moneynews[index][4],
          updown:moneynews[index][5],
        );
      },
    );
  }*/
