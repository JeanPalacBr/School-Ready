import 'package:flutter/material.dart';
import 'package:login/UI/SignUp.dart';
import 'package:login/viewmodels/AccountState.dart';
import 'package:login/services/InfoHandler.dart';
import 'package:provider/provider.dart';
import 'Home.dart';
import 'package:string_validator/string_validator.dart';

var contextsc;
bool islogd;
String usrn;
String tokn;

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    contextsc = context;
    final AcState = Provider.of<AccountState>(context);
    return MaterialApp(
        title: "SchoolReady!",
        home: Scaffold(
          //resizeToAvoidBottomPadding: false,
          
          body: AcState.getlogin ? Home() : Islogged(),
        ));
    //home: AcState.getlogin? Home():islogged());
  }
}

class Islogged extends StatefulWidget {
  Isloggedstate createState() => Isloggedstate();
}

void _onpressedlogin(var context, String email, String _password, bool remember) {
  signIn(email: email, password: _password).then((user) {
    Provider.of<AccountState>(context, listen: false)
        .setLoggedin(user.username, user.token, true, remember);
    return Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Logged In')));
  }).catchError((error) {
    return Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text("Error" + error.toString())));
  }).timeout(Duration(seconds: 20), onTimeout: () {
    return Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text("Timeout error")));
  });
}

class Isloggedstate extends State {
  final acState = Provider.of<AccountState>(contextsc);
  bool rememberMe = false;
  @override
  void initState() {
    super.initState();
    acState.auth();
  }

  bool auxlog = true;

  final _signUpfkey = GlobalKey<FormState>();
  final _email = new TextEditingController();
  final _password = new TextEditingController();
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.school,
            size: 100,
          ),
          Form(
              key: _signUpfkey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "Sign In",
                      style: TextStyle(fontSize: 20),
                    ),
                    TextFormField(
                      autofocus: true,
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: new InputDecoration(
                          labelText: "Email", hintText: "a@a.com"),
                    ),
                    TextFormField(
                      autofocus: true,
                      decoration: new InputDecoration(labelText: "Password"),
                      obscureText: true,
                      controller: _password,
                    ),
                    Row(
                      children: <Widget>[
                        Checkbox(
                            value: rememberMe,
                            onChanged: (bool rem)
                             {
                               setState(() {
                                 rememberMe = rem;
                               });
                              acState.setRememberMe(rememberMe);
                            }),
                      Text("Remember me")],
                    ),
                    RaisedButton(
                      child: Text("Log In!"),
                      onPressed: () {
                        if (isEmail(_email.value.text)) {
                          _onpressedlogin(
                              context, _email.value.text, _password.value.text,rememberMe);
                        } else {
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('Invalid Email or password')));
                        }
                      },
                    )
                  ],
                ),
              )),
          Text("or"),
          RaisedButton(
            child: Text("Sign Up"),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SignUp()));
            },
          ),
        ],
      ),
    );
  }
}
