import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/services/InfoHandler.dart';

class ConnectionDialog extends StatefulWidget {
  @override
  ConnectionDialogState createState() => ConnectionDialogState();
}

class ConnectionDialogState extends State<ConnectionDialog> {
  bool connection = true;
  @override
  void initState() {
    super.initState();
    checkconnection();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        "Verifying connection...",
        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          connection
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
          connection ? Text("Conected!") : Text("Conection failed"),
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

  void checkconnection() async {
    checkConnection().then((connect) {
      setState(() {
        String con = connect.greeting;
        if (con == "Hello world in JSON") {
          connection = true;
        } else {
          connection = false;
        }
      });
    });
  }
}
