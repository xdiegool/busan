import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sarahah_chat/UI/Auth/auth_screen.dart';
import 'package:sarahah_chat/UI/setting/setting_screen.dart';
import 'package:sarahah_chat/appConfig/app_config.dart';
import 'package:sarahah_chat/model/user_model.dart';
import 'package:sarahah_chat/provider/auth_provider.dart';
import 'package:sarahah_chat/provider/user_provider.dart';

class BuildDrawer extends StatefulWidget {
  @override
  _BuildDrawerState createState() => _BuildDrawerState();
}

class _BuildDrawerState extends State<BuildDrawer> {
  var userProvider;
  List<UserModel> user;
  @override
  void initState() {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.fetchUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppConfig().init(context);
    return Drawer(
      child: Column(
        children: [
          StreamBuilder(
            stream: userProvider.getUserInfo,
            builder: (context, snapshot) {
              user = snapshot.data;
              return snapshot.hasData
                  ? buildDrawerBody(snapshot.data)
                  : Container(
                      color: Colors.pink,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
            },
          ),
          drawerField(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context)
                  .pushNamed(SettingScreen.routeName, arguments: user[0]);
            },
            title: 'Setting',
            icon: Icons.settings,
          ),
          Divider(
            color: Colors.grey[900],
          ),
          drawerField(
            onTap: () {
              Navigator.of(context).pop();
              Provider.of<AuthProvider>(context, listen: false)
                  .signOut()
                  .then((value) {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AuthScreen()),
                );
              });
            },
            title: 'Log Out',
            icon: Icons.exit_to_app,
          ),
        ],
      ),
    );
  }

  Widget buildDrawerBody(List<UserModel> user) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.2,
      padding: EdgeInsets.symmetric(vertical: AppConfig.blockSizeVertical * 5),
      color: Colors.pink,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 35,
          backgroundImage: NetworkImage(user[0].photoUrl),
        ),
        title: Text(
          user[0].name,
          style: TextStyle(
            color: Colors.white,
            fontSize: AppConfig.blockSizeVertical * 2.5,
          ),
        ),
        subtitle: Text(
          user[0].email,
          style: TextStyle(
            color: Colors.white,
            fontSize: AppConfig.blockSizeVertical * 2,
          ),
        ),
      ),
    );
  }

  Widget drawerField({
    @required Function onTap,
    @required String title,
    @required IconData icon,
  }) {
    AppConfig().init(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
            vertical: AppConfig.blockSizeVertical * 2,
            horizontal: AppConfig.blockSizeHorizontal * 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: AppConfig.blockSizeVertical * 2.5,
              ),
            ),
            Icon(
              icon,
              size: AppConfig.blockSizeVertical * 4.5,
              color: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}
