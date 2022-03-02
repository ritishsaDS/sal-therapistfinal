// To parse this JSON data, do
//
//     final langaugeresponsemodel = langaugeresponsemodelFromJson(jsonString);

import 'dart:convert';

Langaugeresponsemodel langaugeresponsemodelFromJson(String str) => Langaugeresponsemodel.fromJson(json.decode(str));

String langaugeresponsemodelToJson(Langaugeresponsemodel data) => json.encode(data.toJson());

class Langaugeresponsemodel {
  Langaugeresponsemodel({
    this.languages,
    this.meta,
  });

  List<Language> languages;
  Meta meta;

  factory Langaugeresponsemodel.fromJson(Map<String, dynamic> json) => Langaugeresponsemodel(
    languages: List<Language>.from(json["languages"].map((x) => Language.fromJson(x))),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "languages": List<dynamic>.from(languages.map((x) => x.toJson())),
    "meta": meta.toJson(),
  };
}

class Language {
  Language({
    this.id,
    this.language,
  });

  String id;
  String language;

  factory Language.fromJson(Map<String, dynamic> json) => Language(
    id: json["id"],
    language: json["language"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "language": language,
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
