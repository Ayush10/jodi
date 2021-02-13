import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jodi/screens/authentication/login.dart';
import 'package:jodi/screens/authentication/signup.dart';
import 'package:jodi/screens/authentication/welcome.dart';
import 'package:jodi/screens/mainmenu/mainscreen.dart';
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
      home: Welcome(),
      routes: <String, WidgetBuilder>{
        "Login": (BuildContext context) => Login(),
        "SignUp": (BuildContext context) => SignUp(),
        "Start": (BuildContext context) => Start(),
        "MainScreen": (BuildContext context) => MainScreen(),
      },
    );
  }
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: FutureBuilder(
//         future: AuthMethods().getCurrentUser(),
//         builder: (context, AsyncSnapshot<dynamic> snapshot) {
//           if (snapshot.hasData) {
//             return Home();
//           } else {
//             return SignIn();
//           }
//         },
//       ),
//     );
//   }
// }
