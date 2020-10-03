import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sarahah_chat/model/message_model.dart';

class ChatProvider extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  BehaviorSubject<List<MessageModel>> _messages = BehaviorSubject();
  Stream<List<MessageModel>> get getMessages => _messages.stream;

  Future<void> fetchMessages(String otherUID) async {
    List<MessageModel> _message = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('messages')
        .doc(_auth.currentUser.uid + otherUID)
        .collection('UserMessage')
        .orderBy('createdAt', descending: true)
        .get();
    snapshot.docs.forEach((element) {
      _message.add(MessageModel.fromMap(element.data()));
    });
    _messages.add(_message);
    notifyListeners();
  }

  Future<void> sendMessage(
      String otherUID, String message, Timestamp createdAt) async {
    await FirebaseFirestore.instance
        .collection('messages')
        .doc(_auth.currentUser.uid + otherUID)
        .collection('UserMessage')
        .doc()
        .set(
          MessageModel().toMap(
            MessageModel(
              facebookUIDOfOther: otherUID,
              message: message,
              createdAt: createdAt,
            ),
          ),
        );
  }
}
