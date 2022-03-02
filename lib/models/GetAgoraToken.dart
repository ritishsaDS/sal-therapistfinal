import 'dart:convert';
GetAgoraToken getAgoraTokenModelFromJson(String str) =>
    GetAgoraToken.fromJson(json.decode(str));

class GetAgoraToken {
  String UID;
  Meta meta;
  String token;

  GetAgoraToken();

  factory GetAgoraToken.fromJson(Map<String, dynamic> parsedJson) {
    GetAgoraToken agoraToken = GetAgoraToken();
    agoraToken.meta = Meta.fromJson(parsedJson["meta"]);
    agoraToken.UID = parsedJson['UID'];
    agoraToken.token = parsedJson['token'];
    return agoraToken;
  }

  Map<String, dynamic> toJson() {
    return {'meta': meta.toJson(), 'UID': UID, 'token': token};
  }
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