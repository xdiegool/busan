import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sarahah_chat/UI/Auth/auth_screen.dart';
import 'package:sarahah_chat/UI/Home/home_screen.dart';
import 'package:sarahah_chat/UI/chat/chat_screen.dart';
import 'package:sarahah_chat/UI/setting/setting_screen.dart';
import 'package:sarahah_chat/UI/user_info.dart/user_info_screen.dart';
import 'package:sarahah_chat/provider/auth_provider.dart';
import 'package:sarahah_chat/provider/chat_provider.dart';
import 'package:sarahah_chat/provider/home_provider.dart';
import 'package:sarahah_chat/provider/user_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChatProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.purple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: HomeScreen(),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return HomeScreen();
              }
              return AuthScreen();
            }),
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
          ChatScreen.routeNamed: (context) => ChatScreen(),
          SettingScreen.routeName: (context) => SettingScreen(),
          UserInfoScreen.routeName: (context) => UserInfoScreen(),
        },
      ),
    );
  }
}
