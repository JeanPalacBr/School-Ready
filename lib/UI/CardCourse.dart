import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/Models/course.dart';

class CardCourse extends StatelessWidget {
  Course coursess;
  CardCourse(this.coursess);
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Center(
            child: Column(
      children: <Widget>[
        padding(
            Text(coursess.id.toString(), style: TextStyle(fontSize: 18.0)), 1),
        Text(coursess.name, style: TextStyle(fontSize: 18.0)),
        Text(coursess.professor, style: TextStyle(fontSize: 18.0)),
        padding(
            Text(coursess.students.toString(),
                style: TextStyle(fontSize: 18.0)),
            2),
      ],
    )));
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
