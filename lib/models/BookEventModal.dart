class BookEventModal {
  Meta meta;

  BookEventModal({this.meta});

  BookEventModal.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    return data;
  }
}

class Meta {
  String message;
  String messageType;
  String status;

  Meta({this.message, this.messageType, this.status});

  Meta.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    messageType = json['message_type'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['message_type'] = this.messageType;
    data['status'] = this.status;
    return data;
  }
}
