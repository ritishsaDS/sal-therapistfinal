// To parse this JSON data, do
//
//     final getAssessmentsResultResponseModel = getAssessmentsResultResponseModelFromJson(jsonString);

import 'dart:convert';

GetAssessmentsResultResponseModel getAssessmentsResultResponseModelFromJson(
        String str) =>
    GetAssessmentsResultResponseModel.fromJson(json.decode(str));

String getAssessmentsResultResponseModelToJson(
        GetAssessmentsResultResponseModel data) =>
    json.encode(data.toJson());

class GetAssessmentsResultResponseModel {
  GetAssessmentsResultResponseModel({
    this.assessmentResults,
    this.meta,
  });

  List<AssessmentResult> assessmentResults;
  Meta meta;

  factory GetAssessmentsResultResponseModel.fromJson(
          Map<String, dynamic> json) =>
      GetAssessmentsResultResponseModel(
        assessmentResults: List<AssessmentResult>.from(
            json["assessment_results"]
                .map((x) => AssessmentResult.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "assessment_results":
            List<dynamic>.from(assessmentResults.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class AssessmentResult {
  AssessmentResult({
    this.createdAt,
    this.finalScore,
  });

  DateTime createdAt;
  String finalScore;

  factory AssessmentResult.fromJson(Map<String, dynamic> json) =>
      AssessmentResult(
        createdAt: DateTime.parse(json["created_at"]),
        finalScore: json["final_score"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt.toIso8601String(),
        "final_score": finalScore,
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
