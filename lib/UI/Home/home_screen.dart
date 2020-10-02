import 'package:flutter/material.dart';
import 'package:sarahah_chat/UI/Home/component/build_drawer.dart';
import 'package:sarahah_chat/appConfig/app_config.dart';

class HomeScreen extends StatelessWidget {
  static final String routeName = '/homescreen';
  @override
  Widget build(BuildContext context) {
    AppConfig().init(context);
    return Scaffold(
      appBar: AppBar(),
      drawer: BuildDrawer(),
      body: Center(
        child: Text('welcome'),
      ),
    );
  }
}
