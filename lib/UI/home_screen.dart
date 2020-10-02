import 'package:flutter/material.dart';
import 'package:sarahah_chat/appConfig/app_config.dart';

class HomeScreen extends StatelessWidget {
  static final String routeName = '/homescreen';
  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    AppConfig().init(context);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('welcome'),
      ),
    );
  }
}
