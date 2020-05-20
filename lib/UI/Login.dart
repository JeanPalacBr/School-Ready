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
    final acState = Provider.of<AccountState>(context);
    return MaterialApp(
        title: "SchoolReady!",
        home: Scaffold(
          backgroundColor: const Color(0xff167F67),
          //resizeToAvoidBottomPadding: false,

          body: acState.getlogin ? Home() : Islogged(),
        ));
    //home: AcState.getlogin? Home():islogged());
  }
}

class Islogged extends StatefulWidget {
  Isloggedstate createState() => Isloggedstate();
}

void _onpressedlogin(
    var context, String email, String _password, bool remember) {
  setCustomErrorPage();
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

void setCustomErrorPage() {
  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
    print(flutterErrorDetails.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("School Ready!"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text("")],
        ),
      ),
    );
  };
}

class Isloggedstate extends State {
  final acState = Provider.of<AccountState>(contextsc);
  bool rememberMe = false;
  @override
  void initState() {
    super.initState();
    acState.auth(context);
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
       
                      Padding(
              padding: const EdgeInsets.fromLTRB(0, 75, 0, 0),
              child: Icon(
                Icons.school,
                size: 100,
              ),
            ),
          
          Form(
              key: _signUpfkey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "Sign In",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(35,25,35,25),
                      child: containerText(
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          autofocus: true,
                          cursorColor: Colors.white,
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: new InputDecoration(
                              labelText: "Email",labelStyle: TextStyle(color: Colors.white),
                              hintText: "example@ejemplo.com",hintStyle:TextStyle(color: Colors.white),),
                        ),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(35,25,35,25),
                      child: containerText(
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          autofocus: true,
                          decoration: new InputDecoration(labelText: "Password",labelStyle: TextStyle(color: Colors.white)),
                          obscureText: true,
                          controller: _password,
                        ),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 35),
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                              activeColor: Colors.white,
                              checkColor: Colors.green,
                              value: rememberMe,
                              onChanged: (bool rem) {
                                setState(() {
                                  rememberMe = rem;
                                });
                                acState.setRememberMe(rememberMe);
                              }),
                          Text("Remember me",style: TextStyle(color: Colors.white))
                        ],
                      ),
                    ),
                    RaisedButton(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text("Log In!"),
                      onPressed: () {
                        if (isEmail(_email.value.text)) {
                          _onpressedlogin(context, _email.value.text,
                              _password.value.text, rememberMe);
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
            shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                          color: Colors.white,
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
Widget containerText(Widget widg) {
      return Container(
        margin: const EdgeInsets.all(2.0),
        padding: const EdgeInsets.all(1.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 3.0),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: widg,
      );
    }


}
