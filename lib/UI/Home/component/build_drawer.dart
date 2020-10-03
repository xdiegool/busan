import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sarahah_chat/UI/Auth/auth_screen.dart';
import 'package:sarahah_chat/appConfig/app_config.dart';
import 'package:sarahah_chat/provider/auth_provider.dart';

class BuildDrawer extends StatefulWidget {
  @override
  _BuildDrawerState createState() => _BuildDrawerState();
}

class _BuildDrawerState extends State<BuildDrawer> {
  @override
  Widget build(BuildContext context) {
    AppConfig().init(context);
    return Drawer(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) => snapshot.hasData
            ? Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: AppConfig.blockSizeVertical * 5),
                    color: Colors.pink,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 35,
                        backgroundImage:
                            NetworkImage(snapshot.data['photoUrl']),
                      ),
                      title: Text(
                        snapshot.data['name'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: AppConfig.blockSizeVertical * 2.5,
                        ),
                      ),
                      subtitle: Text(
                        snapshot.data['email'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: AppConfig.blockSizeVertical * 2,
                        ),
                      ),
                    ),
                  ),
                  drawerField(
                    onTap: () {},
                    title: 'Setting',
                    icon: Icons.settings,
                  ),
                  Divider(
                    color: Colors.grey[900],
                  ),
                  drawerField(
                    onTap: () {
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
              )
            : Center(
                child: CircularProgressIndicator(),
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
      child: Padding(
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
            Icon(icon, size: AppConfig.blockSizeVertical * 4.5),
          ],
        ),
      ),
    );
  }
}
