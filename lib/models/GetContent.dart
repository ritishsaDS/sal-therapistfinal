// To parse this JSON data, do
//
//     final getContentsResponseModel = getContentsResponseModelFromJson(jsonString);

import 'dart:convert';

GetContentsResponseModel getContentsResponseModelFromJson(String str) =>
    GetContentsResponseModel.fromJson(json.decode(str));

String getContentsResponseModelToJson(GetContentsResponseModel data) =>
    json.encode(data.toJson());

class GetContentsResponseModel {
  GetContentsResponseModel({
    this.articles,
    this.audios,
    this.likedContentIds,
    this.mediaUrl,
    this.meta,
    this.videos,
  });

  List<ContentsArticle> articles;
  List<ContentsArticle> audios;
  List<String> likedContentIds;
  String mediaUrl;
  Meta meta;
  List<ContentsArticle> videos;

  factory GetContentsResponseModel.fromJson(Map<String, dynamic> json) =>
      GetContentsResponseModel(
        articles: List<ContentsArticle>.from(
            json["articles"].map((x) => ContentsArticle.fromJson(x))),
        audios: List<ContentsArticle>.from(
            json["audios"].map((x) => ContentsArticle.fromJson(x))),
        likedContentIds:
            List<String>.from(json["liked_content_ids"].map((x) => x)),
        mediaUrl: json["media_url"],
        meta: Meta.fromJson(json["meta"]),
        videos: List<ContentsArticle>.from(
            json["videos"].map((x) => ContentsArticle.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
        "audios": List<dynamic>.from(audios.map((x) => x.toJson())),
        "liked_content_ids": List<dynamic>.from(likedContentIds.map((x) => x)),
        "media_url": mediaUrl,
        "meta": meta.toJson(),
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
      };
}

class ContentsArticle {
  ContentsArticle({
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

  factory ContentsArticle.fromJson(Map<String, dynamic> json) =>
      ContentsArticle(
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
