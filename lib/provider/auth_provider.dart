import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:http/http.dart' as h;

class AuthProvider extends ChangeNotifier {
  static final FacebookLogin _fblogin = FacebookLogin();

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<dynamic> signInWithFacebook() async {
    print('begin');
    final FacebookLoginResult result =
        await _fblogin.logIn(permissions: [FacebookPermission.email]);

    switch (result.status) {
      case FacebookLoginStatus.Success:
        final FacebookAccessToken accessToken = result.accessToken;
        AuthCredential fbCredential =
            FacebookAuthProvider.credential(accessToken.token);
        FirebaseAuth.instance
            .signInWithCredential(fbCredential)
            .then((user) async {
          var graphResponse = await h.get(
              'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${result.accessToken.token}');
          var profile = json.decode(graphResponse.body);
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(user.user.uid)
              .set({
            'name': profile['name'],
            'email': profile['email'],
            'photoUrl': profile['picture']['data']['url'],
          });
        });
        break;
      case FacebookLoginStatus.Cancel:
        print('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.Error:
        print('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.error}');
        break;
    }
    print('end');
  }
}
