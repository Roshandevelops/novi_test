class FeedModel {
  final int? id;
  final String? description;
  final String? image;
  final String? video;
  final List<int>? likes;
  final List<dynamic>? dislikes;
  final List<dynamic>? bookmarks;
  final List<dynamic>? hide;
  final DateTime? createdAt;
  final bool? follow;
  final User? user;

  FeedModel({
    this.id,
    this.description,
    this.image,
    this.video,
    this.likes,
    this.dislikes,
    this.bookmarks,
    this.hide,
    this.createdAt,
    this.follow,
    this.user,
  });

  factory FeedModel.fromJson(Map<String, dynamic> json) => FeedModel(
        id: json["id"],
        description: json["description"],
        image: json["image"],
        video: json["video"],
        likes: json["likes"] == null
            ? []
            : List<int>.from(json["likes"]!.map((x) => x)),
        dislikes: json["dislikes"] == null
            ? []
            : List<dynamic>.from(json["dislikes"]!.map((x) => x)),
        bookmarks: json["bookmarks"] == null
            ? []
            : List<dynamic>.from(json["bookmarks"]!.map((x) => x)),
        hide: json["hide"] == null
            ? []
            : List<dynamic>.from(json["hide"]!.map((x) => x)),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        follow: json["follow"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "image": image,
        "video": video,
        "likes": likes == null ? [] : List<dynamic>.from(likes!.map((x) => x)),
        "dislikes":
            dislikes == null ? [] : List<dynamic>.from(dislikes!.map((x) => x)),
        "bookmarks": bookmarks == null
            ? []
            : List<dynamic>.from(bookmarks!.map((x) => x)),
        "hide": hide == null ? [] : List<dynamic>.from(hide!.map((x) => x)),
        "created_at": createdAt?.toIso8601String(),
        "follow": follow,
        "user": user?.toJson(),
      };
}

class User {
  final int? id;
  final String? name;
  final dynamic image;

  User({
    this.id,
    this.name,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}
