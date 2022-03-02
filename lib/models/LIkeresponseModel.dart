// To parse this JSON data, do
//
//     final likedExploreListResponseModel = likedExploreListResponseModelFromJson(jsonString);

import 'dart:convert';

LikedExploreListResponseModel likedExploreListResponseModelFromJson(
        String str) =>
    LikedExploreListResponseModel.fromJson(json.decode(str));

String likedExploreListResponseModelToJson(
        LikedExploreListResponseModel data) =>
    json.encode(data.toJson());

class LikedExploreListResponseModel {
  LikedExploreListResponseModel({
    this.articles,
    this.audios,
    this.mediaUrl,
    this.meta,
    this.videos,
  });

  List<Article> articles;
  List<Article> audios;
  String mediaUrl;
  Meta meta;
  List<Article> videos;

  factory LikedExploreListResponseModel.fromJson(Map<String, dynamic> json) =>
      LikedExploreListResponseModel(
        articles: List<Article>.from(
            json["articles"].map((x) => Article.fromJson(x))),
        audios:
            List<Article>.from(json["audios"].map((x) => Article.fromJson(x))),
        mediaUrl: json["media_url"],
        meta: Meta.fromJson(json["meta"]),
        videos:
            List<Article>.from(json["videos"].map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
        "audios": List<dynamic>.from(audios.map((x) => x.toJson())),
        "media_url": mediaUrl,
        "meta": meta.toJson(),
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
      };
}

class Article {
  Article({
    this.backgroundPhoto,
    this.categoryId,
    this.content,
    this.contentId,
    this.counsellorId,
    this.createdAt,
    this.createdBy,
    this.description,
    this.id,
    this.modifiedAt,
    this.modifiedBy,
    this.moodId,
    this.photo,
    this.redirection,
    this.status,
    this.title,
    this.training,
    this.type,
  });

  String backgroundPhoto;
  String categoryId;
  String content;
  String contentId;
  String counsellorId;
  DateTime createdAt;
  String createdBy;
  String description;
  String id;
  String modifiedAt;
  String modifiedBy;
  String moodId;
  String photo;
  String redirection;
  String status;
  String title;
  String training;
  String type;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        backgroundPhoto: json["background_photo"],
        categoryId: json["category_id"],
        content: json["content"],
        contentId: json["content_id"],
        counsellorId: json["counsellor_id"],
        createdAt: DateTime.parse(json["created_at"]),
        createdBy: json["created_by"],
        description: json["description"],
        id: json["id"],
        modifiedAt: json["modified_at"],
        modifiedBy: json["modified_by"],
        moodId: json["mood_id"],
        photo: json["photo"],
        redirection: json["redirection"],
        status: json["status"],
        title: json["title"],
        training: json["training"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "background_photo": backgroundPhoto,
        "category_id": categoryId,
        "content": content,
        "content_id": contentId,
        "counsellor_id": counsellorId,
        "created_at": createdAt.toIso8601String(),
        "created_by": createdBy,
        "description": description,
        "id": id,
        "modified_at": modifiedAt,
        "modified_by": modifiedBy,
        "mood_id": moodId,
        "photo": photo,
        "redirection": redirection,
        "status": status,
        "title": title,
        "training": training,
        "type": type,
      };
}

class Meta {
  Meta({
    this.message,
    this.messageType,
    this.status,
  });

  String message;
  String messageType;
  String status;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        message: json["message"],
        messageType: json["message_type"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "message_type": messageType,
        "status": status,
      };
}
