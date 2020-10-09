import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sarahah_chat/model/user_model.dart';

class UserProvider extends ChangeNotifier {
  BehaviorSubject<List<UserModel>> _usersInfo = BehaviorSubject();
  Stream<List<UserModel>> get getUserInfo => _usersInfo.stream;
  Future<dynamic> fetchUserInfo() async {
    List<UserModel> _userData = [];
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();
    _userData.add(UserModel.fromMap(snapshot.data()));
    _usersInfo.add(_userData);
    notifyListeners();
  }

  Future<void> updateUserData(String name) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update(
      {
        'name': name,
      },
    );
  }
}
