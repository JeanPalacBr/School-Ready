import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/UI/Home.dart';
import 'package:login/services/InfoHandler.dart';
import 'package:login/viewmodels/AccountState.dart';
import 'package:provider/provider.dart';

class RestartDBDialog extends StatefulWidget {
  @override
  RestartDBDialogState createState() => RestartDBDialogState();
}

class RestartDBDialogState extends State<RestartDBDialog> {
  bool restart = true;

   final acState = Provider.of<AccountState>(contexth);
     @override
  void initState() {
    super.initState();
    restartdata(acState.getUsername,acState.getToken);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        "Restarting database...",
        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          restart
              ? Icon(
                  Icons.check,
                  size: 100,
                  color: Colors.green,
                )
              : Icon(
                  Icons.cancel,
                  size: 100,
                  color: Colors.red,
                ),
          restart ? Text("Database restarted!") : Text("restart failed"),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  void restartdata(String username, String token) async {
    restartDB(username, token).then((connect) {
      setState(() {
        bool con = connect.restart;
        if (con) {
          restart = true;
        } else {
          restart = false;
        }
      });
    });
  }
}
