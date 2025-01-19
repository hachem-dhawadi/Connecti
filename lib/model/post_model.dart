List<PostModel> postFromJson(dynamic str) =>
    List<PostModel>.from((str).map((x) => PostModel.fromJson(x)));

class PostModel {
  late String? id;
  late String? postTitle;
  late String? postDescription;
  late String? postImage;
  late String? user;
  late String? user_id;

  PostModel({
    this.id,
    this.postTitle,
    this.postDescription,
    this.postImage,
    this.user,
    this.user_id,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    postTitle = json["postTitle"];
    postDescription = json["postDescription"];
    postImage = json["postImage"];
    user = json["user"];
    user_id = json["user_id"];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data["_id"] = id;
    _data["postTitle"] = postTitle;
    _data["postDescription"] = postDescription;
    _data["postImage"] = postImage;
    _data["user"] = postImage;
    _data["user_id"] = user_id;

    return _data;
  }
}

/*List<PostModel> postFromJson(dynamic str) =>
    List<PostModel>.from((str).map((x) => PostModel.fromJson(x)));

class PostModel {
  late String? id;
  late String? title;
  late String? description;
  late String? userName;
   late String? imagePath;
  late String? ImageName;
 

  PostModel({
    this.id,
    this.title,
    this.description,
    this.imagePath,
    this.userName,
    this.ImageName,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    title = json["title"];
    description = json["description"];
    imagePath = json["imagePath"];
    userName = json["userName"];
    ImageName = json["ImageName"];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data["_id"] = id;
    _data["title"] = title!;
    _data["description"] = description!;
    _data["imagePath"] = imagePath;
    _data["userName"] = userName;
    _data["ImageName"] = ImageName;

    return _data;
  }
}*/
