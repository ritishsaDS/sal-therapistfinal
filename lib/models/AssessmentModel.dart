// To parse this JSON data, do
//
//     final getCounsellor = getCounsellorFromJson(jsonString);

@deprecated
class AssessmentModel {
  AssessmentModel({
    this.questionOptions,
    this.meta,
  });

  Map<String, List<AssessmentQuestion>> questionOptions;
  Meta meta;

  factory AssessmentModel.fromJson(Map<String, dynamic> json) {
    var map = json["question_options"] as Map;
    var model = AssessmentModel(
      questionOptions: {
        for (var key in map.keys)
          key: List<AssessmentQuestion>.from(
            (map[key] as List).map((e) => AssessmentQuestion.fromJson(e)),
          )
      },
      meta: Meta.fromJson(json["meta"]),
    );

    return model;
  }

  Map<String, dynamic> toJson() => {
        "question_options": {
          for (var key in questionOptions.keys)
            {
              key: [for (var item in questionOptions[key]) item.toJson()]
            }
        },
        "meta": meta.toJson(),
      };
}

class AssessmentQuestion {
  AssessmentQuestion({
    this.assessmentQuestionId,
    this.assessmentQuestionOptionId,
    this.option,
    this.score,
  });

  final String assessmentQuestionId;
  final String assessmentQuestionOptionId;
  final String option;
  final String score;

  factory AssessmentQuestion.fromJson(Map<String, dynamic> json) =>
      AssessmentQuestion(
        assessmentQuestionId: json["assessment_question_id"],
        assessmentQuestionOptionId: json["assessment_question_option_id"],
        option: json["option"],
        score: json["score"],
      );

  Map<String, dynamic> toJson() => {
        "assessment_question_id": assessmentQuestionId,
        "assessment_question_option_id": assessmentQuestionOptionId,
        "option": option,
        "score": score,
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
