// To parse this JSON data, do
//
//     final getAssessmentsResponseModel = getAssessmentsResponseModelFromJson(jsonString);

import 'dart:convert';

GetAssessmentsResponseModel getAssessmentsResponseModelFromJson(String str) =>
    GetAssessmentsResponseModel.fromJson(json.decode(str));

String getAssessmentsResponseModelToJson(GetAssessmentsResponseModel data) =>
    json.encode(data.toJson());

class GetAssessmentsResponseModel {
  GetAssessmentsResponseModel({
    this.assessments,
    this.mediaUrl,
    this.meta,
  });

  List<Assessment> assessments;
  String mediaUrl;
  Meta meta;

  factory GetAssessmentsResponseModel.fromJson(Map<String, dynamic> json) =>
      GetAssessmentsResponseModel(
        assessments: List<Assessment>.from(
            json["assessments"].map((x) => Assessment.fromJson(x))),
        mediaUrl: json["media_url"],
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "assessments": List<dynamic>.from(assessments.map((x) => x.toJson())),
        "media_url": mediaUrl,
        "meta": meta.toJson(),
      };
}

class Assessment {
  Assessment({
    this.assessmentId,
    this.createdAt,
    this.createdBy,
    this.id,
    this.instruction,
    this.modifiedAt,
    this.modifiedBy,
    this.order,
    this.photo,
    this.status,
    this.subtitle,
    this.title,
    this.type,
  });

  String assessmentId;
  String createdAt;
  String createdBy;
  String id;
  String instruction;
  String modifiedAt;
  String modifiedBy;
  String order;
  String photo;
  String status;
  String subtitle;
  String title;
  String type;

  factory Assessment.fromJson(Map<String, dynamic> json) => Assessment(
        assessmentId: json["assessment_id"],
        createdAt: json["created_at"],
        createdBy: json["created_by"],
        id: json["id"],
        instruction: json["instruction"],
        modifiedAt: json["modified_at"],
        modifiedBy: json["modified_by"],
        order: json["order"],
        photo: json["photo"],
        status: json["status"],
        subtitle: json["subtitle"],
        title: json["title"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "assessment_id": assessmentId,
        "created_at": createdAt,
        "created_by": createdBy,
        "id": id,
        "instruction": instruction,
        "modified_at": modifiedAt,
        "modified_by": modifiedBy,
        "order": order,
        "photo": photo,
        "status": status,
        "subtitle": subtitle,
        "title": title,
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
