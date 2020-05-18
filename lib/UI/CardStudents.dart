import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/Models/student.dart';

class CardStudents extends StatelessWidget {
  Student studentss;
  CardStudents(this.studentss);
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          
        },
        child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
                child: Column(
              children: <Widget>[
                padding(
                    Text("Student ID: " + studentss.id.toString(),
                        style: TextStyle(fontSize: 18.0)),
                    1),
                Text("Name: " + studentss.name,
                    style: TextStyle(fontSize: 18.0)),
                Text("Username: " + studentss.username,
                    style: TextStyle(fontSize: 18.0)),
                padding(
                    Text("Email:" + studentss.email,
                        style: TextStyle(fontSize: 18.0)),
                    2),
              ],
            ))));
  }

  Widget padding(Widget widget, int t, [String typeTodo]) {
    Widget pa;
    switch (t) {
      case 1:
        pa =
            Padding(padding: EdgeInsets.fromLTRB(10, 30, 10, 5), child: widget);
        break;
      case 2:
        pa =
            Padding(padding: EdgeInsets.fromLTRB(10, 5, 10, 30), child: widget);
        break;
    }

    return pa;
  }
}
