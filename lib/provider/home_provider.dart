import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sarahah_chat/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider extends ChangeNotifier {
  BehaviorSubject<List<UserModel>> _usersInfo = BehaviorSubject();
  Stream<List<UserModel>> get getUserInfo => _usersInfo.stream;
  Future<dynamic> fetchUsersInfo() async {
    List<UserModel> _userData = [];
    SharedPreferences getUserInfo = await SharedPreferences.getInstance();
    String userId = getUserInfo.getString('firebaseUID');
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('fierbaseUID', isLessThan: userId)
        .get();
    snapshot.docs.forEach((element) {
      _userData.add(UserModel.fromMap(element.data()));
    });
    _usersInfo.add(_userData);
    notifyListeners();
  }
}
