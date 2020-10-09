import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sarahah_chat/UI/Home/component/build_drawer.dart';
import 'package:sarahah_chat/UI/chat/chat_screen.dart';
import 'package:sarahah_chat/appConfig/app_config.dart';
import 'package:sarahah_chat/model/user_model.dart';
import 'package:sarahah_chat/provider/home_provider.dart';

class HomeScreen extends StatefulWidget {
  static final String routeName = '/homescreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var homeProvider;

  @override
  void initState() {
    homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.fetchUsersInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppConfig().init(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Sarahah Chat'),
        ),
        drawer: BuildDrawer(),
        body: StreamBuilder(
          stream: homeProvider.getUserInfo,
          builder: (context, snapshot) {
            print(snapshot.data);
            return snapshot.hasData
                ? buildUsersList(snapshot.data)
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ));
  }

  Widget buildUsersList(List<UserModel> user) {
    return ListView.builder(
      itemCount: user.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(ChatScreen.routeNamed, arguments: user[index]);
        },
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.pinkAccent,
            backgroundImage: NetworkImage(user[index].photoUrl),
            radius: 30,
          ),
          title: Text(user[index].name),
          subtitle: Text(user[index].email),
        ),
      ),
    );
  }
}
