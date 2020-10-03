import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String facebookUIDOfOther;
  String message;
  Timestamp createdAt;
  MessageModel({
    this.facebookUIDOfOther,
    this.message,
    this.createdAt,
  });
  Map<String, dynamic> toMap(MessageModel model) {
    Map<String, dynamic> map = {};
    map['facebookUIDOfOther'] = model.facebookUIDOfOther;
    map['message'] = model.message;
    map['createdAt'] = model.createdAt;
    return map;
  }

  MessageModel.fromMap(Map<dynamic, dynamic> data) {
    facebookUIDOfOther = data['facebookUIDOfOther'];
    message = data['message'];
    createdAt = data['createdAt'];
  }
}
