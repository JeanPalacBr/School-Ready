import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/Models/student.dart';

class CardStudents extends StatelessWidget {
  Student studentss;
  CardStudents(this.studentss);
  @override
  Widget build(BuildContext context) {
    return 
    MaterialApp(      
    home: InkWell(
      onTap: (){
        
      },
      child: Card(
        child: Center(
            child: Column(
      children: <Widget>[
        padding(
            Text(studentss.id.toString(), style: TextStyle(fontSize: 18.0)), 1),
        Text(studentss.name, style: TextStyle(fontSize: 18.0)),
        Text(studentss.username, style: TextStyle(fontSize: 18.0)),
        padding(
            Text(studentss.email,
                style: TextStyle(fontSize: 18.0)),
            2),
      ],
    )))));
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
