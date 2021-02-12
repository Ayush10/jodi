import 'package:flutter/material.dart';
import 'package:jodi/screens/authentication/welcome.dart';

void main() {
  runApp(Jodi());
}

class Jodi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Color(0xffFDEBE0)),
      debugShowCheckedModeBanner: false,
      home: Welcome(),
    );
  }
}
