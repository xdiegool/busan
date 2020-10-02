import 'package:flutter/material.dart';
import 'package:flutter_facebook_login_with_web/flutter_facebook_login_with_web.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:provider/provider.dart';
import 'package:sarahah_chat/UI/Home/home_screen.dart';
import 'package:sarahah_chat/provider/auth_provider.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SignInButtonBuilder(
              onPressed: () {
                authProvider.signInWithFacebook().then((value) {
                  if (authProvider.loginStatus == FacebookLoginStatus.loggedIn)
                    Navigator.of(context)
                        .pushReplacementNamed(HomeScreen.routeName);
                });
              },
              backgroundColor: Colors.blue[700],
              text: 'Sign in with facebook',
              image: Image.asset('assets/facebook.png'),
            ),
          ),
        ],
      ),
    );
  }
}
