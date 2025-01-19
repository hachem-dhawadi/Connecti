import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class AdminFile extends StatefulWidget {
  const AdminFile({Key? key}) : super(key: key);
  @override
  _AdminFileState createState() => _AdminFileState();
}

class _AdminFileState extends State<AdminFile> {
  final user = FirebaseAuth.instance.currentUser!;
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                title: Text('Upload'),
                content: Text("Choose File From you Storge !!"),
                actions: <Widget>[
                  ElevatedButton.icon(
                    onPressed: () {
                      SelectFile();
                      //Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    label: Text(
                      "Select  File",
                      style: TextStyle(fontSize: 18),
                    ),
                    icon: Icon(Icons.attach_file),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      uploadFile();
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                    ),
                    label: Text(
                      "Uplaod",
                      style: TextStyle(fontSize: 18),
                    ),
                    icon: Icon(Icons.cloud_upload),
                  ),
                ],
              ),
            );
          },
          child: const Icon(Icons.publish),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              futureFiles = FirebaseStorage.instance.ref('/fiels').listAll();
            });
          },
          child: FutureBuilder<ListResult>(
            future: futureFiles,
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                final files = snapshot.data!.items;
                return GridView.builder(
                  itemCount: files.length,
                  padding: EdgeInsets.all(12),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.04 / 1.6,
                  ),
                  itemBuilder: (context, index) {
                    final file = files[index];
                    double? progress = downloadProgress[index];
                    //final fileType = await file.getMetadata().then((meta) => meta.contentType);
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 240, 238, 238),
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                        child: Column(
                          children: [
                            // price
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        padding:
                                            EdgeInsets.only(top: 4, left: 4),
                                        child: Icon(
                                          Icons.download,
                                          color: Colors.black,
                                        )),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 240, 238, 238),
                                      ),
                                      child: FutureBuilder(
                                        future: file.getMetadata(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(
                                              snapshot.data?.contentType ??
                                                  "Unknown",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            );
                                          } else if (snapshot.hasError) {
                                            return Text(
                                                "Error: ${snapshot.error}");
                                          }
                                          return CircularProgressIndicator();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            // donut picture
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 36.0, vertical: 14),
                              child: Image.asset(
                                "lib/images/d3.png",
                                height: 80,
                              ),
                            ),

                            // donut flavor
                            Text(
                              file.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),

                            const SizedBox(height: 10),

                            // love icon + add button
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 42, vertical: 1),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // plus button
                                  Container(
                                      margin: EdgeInsets.only(
                                        left: 18,
                                      ),
                                      child: InkWell(
                                        child: Text(
                                          'Dowload',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue[600],
                                              fontSize: 15,
                                              decoration:
                                                  TextDecoration.underline),
                                        ),
                                        onTap: () {
                                          downloadFile(index, file);
                                          //deleteFile(files[index].fullPath);
                                        },
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 42, vertical: 1),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // plus button
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 28,
                                    ),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        //if(user.email !=)
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            title: Text('Upload'),
                                            content: Text(
                                                'Are you sure you want to Delete ' +
                                                    file.name),
                                            actions: <Widget>[
                                              ElevatedButton.icon(
                                                onPressed: () {
                                                  deleteFile(
                                                      files[index].fullPath);
                                                  Navigator.of(context).pop();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.green,
                                                ),
                                                label: Text(
                                                  "Delete",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                icon: Icon(Icons.done),
                                              ),
                                              ElevatedButton.icon(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.red,
                                                ),
                                                label: Text(
                                                  "Cancel ",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                icon: Icon(Icons.clear),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 18, right: 18),
                              child: progress != null
                                  ? LinearProgressIndicator(
                                      value: progress,
                                      backgroundColor: Colors.green,
                                      minHeight: 3)
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("Error"),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
          ),
        ),
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

    if (url.contains('.mp4')) {
      await GallerySaver.saveVideo(path, toDcim: true);
    } else if (url.contains('.PNG')) {
      await GallerySaver.saveImage(path, toDcim: true);
    } else if (url.contains('.png')) {
      await GallerySaver.saveImage(path, toDcim: true);
    } else if (url.contains('.jpg')) {
      await GallerySaver.saveImage(path, toDcim: true);
    }
    if (url.contains('.pdf')) {
      final pdfPath =
          '${(await getApplicationDocumentsDirectory()).path}/${ref.name}';
      File pdfFile = File(pdfPath);
      pdfFile.writeAsBytesSync(response.data.bytes);
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

                                ElevatedButton(
                                  onPressed: () {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        title: Text('Delete'),
                                        content: Text(
                                            "Are you sure you want to delete this file ? "),
                                        actions: <Widget>[
                                          ElevatedButton.icon(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.grey,
                                            ),
                                            label: Text(
                                              "Cancel",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            icon: Icon(Icons.cancel),
                                          ),
                                          ElevatedButton.icon(
                                            onPressed: () {
                                              deleteFile(files[index].fullPath);
                                              Navigator.of(context).pop();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.red,
                                            ),
                                            label: Text(
                                              "Delete",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            icon: Icon(Icons.delete),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: Text("Delete"),
                                ),

*/



/*

  List companynews = [
    // [ donutFlavor, donutPrice, donutColor, imageName ]
    [
      "Pdf",
      "lib/images/pdf.png",
      "06/09/2022",
    ],
    [
      "Pdf",
      "lib/images/mp4.png",
      "06/09/2022",
    ],
    [
      "Pdf",
      "lib/images/mp3.png",
      "06/09/2022",
    ],
    [
      "Pdf",
      "lib/images/photo.png",
      "06/09/2022",
    ],
    [
      "Pdf",
      "lib/images/pdf.png",
      "06/09/2022",
    ],
    [
      "Pdf",
      "lib/images/pdf.png",
      "06/09/2022",
    ],
  ];

  @override
  Widget build(BuildContext) {
    return GridView.builder(
      itemCount: companynews.length,
      padding: EdgeInsets.all(12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.04 / 1.12,
      ),
      itemBuilder: (context, index) {
        return CompanyTitle(
          companyTitle: companynews[index][0],
          //companyColor: companynews[index][1],
          imageName: companynews[index][1],
          companyDate: companynews[index][2],
          /*moneyTitle: filesnews[index][0],
          moneyDate: filesnews[index][1],
          moneyColor: filesnews[index][2],
          imageName: filesnews[index][3],
          moneygold: filesnews[index][4],
          updown:filesnews[index][5],*/
        );
      },
    );
  }

*/

            /*showModalBottomSheet(
                backgroundColor: Colors.white,
                isScrollControlled: true,
                context: context,
                builder: (BuildContext ctx) {
                  return SizedBox(
                    height: 200,
                    child: Container(
                      margin: EdgeInsets.only(top: 20, left: 25, right: 25),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              if (pickedFile != null)
                                Text(
                                  pickedFile!.name,
                                  style: TextStyle(fontSize: 18),
                                ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  SelectFile();
                                  //Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                ),
                                label: Text(
                                  "Select  File",
                                  style: TextStyle(fontSize: 18),
                                ),
                                icon: Icon(Icons.attach_file),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                ),
                                label: Text(
                                  "Uplaod",
                                  style: TextStyle(fontSize: 18),
                                ),
                                icon: Icon(Icons.cloud_upload),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                });*/