import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page/model/post_model.dart';

class PostItem extends StatelessWidget {
  PostItem({Key? key, this.model, this.onDelete}) : super(key: key);
  final user = FirebaseAuth.instance.currentUser!;
  final PostModel? model;
  final Function? onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(50)),
        child: postWidget(context),
      ),
    );
  }

  Widget postWidget(context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 240, 238, 238),
            borderRadius: BorderRadius.circular(10)),
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
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('lib/images/men3.jpg'),
                            fit: BoxFit.fill),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          model!.user!,
                          //user.displayName!,
                          style: TextStyle(
                              color: Colors.black,
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
                          color: Color.fromARGB(255, 218, 218, 218),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                        ),
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(bottom: 14),
                        child: Text(
                          "01/10/2023",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 11),
                        )),
                  ],
                ),
              ],
            ),
            Container(
              margin:
                  EdgeInsets.only(top: 10, bottom: 10, right: 120, left: 20),
              child: Text(
                "Title : " + model!.postTitle!,
                //"Title : " + model!.postTitle!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                //top: 10,
                bottom: 20,
                left: 20,
                right: 10,
              ),
              child: Text(
                //"Description : " + model!.postDescription!,
                "Description : " + model!.postDescription!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 210,
              height: 210,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: /*DecorationImage(
                    image: NetworkImage((model!.postImage == null ||
                            model!.postImage == "")
                        ? 'https://cdn-icons-png.flaticon.com/512/4131/4131677.png'
                        : model!.postImage!),
                    fit: BoxFit.fill),*/
                    DecorationImage(
                        image: NetworkImage((model!.postImage == null ||
                                model!.postImage == "")
                            ? 'https://cdn-icons-png.flaticon.com/512/4131/4131677.png'
                            : model!.postImage!),
                        fit: BoxFit.fill),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10, bottom: 10),
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          Icons.thumb_up,
                          size: 20,
                        ),
                        label: Text("like"),
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(fontSize: 12),
                          backgroundColor: Colors.blueGrey,
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10, bottom: 10),
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          Icons.chat_bubble,
                          size: 20,
                        ),
                        label: Text("comment"),
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(fontSize: 12),
                          backgroundColor: Colors.blueGrey,
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 45),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                    'postaddedit',
                                    arguments: {'model': model},
                                  );
                                },
                                icon: Icon(Icons.edit))),
                        IconButton(
                            onPressed: () => showDialog<String>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    title: const Text('Delete Post'),
                                    content:
                                        const Text('Are you sure to Delete ?'),
                                    actions: <Widget>[
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          onDelete!(model);
                                          Navigator.of(context).pop();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.green,
                                        ),
                                        icon: Icon(Icons.delete_forever),
                                        label: Text(
                                          "Delete",
                                          style: TextStyle(fontSize: 18),
                                        ),
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
                                ),
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      ],
                    ),
                  ],
                )
              ],
            )
            //love icon + add button
          ],
        ),
      ),
    );
  }
}
