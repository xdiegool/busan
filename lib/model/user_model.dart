class UserModel {
  String fierbaseUID;
  String facebookUID;
  String name;
  String email;
  String photoUrl;

  UserModel({
    this.fierbaseUID,
    this.facebookUID,
    this.name,
    this.email,
    this.photoUrl,
  });
  UserModel.fromMap(Map<dynamic, dynamic> data) {
    fierbaseUID = data['fierbaseUID'];
    facebookUID = data['facebookUID'];
    name = data['name'];
    email = data['email'];
    photoUrl = data['photoUrl'];
  }
  // Map<String, dynamic> toMap(UserModel model) {
  //   Map<String, dynamic> map = {};
  //   map['fierbaseUID'] = model.fierbaseUID;
  //   map['facebookUID'] = model.facebookUID;
  //   map['name'] = model.name;
  //   map['email'] = model.email;
  //   map['photoUrl'] = model.photoUrl;
  //   return map;
  // }
}
