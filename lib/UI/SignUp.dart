import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/services/InfoHandler.dart';
import 'package:string_validator/string_validator.dart';

var globalContext;

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    globalContext = context;
    return MaterialApp(
        title: "CoursesAPP",
        home: Scaffold(
          //resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            title: Text("CoursesAPP"),
          ),
          body: signupform(),
        ));
  }
}

class signupform extends StatefulWidget {
  @override
  signupformState createState() {
    return signupformState();
  }
}

void _onpressedSignUp(
    var context, String email, String _password, String userna, String nam) {
  signUp(email: email, password: _password, username: userna, name: nam)
      .then((user) {
    return Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Registered')));
  }).catchError((error) {
    return Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text("Error" + error.toString())));
  }).timeout(Duration(seconds: 10), onTimeout: () {
    return Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text("Timeout error")));
  });
}

class signupformState extends State {
  @override
  Widget build(BuildContext context) {
    final _signUpfkey = GlobalKey<FormState>();
    final _email = new TextEditingController();
    final _password = new TextEditingController();
    final _name = new TextEditingController();
    final _username = new TextEditingController();

    return Form(
        key: _signUpfkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              "SignUP!",
              style: TextStyle(fontSize: 30),
            ),
            TextFormField(
              autofocus: true,
              controller: _email,
              decoration:
                  new InputDecoration(labelText: "Email", hintText: "a@a.com"),
            ),
            TextFormField(
              autofocus: true,
              controller: _username,
              decoration: new InputDecoration(
                  labelText: "Username", hintText: "username"),
              validator: (value2) {
                if (value2.isEmpty) {
                  return 'Por favor ingrese algun texto';
                }
              },
            ),
            TextFormField(
              autofocus: true,
              controller: _name,
              decoration:
                  new InputDecoration(labelText: "Name", hintText: "Name"),
              validator: (value3) {
                if (value3.isEmpty) {
                  return 'Por favor ingrese algun texto';
                }
              },
            ),
            TextFormField(
              autofocus: true,
              controller: _password,
              decoration: new InputDecoration(labelText: "Password"),
              obscureText: true,
              validator: (value4) {
                if (value4.isEmpty) {
                  return 'Por favor ingrese algun texto';
                }
              },
            ),
            RaisedButton(
              child: Text("Register!"),
              onPressed: () {
                if (isEmail(_email.value.text)) {
                  _onpressedSignUp(
                      context,
                      _email.value.text,
                      _password.value.text,
                      _username.value.text,
                      _name.value.text);
                } else {
                  Scaffold.of(globalContext)
                      .showSnackBar(SnackBar(content: Text('Invalid Email')));
                }
                Navigator.pop(globalContext);
              },
            )
          ],
        ));
  }
}
