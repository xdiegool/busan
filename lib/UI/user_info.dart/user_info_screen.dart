import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sarahah_chat/appConfig/app_config.dart';
import 'package:sarahah_chat/model/user_model.dart';
import 'package:sarahah_chat/provider/user_provider.dart';

class UserInfoScreen extends StatefulWidget {
  static final String routeName = '/userInfo';

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  bool _isNameEditable = false;
  bool _isEmailEditable = false;
  var _name = 'mohamed';
  var _email = 'mohamedsheko980@yahoo.com';
  @override
  Widget build(BuildContext context) {
    AppConfig().init(context);
    final user = ModalRoute.of(context).settings.arguments as UserModel;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SafeArea(
        top: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 10),
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(user.photoUrl),
                    radius: AppConfig.blockSizeVertical * 10,
                  ),
                ),
                Positioned(
                  right: MediaQuery.of(context).size.width / 2 - 80,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    alignment: Alignment.bottomCenter,
                    child: CircleAvatar(
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 35,
                      ),
                      radius: AppConfig.blockSizeHorizontal * 6,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            ListTile(
              leading: Icon(Icons.person_rounded),
              title: Text(
                'Name',
                style: TextStyle(fontSize: AppConfig.blockSizeVertical * 2.2),
              ),
              subtitle: _isNameEditable
                  ? TextFormField(
                      initialValue: user.name,
                      onChanged: (value) {
                        user.name = value;
                      },
                      cursorColor: Colors.pink,
                      decoration: InputDecoration(
                        hintText: 'Enter Your Name',
                      ),
                    )
                  : Text(
                      user.name,
                      style:
                          TextStyle(fontSize: AppConfig.blockSizeVertical * 3),
                    ),
              trailing: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isNameEditable = !_isNameEditable;
                    });
                    if (!_isNameEditable) {
                      print(user.name);
                      Provider.of<UserProvider>(context, listen: false)
                          .updateUserData(user.name);
                    }
                  },
                  child: Icon(
                    !_isNameEditable ? Icons.edit : Icons.done,
                    color: Colors.pink,
                  )),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text(
                'Email',
                style: TextStyle(fontSize: AppConfig.blockSizeVertical * 2.2),
              ),
              subtitle: Text(
                user.email,
                style: TextStyle(fontSize: AppConfig.blockSizeVertical * 3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
