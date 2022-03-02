// To parse this JSON data, do
//
//     final passApointment = passApointmentFromJson(jsonString);

import 'dart:convert';

PassApointment passApointmentFromJson(String str) => PassApointment.fromJson(json.decode(str));

String passApointmentToJson(PassApointment data) => json.encode(data.toJson());

class PassApointment {
  PassApointment({
    this.appointments,
    this.clients,
    this.mediaUrl,
    this.meta,
  });

  List<Appointment> appointments;
  Map<String, Client> clients;
  String mediaUrl;
  Meta meta;

  factory PassApointment.fromJson(Map<String, dynamic> json) => PassApointment(
    appointments: List<Appointment>.from(json["appointments"].map((x) => Appointment.fromJson(x))),
    clients: Map.from(json["clients"]).map((k, v) => MapEntry<String, Client>(k, Client.fromJson(v))),
    mediaUrl: json["media_url"],
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "appointments": List<dynamic>.from(appointments.map((x) => x.toJson())),
    "clients": Map.from(clients).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    "media_url": mediaUrl,
    "meta": meta.toJson(),
  };
}

class Appointment {
  Appointment({
    this.appointmentId,
    this.cancellationReason,
    this.clientEndedAt,
    this.clientId,
    this.clientStartedAt,
    this.comment,
    this.counsellorId,
    this.createdAt,
    this.createdBy,
    this.date,
    this.endedAt,
    this.id,
    this.meetingLink,
    this.modifiedAt,
    this.modifiedBy,
    this.orderId,
    this.rating,
    this.ratingComment,
    this.ratingTypes,
    this.startedAt,
    this.status,
    this.time,
    this.timesRescheduled,
  });

  String appointmentId;
  String cancellationReason;
  String clientEndedAt;
  String clientId;
  String clientStartedAt;
  String comment;
  String counsellorId;
  DateTime createdAt;
  String createdBy;
  DateTime date;
  String endedAt;
  String id;
  String meetingLink;
  String modifiedAt;
  String modifiedBy;
  String orderId;
  String rating;
  String ratingComment;
  String ratingTypes;
  String startedAt;
  String status;
  String time;
  String timesRescheduled;

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
    appointmentId: json["appointment_id"],
    cancellationReason: json["cancellation_reason"],
    clientEndedAt: json["client_ended_at"],
    clientId: json["client_id"],
    clientStartedAt: json["client_started_at"],
    comment: json["comment"],
    counsellorId: json["counsellor_id"],
    createdAt: DateTime.parse(json["created_at"]),
    createdBy: json["created_by"],
    date: DateTime.parse(json["date"]),
    endedAt: json["ended_at"],
    id: json["id"],
    meetingLink: json["meeting_link"],
    modifiedAt: json["modified_at"],
    modifiedBy: json["modified_by"],
    orderId: json["order_id"],
    rating: json["rating"],
    ratingComment: json["rating_comment"],
    ratingTypes: json["rating_types"],
    startedAt: json["started_at"],
    status: json["status"],
    time: json["time"],
    timesRescheduled: json["times_rescheduled"],
  );

  Map<String, dynamic> toJson() => {
    "appointment_id": appointmentId,
    "cancellation_reason": cancellationReason,
    "client_ended_at": clientEndedAt,
    "client_id": clientId,
    "client_started_at": clientStartedAt,
    "comment": comment,
    "counsellor_id": counsellorId,
    "created_at": createdAt.toIso8601String(),
    "created_by": createdBy,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "ended_at": endedAt,
    "id": id,
    "meeting_link": meetingLink,
    "modified_at": modifiedAt,
    "modified_by": modifiedBy,
    "order_id": orderId,
    "rating": rating,
    "rating_comment": ratingComment,
    "rating_types": ratingTypes,
    "started_at": startedAt,
    "status": status,
    "time": time,
    "times_rescheduled": timesRescheduled,
  };
}

class Client {
  Client({
    this.clientId,
    this.firstName,
    this.lastName,
  });

  String clientId;
  String firstName;
  String lastName;

  factory Client.fromJson(Map<String, dynamic> json) => Client(
    clientId: json["client_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
  );

  Map<String, dynamic> toJson() => {
    "client_id": clientId,
    "first_name": firstName,
    "last_name": lastName,
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
