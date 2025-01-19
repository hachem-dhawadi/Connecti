import 'package:flutter/material.dart';
import 'package:login_page/model/api_service.dart';
import 'package:login_page/model/post_item.dart';
import 'package:login_page/model/post_model.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class PostList extends StatefulWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  List<PostModel> posts = List<PostModel>.empty(growable: true);
  final double borderRadius = 12;
  
  bool isAPICallProcess=false;
  @override
  void initState() {
    super.initState();

    /*posts.add(PostModel(
      id: "1",
      postTitle: "wajdi",
      postDescription: "hello esmi wajdi amdouni",
      postImage: '',
    ));

    posts.add(PostModel(
      id: "2",
      postTitle: "hachem",
      postDescription: "hello esmi hachem dhawadi",
      postImage: 'lib/images/men3.jpg',
    ));*/
  }

  Widget postList(posts) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SingleChildScrollView(
                  padding: EdgeInsets.only(top: 20),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return PostItem(
                        model: posts[index],
                        onDelete: (PostModel model) {
                          setState(() {
                            isAPICallProcess = true;
                          });
                          APIService.deletePost(model.id).then((response) {
                            setState(() {
                              isAPICallProcess = false;
                            });
                          });
                        },
                      );
                    },
                  ))
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueGrey,
          onPressed: () {
            Navigator.pushNamed(context, "postaddedit");
          },
          child: const Icon(Icons.post_add),
        ),
        body: ProgressHUD(
          child: laodPosts(),
          inAsyncCall: isAPICallProcess,
          opacity: .3,
          key: UniqueKey(),
        ));
  }

  Widget laodPosts() {
    return FutureBuilder(
      future: APIService.getPosts(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<PostModel>?> model,
      ) {
        if (model.hasData) {
          return postList(model.data);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
