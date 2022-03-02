// To parse this JSON data, do
//
//     final getAssessmentsQueResponseModel = getAssessmentsQueResponseModelFromJson(jsonString);

import 'dart:convert';

GetAssessmentsQueResponseModel getAssessmentsQueResponseModelFromJson(
        String str) =>
    GetAssessmentsQueResponseModel.fromJson(json.decode(str));

String getAssessmentsQueResponseModelToJson(
        GetAssessmentsQueResponseModel data) =>
    json.encode(data.toJson());

class GetAssessmentsQueResponseModel {
  GetAssessmentsQueResponseModel({
    this.meta,
    this.questionOptions,
    this.questions,
    this.scores,
  });

  Meta meta;
  Map<String, List<QuestionOption>> questionOptions;
  List<Question> questions;
  List<Score> scores;

  factory GetAssessmentsQueResponseModel.fromJson(Map<String, dynamic> json) =>
      GetAssessmentsQueResponseModel(
        meta: Meta.fromJson(json["meta"]),
        questionOptions: Map.from(json["question_options"]).map((k, v) =>
            MapEntry<String, List<QuestionOption>>(
                k,
                List<QuestionOption>.from(
                    v.map((x) => QuestionOption.fromJson(x))))),
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
        scores: List<Score>.from(json["scores"].map((x) => Score.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "question_options": Map.from(questionOptions).map((k, v) =>
            MapEntry<String, dynamic>(
                k, List<dynamic>.from(v.map((x) => x.toJson())))),
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
        "scores": List<dynamic>.from(scores.map((x) => x.toJson())),
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

class QuestionOption {
  QuestionOption({
    this.assessmentQuestionId,
    this.assessmentQuestionOptionId,
    this.option,
    this.score,
  });

  String assessmentQuestionId;
  String assessmentQuestionOptionId;
  String option;
  String score;

  factory QuestionOption.fromJson(Map<String, dynamic> json) => QuestionOption(
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

class Question {
  Question({
    this.assessmentQuestionId,
    this.question,
  });

  String assessmentQuestionId;
  String question;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        assessmentQuestionId: json["assessment_question_id"],
        question: json["question"],
      );

  Map<String, dynamic> toJson() => {
        "assessment_question_id": assessmentQuestionId,
        "question": question,
      };
}

class Score {
  Score({
    this.assessmentId,
    this.id,
    this.max,
    this.min,
    this.result,
  });

  String assessmentId;
  String id;
  String max;
  String min;
  String result;

  factory Score.fromJson(Map<String, dynamic> json) => Score(
        assessmentId: json["assessment_id"],
        id: json["id"],
        max: json["max"],
        min: json["min"],
        result: json["result"],
      );

  Map<String, dynamic> toJson() => {
        "assessment_id": assessmentId,
        "id": id,
        "max": max,
        "min": min,
        "result": result,
      };
}
