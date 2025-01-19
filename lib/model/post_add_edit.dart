import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_page/model/api_service.dart';
import 'package:login_page/model/config.dart';
import 'package:login_page/model/post_item.dart';
import 'package:login_page/model/post_model.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

final user = FirebaseAuth.instance.currentUser!;

class PostAddEdit extends StatefulWidget {
  const PostAddEdit({Key? key}) : super(key: key);

  @override
  _PostAddEditState createState() => _PostAddEditState();
}

class _PostAddEditState extends State<PostAddEdit> {
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isAPICallProcess = false;
  PostModel? postModel;
  bool isEditMode = false;
  bool isImageSelected = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            elevation: 0,
            leading: Padding(
              padding: EdgeInsets.only(left: 24.0, right: 55),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.blueGrey[800],
                  size: 30,
                ),
                onPressed: () {
                  //Navigator.pushNamed(context, "accueil");
                },
              ),
            ),
            title: Text(
              "      Add New Post",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 24.0),
                child: IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.blueGrey[800],
                    size: 30,
                  ),
                  onPressed: () {
                    //Navigator.pushNamed(context, "accueil");
                  },
                ),
              )
            ],
          ),
          body: ProgressHUD(
            child: Form(
              key: globalKey,
              child: postForm(),
            ),
            inAsyncCall: isAPICallProcess,
            opacity: .3,
            key: UniqueKey(),
          )),
    );
  }

  @override
  void initState() {
    super.initState();
    postModel = PostModel();
    Future.delayed(Duration.zero, () {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
        postModel = arguments["model"];
        isEditMode = true;
        setState(() {});
      }
    });
  }

  Widget postForm() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 0, top: 30),
            child: FormHelper.inputFieldWidget(
              context,
              "postTitle",
              "PostTitle",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Post Title cant be empty';
                }
                return null;
              },
              (onSavedVal) {
                //hachem
                //postModel!.postTitle = onSavedVal;
                postModel!.postTitle = onSavedVal;
              },
              //hachem
              //initialValue: postModel!.postTitle ?? "",
              initialValue: postModel!.postTitle ?? "",
              //hintFontSize: 17,
              //fontSize: 30,
              borderColor: Colors.black,
              borderFocusColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(.20),
              borderRadius: 10,
              showPrefixIcon: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 20),
            child: FormHelper.inputFieldWidget(
              context,
              "postDescription",
              "PostDescription",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Post Description cant be empty';
                }
                return null;
              },
              (onSavedVal) {
                //hachem
                //postModel!.postDescription = onSavedVal;
                //postModel!.user = user.displayName;
                postModel!.postDescription = onSavedVal;
              },
              //hachem
              //initialValue: postModel!.postDescription ?? "",
              initialValue: postModel!.postDescription ?? "",
              //hintFontSize: 17,
              //xfontSize: 30,
              borderColor: Colors.black,
              borderFocusColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(.20),
              borderRadius: 10,
              showPrefixIcon: false,
              //suffixIcon: const Icon(Icons.percent),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          //hachem
          /*picPicker(isImageSelected, postModel!.postImage ?? "", (file) {
            setState(() {
              postModel!.postImage = file.path;
              isImageSelected = true;
            });
          }),*/
                    picPicker(isImageSelected, postModel!.postImage ?? "", (file) {
            setState(() {
              postModel!.postImage = file.path;
              isImageSelected = true;
            });
          }),
          const SizedBox(
            height: 20,
          ),
          Center(
              child: FormHelper.submitButton("save", () {
            if (ValidateAndSave()) {
              setState(() {
                isAPICallProcess = true;
                APIService.savePost(postModel!, isEditMode, isImageSelected)
                    .then((response) {
                  setState(() {
                    isAPICallProcess = false;
                  });
                  if (response) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'accueil', (route) => false);
                  } else {
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'accueil', (route) => false);
                    /*FormHelper.showSimpleAlertDialog(
                    context,
                    Config.appName,
                    "Error Occure",
                    "ok",
                    () {
                      Navigator.of(context).pop();
                    },
                  );*/
                  }
                });
              });
            }
          },
                  btnColor: Colors.blueGrey,
                  borderColor: Colors.blueGrey,
                  borderRadius: 10)),
        ],
      ),
    );
  }

  bool ValidateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  static Widget picPicker(
    bool isFileSelected,
    //bool isEditMode,
    String fileName,
    Function onFilePicked,
  ) {
    Future<XFile?> _imageFile;
    ImagePicker _picker = ImagePicker();
    return Column(
      children: [
        fileName.isNotEmpty
            ? isFileSelected
                ? Image.file(
                    File(fileName),
                    height: 200,
                    width: 200,
                  )
                : SizedBox(
                    child: Image.network(
                      fileName,
                      width: 200,
                      height: 200,
                      fit: BoxFit.scaleDown,
                    ),
                  )
            : SizedBox(
                child: Image.network(
                  'https://cdn-icons-png.flaticon.com/512/1829/1829586.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.scaleDown,
                ),
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 35,
              width: 35,
              child: IconButton(
                padding: const EdgeInsets.all(0),
                icon: const Icon(Icons.image),
                iconSize: 35,
                onPressed: () {
                  _imageFile = _picker.pickImage(source: ImageSource.gallery);
                  _imageFile.then((file) async {
                    onFilePicked(file);
                  });
                },
              ),
            ),
            SizedBox(
              height: 35,
              width: 35,
              child: IconButton(
                padding: const EdgeInsets.all(0),
                icon: const Icon(Icons.camera),
                iconSize: 35,
                onPressed: () {
                  _imageFile = _picker.pickImage(source: ImageSource.camera);
                  _imageFile.then((file) async {
                    onFilePicked(file);
                  });
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
