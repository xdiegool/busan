import 'dart:convert';

class AuthModel {
  String fierbaseUID;
  String facebookUID;
  String name;
  String email;
  String photoUrl;

  AuthModel({
    this.fierbaseUID,
    this.facebookUID,
    this.name,
    this.email,
    this.photoUrl,
  });

  Map<String, dynamic> toMap(AuthModel model) {
    Map<String, dynamic> map = {};
    map['fierbaseUID'] = model.fierbaseUID;
    map['facebookUID'] = model.facebookUID;
    map['name'] = model.name;
    map['email'] = model.email;
    map['photoUrl'] = model.photoUrl;
    return map;
  }
}
