import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sarahah_chat/model/user_model.dart';

class HomeProvider extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  BehaviorSubject<List<UserModel>> _usersInfo = BehaviorSubject();
  Stream<List<UserModel>> get getUserInfo => _usersInfo.stream;
  Future<dynamic> fetchUsersInfo() async {
    print('herrrrrrrrrrrrrrrrrrrrrrrrrr'+ _auth.currentUser.uid.toString());
    List<UserModel> _userData = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('fierbaseUID', isLessThan: _auth.currentUser.uid)
        .get();
    snapshot.docs.forEach((element) {
      _userData.add(UserModel.fromMap(element.data()));
    });
    _usersInfo.add(_userData);
    notifyListeners();
  }
}
