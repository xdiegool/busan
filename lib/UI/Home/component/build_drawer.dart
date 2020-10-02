import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sarahah_chat/appConfig/app_config.dart';
import 'package:sarahah_chat/provider/auth_provider.dart';
import 'package:sarahah_chat/provider/user_provider.dart';

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
                    color: Colors.blue,
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
                  GestureDetector(
                    onTap: () {
                      Provider.of<AuthProvider>(context, listen: false)
                          .signOut()
                          .then((value) {
                        setState(() {});
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Log Out',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: AppConfig.blockSizeVertical * 2.5,
                            ),
                          ),
                          Icon(Icons.exit_to_app,
                              size: AppConfig.blockSizeVertical * 4.5),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
