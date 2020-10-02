import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:provider/provider.dart';
import 'package:sarahah_chat/UI/Home/home_screen.dart';
import 'package:sarahah_chat/provider/auth_provider.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SignInButtonBuilder(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false)
                    .signInWithFacebook()
                    .then((value) {
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
