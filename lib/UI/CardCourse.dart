import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/Models/course.dart';
import 'package:login/UI/CourseDetails.dart';

class CardCourse extends StatelessWidget {
  Course coursess;
  CardCourse(this.coursess);
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          print(coursess.name);
          Navigator.push(context,          
              MaterialPageRoute(builder: (context) => CourseDetails(coursess.id)));
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
                    Text(coursess.name,
                        style: TextStyle(fontSize: 18.0)),
                    1),
                   Text("Course ID: " + coursess.id.toString(),
                    style: TextStyle(fontSize: 18.0)),
                Text("Professor: " + coursess.professor,
                    style: TextStyle(fontSize: 18.0)),
                padding(
                    Text("Number of students: " + coursess.students.toString(),
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
            Padding(padding: EdgeInsets.fromLTRB(2, 15, 2, 20), child: widget);
        break;
      case 2:
        pa =
            Padding(padding: EdgeInsets.fromLTRB(10, 2, 10, 30), child: widget);
        break;
    }

    return pa;
  }
}
