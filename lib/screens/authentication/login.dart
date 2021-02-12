import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final UserCredential _firebaseAuth = UserCredential.instance;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
