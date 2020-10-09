import 'package:flutter/material.dart';
import 'package:sarahah_chat/UI/user_info.dart/user_info_screen.dart';
import 'package:sarahah_chat/appConfig/app_config.dart';
import 'package:sarahah_chat/model/user_model.dart';

class SettingScreen extends StatefulWidget {
  static final String routeName = '/settingScreen';

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _switchValue = false;
  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context).settings.arguments as UserModel;
    AppConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('SettingScreen'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            buildSettingFiled(
              icon: Icons.person_pin_outlined,
              title: 'User Information',
              onTap: () {
                Navigator.of(context)
                    .pushNamed(UserInfoScreen.routeName, arguments: user);
              },
            ),
            buildSettingFiled(
              icon: Icons.notifications,
              title: 'Push Notification',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSettingFiled({
    @required IconData icon,
    @required String title,
    @required Function onTap,
  }) {
    return Builder(
      builder: (context) => GestureDetector(
        onTap: onTap,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: 5,
          child: Container(
            margin: const EdgeInsets.all(5),
            padding: EdgeInsets.symmetric(
              horizontal: AppConfig.blockSizeHorizontal * 5,
              vertical: AppConfig.blockSizeVertical * 2,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Colors.purple,
                  size: AppConfig.blockSizeVertical * 4,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: AppConfig.blockSizeVertical * 3,
                  ),
                ),
                Spacer(),
                if (title != 'User Information')
                  Switch(
                    value: _switchValue,
                    onChanged: (r) {
                      setState(() {
                        _switchValue = !_switchValue;
                      });
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
