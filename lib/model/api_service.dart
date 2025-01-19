import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:login_page/model/config.dart';
import 'package:login_page/model/post_model.dart';

final user = FirebaseAuth.instance.currentUser!;

class APIService {
  static var client = http.Client();
  var dio = Dio();
  //hachem
  static Future<List<PostModel>?> getPosts() async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http(Config.apiURL, Config.postURL);

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return postFromJson(data["data"]);

    } else {
      return null;
    }
  }
  /*static Future<List<PostModel>?> getPosts() async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http(Config.apiURL, Config.postURL);

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      //return postFromJson(data["data"]);
      return postFromJson(data);
    } else {
      return null;
    }
  }*/

  static Future<bool> savePost(
    PostModel model,
    bool isEditMode,
    bool isFileSelected,
  ) async {
    //model.postTitle = "hachem";
    //model.postDescription = "tata";
    var postURL = Config.postURL;
    if (isEditMode) {
      postURL = postURL + "/" + model.id.toString();
    }

    var url = Uri.http(Config.apiURL, postURL);

    //var requestMethod = isEditMode ? "PUT" : "POST";
    var requestMethod = isEditMode ? "PUT" : "POST";
    ///////////////////////////////////////////////////// hachem
    var request = http.MultipartRequest(requestMethod, url);
    request.fields["postTitle"] = model.postTitle!;
    request.fields["postDescription"] = model.postDescription!;
    request.fields["user"] = user.email!;
    request.fields["user_id"] = user.uid;
    //////////////////////////////////////////////////////
    /*var request = http.MultipartRequest(requestMethod, url);
    request.fields["title"] = model.title!;
    request.fields["description"] = model.description!;
    request.fields["userName"] = user.email!;*/
    //request.fields["user_id"] = user.uid;

    //HACHEM
    if (model.postImage != null && isFileSelected) {
      http.MultipartFile multipartFile =
          await http.MultipartFile.fromPath('postImage', model.postImage!);
      request.files.add(multipartFile);
    }
    /*if (model.ImageName != null && isFileSelected) {
      http.MultipartFile multipartFile =
          await http.MultipartFile.fromPath('ImageName', model.ImageName!);
      request.files.add(multipartFile);
    }*/

    var response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deletePost(postId) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http(Config.apiURL, Config.postURL + "/" + postId);

    var response = await client.delete(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
