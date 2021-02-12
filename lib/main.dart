import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jodi/screens/authentication/login.dart';
import 'package:jodi/screens/authentication/signup.dart';
import 'package:jodi/screens/mainmenu/profilepage.dart';
import 'package:jodi/screens/mainmenu/start.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Jodi());
}

class Jodi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xffFDEBE0),
        fontFamily: 'Raleway',
      ),
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
      routes: <String, WidgetBuilder>{
        "Login": (BuildContext context) => Login(),
        "SignUp": (BuildContext context) => SignUp(),
        "Start": (BuildContext context) => Start(),
      },
    );
  }
}
