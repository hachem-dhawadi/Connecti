import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/material/input_decorator.dart';
import 'package:intl/intl.dart';
import 'package:validators/validators.dart';
import 'package:email_validator/email_validator.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List searchResult = [];
  String name = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final CollectionReference _products =
      FirebaseFirestore.instance.collection('products');

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cinController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    _nameController.text = '';
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
                    child: Icon(Icons.badge),
                  ),
                  Center(
                      child: Text(
                    "Creating New User",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 18,
                    ),
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Name';
                      }
                      return null;
                    },
                    maxLength: 20,
                    controller: _nameController,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.title),
                        labelText: 'Name',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3))),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your 8 number Cin';
                      }
                      return null;
                    },
                    maxLength: 8,
                    keyboardType: TextInputType.number,
                    controller: _cinController,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.format_list_numbered),
                        labelText: 'Cin',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3))),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
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
                    maxLength: 30,
                    controller: _emailController,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.email),
                        labelText: 'Email',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3))),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 2) {
                        return 'Please enter your Age';
                      }
                      return null;
                    },
                    maxLength: 2,
                    keyboardType: TextInputType.number,
                    controller: _ageController,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.pin),
                        labelText: 'Age',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3))),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 8) {
                        return 'Please enter your Phone number';
                      }
                      return null;
                    },
                    maxLength: 8,
                    keyboardType: TextInputType.number,
                    controller: _phoneController,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.phone),
                        labelText: 'Phone',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3))),
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
                  Row(
                    children: [
                      SizedBox(
                        width: 80,
                      ),
                      ElevatedButton.icon(
                        icon: Icon(Icons.how_to_reg),
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
                            final String email = _emailController.text;
                            final String cin = _cinController.text;
                            final String age = _ageController.text;
                            final String phone = _phoneController.text;
                            final String date = _dateController.text;
                            if (cin != null) {
                              _products.add({
                                "name": name,
                                "cin": cin,
                                "email": email,
                                "age": age,
                                "phone": phone,
                                "date": date
                              });

                              _nameController.text = '';
                              _cinController.text = '';
                              _emailController.text = '';
                              _ageController.text = '';
                              _phoneController.text = '';
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
                    height: 150,
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['name'];
      _emailController.text = documentSnapshot['email'];
      _cinController.text = documentSnapshot['cin'].toString();
      _ageController.text = documentSnapshot['age'].toString();
      _phoneController.text = documentSnapshot['phone'].toString();
      _dateController.text = documentSnapshot['date'].toString();
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
                      "Updating User",
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 18,
                      ),
                    )),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Name';
                        }
                        return null;
                      },
                      maxLength: 20,
                      controller: _nameController,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.title),
                          labelText: 'Name',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 3))),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your 8 number Cin';
                        }
                        return null;
                      },
                      maxLength: 8,
                      keyboardType: TextInputType.number,
                      controller: _cinController,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.format_list_numbered),
                          labelText: 'Cin',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 3))),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
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
                      maxLength: 30,
                      controller: _emailController,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.email),
                          labelText: 'Email',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 3))),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 2) {
                          return 'Please enter your Age';
                        }
                        return null;
                      },
                      maxLength: 2,
                      keyboardType: TextInputType.number,
                      controller: _ageController,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.pin),
                          labelText: 'Age',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 3))),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 8) {
                          return 'Please enter your Phone number';
                        }
                        return null;
                      },
                      maxLength: 8,
                      keyboardType: TextInputType.number,
                      controller: _phoneController,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.phone),
                          labelText: 'Phone',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 3))),
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
                              final String name = _nameController.text;
                              final String email = _emailController.text;
                              final String cin = _cinController.text;
                              final String age = _ageController.text;
                              final String phone = _phoneController.text;
                              final String date = _dateController.text;
                              if (cin != null) {
                                await _products
                                    .doc(documentSnapshot!.id)
                                    .update({
                                  "name": name,
                                  "cin": cin,
                                  "email": email,
                                  "age": age,
                                  "phone": phone,
                                  "date": date
                                });
                                _nameController.text = '';
                                _cinController.text = '';
                                _emailController.text = '';
                                _ageController.text = '';
                                _phoneController.text = '';
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
    await _products.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Row(
        children: [
          Text('User have been successfully deleted  '),
          Icon(Icons.done),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed("accueil");
          },
        ),
        title: Text("List Candidats"),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.person_add,
        ),
        onPressed: () {
          _create();
          //Navigator.of(context).pushNamed("addnotes");
        },
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              controller: _dateController,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.person_search),
                labelText: 'search for user',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(30.0)),
              ),
              onChanged: (val) {
                setState(() {
                  name = val;
                });
              },
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: StreamBuilder(
                //future: _products.get(),
                stream: _products.snapshots(),
                builder: (context, AsyncSnapshot streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.builder(
                          itemCount: streamSnapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot documentSnapshot =
                                streamSnapshot.data!.docs[index];
                            return Card(
                              color: Color.fromARGB(255, 226, 226, 226),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      //height: 100,
                                      child: //Icon(Icons.person),
                                          //Image.asset("lib/images/kk.jpg")
                                          CircleAvatar(
                                        //backgroundColor: Color.fromARGB(255, 78, 42, 42),
                                        radius: 50.0,
                                        backgroundImage:
                                            AssetImage("lib/images/hachem.jpg"),
                                        /*child: ClipRRect(
                            child: Image.asset("lib/images/men3.jpg"),
                            borderRadius: BorderRadius.circular(80.0),
                          ),*/
                                      ),
                                    ),
                                    /**/
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: ListTile(
                                      //leading: Icon(Icons.person,size: 45,color: Color.fromARGB(255, 69, 70, 80),),
                                      //contentPadding: EdgeInsets.symmetric(vertical: 60.0),
                                      title: Text(
                                        documentSnapshot['name'],
                                      ),
                                      subtitle: Text(
                                        documentSnapshot['cin'].toString(),
                                      ),

                                      trailing: IconButton(
                                        onPressed: () {
                                          _update(documentSnapshot);
                                        },
                                        icon: const Icon(Icons.edit),
                                        color: Colors.black,
                                      ),
                                      onTap: () {
                                        _update();
                                        Navigator.of(context)
                                            .pushReplacementNamed("details");
                                      },
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () => showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              title: const Text('Delete User'),
                                              content: const Text(
                                                  'Are you sure to Delete ?'),
                                              actions: <Widget>[
                                                ElevatedButton.icon(
                                                  onPressed: () {
                                                    _delete(
                                                        documentSnapshot.id);
                                                    Navigator.of(context).pop();
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: Colors.green,
                                                  ),
                                                  icon:
                                                      Icon(Icons.person_remove),
                                                  label: Text(
                                                    "Delete",
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                                ElevatedButton.icon(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: Colors.red,
                                                  ),
                                                  icon: Icon(Icons.close),
                                                  label: Text(
                                                    "Cancel",
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ))
                                  //IconButton(onPressed: (){}, icon: Icon(Icons.delete,color: Colors.red,)),
                                ],
                              ),
                            );
                          }),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ],
      ),
    );
  }

  /*void searchFromFirebase(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('products')
        .where(
          'cin',
          isEqualTo: query,
        )
        .get();
    setState(() {
      searchResult = result.docs.map((e) => e.data()).toList();
    });
  }*/
}

/*class ListNotes extends StatelessWidget {
  final notes;
  ListNotes({this.notes});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Image.asset(
              "lib/images/img_login.jpg",
              fit: BoxFit.fill,
              height: 100,
            ),
          ),
          Expanded(
            flex: 3,
            child: ListTile(
              title: Text("Name"),
              subtitle: Text("${notes['note']}"),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.edit),
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }


ListTile(
                          title: Text(documentSnapshot['name']),
                          subtitle: Text(documentSnapshot['cin'].toString()),
                        )

}*/
