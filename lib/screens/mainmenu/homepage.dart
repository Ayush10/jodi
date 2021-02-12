import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;

  checkAuthentication() async {
    _firebaseAuth.authStateChanges().listen((user) {
      Navigator.pushReplacementNamed(context, "Start");
    });
  }

  getUser() async {
    User firebaseUser = await _firebaseAuth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _firebaseAuth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  signOut() async {
    _firebaseAuth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
