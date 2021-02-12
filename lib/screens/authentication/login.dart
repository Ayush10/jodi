import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email, _password;

  checkAuthentication() async {
    _firebaseAuth.authStateChanges().listen(
      (user) {
        Navigator.pushReplacementNamed(context, "/");
      },
    );

    @override
    void initState() {
      super.initState();
      this.checkAuthentication();
    }

    showError(String errormessage) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('ERROR'),
              content: Text(errormessage),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                )
              ],
            );
          });
    }

    login() async {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();

        try {
          UserCredential user = await _firebaseAuth.signInWithEmailAndPassword(
            email: _email,
            password: _password,
          );
        } catch (e) {
          showError(e.errormessage);
          print(e);
        }
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 400,
                child: Image(
                  image: AssetImage("asset/images/login.png"),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: TextFormField(
                            validator: (input) {
                              if (input.isEmpty) return 'Enter Email';
                            },
                            decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email),
                            ),
                            onSaved: (input) => _email = input),
                      ),
                      Container(
                        child: TextFormField(
                            validator: (input) {
                              if (input.isEmpty)
                                return 'Please Provide Minimum 6 Character';
                            },
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.email),
                            ),
                            obscureText: true,
                            onSaved: (input) => _password = input),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                onPressed: () {},
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
