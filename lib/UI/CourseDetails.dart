import 'package:flutter/material.dart';
import 'package:login/Models/student.dart';
import 'package:login/UI/CardStudents.dart';
import 'package:login/UI/ProfessorDetails.dart';
import 'package:login/UI/SignUp.dart';
import 'package:login/viewmodels/AccountState.dart';
import 'package:login/services/InfoHandler.dart';
import 'package:provider/provider.dart';
import 'package:login/UI/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login.dart';

class CourseDetails extends StatefulWidget {
  int courseid;
  CourseDetails(this.courseid);
  @override
  CourseDetailstate createState() => CourseDetailstate(courseid);
}

class CourseDetailstate extends State<CourseDetails> {
  int idcourse;
  String profname;
  String profusername;
  String profemail;
  int profid;
  CourseDetailstate(this.idcourse);
  List<Student> studentsL = new List<Student>();
  final acState = Provider.of<AccountState>(contextsc);
  @override
  void initState() {
    super.initState();
    acState.getlogin ? CourseDetails(idcourse) : Islogged();
    _fillCourseStudentList(
        contextsc, acState.getUsername, acState.getToken, idcourse);
  }

  @override
  Widget build(BuildContext context) {
    final acState = Provider.of<AccountState>(context);
    return Scaffold(
      appBar: AppBar(title: Text("SchoolReady!")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(acState.getUsername),
                FlatButton(
                    child: Text("Log Out"),
                    onPressed: () {
                      
                      acState.setLogout();
                      sharedreflogoutset();
                    }),
              ],
            ),
            Container(child: Text("Course Details")),
            Text("Course ID: " + idcourse.toString()),
            Text("Professor username: " + profusername),
            Text("professor ID" + profid.toString()),
            Text("Professor name" + profname),
            RaisedButton(
                child: Text("Professor details"),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfessorDetails(profid)));
                }),
            Container(child: Text("Students list")),
            Expanded(child: _list()),
          ],
        ),
      ),
    );
  }

  Widget _list() {
    return ListView.builder(
        itemCount: studentsL.length,
        itemBuilder: (context, posicion) {
          var element = studentsL[posicion];
          return Container(
            color: Colors.white10,
            alignment: AlignmentDirectional.centerStart,
            child: CardStudents(studentsL[posicion]),
          );
          //Icon(Icons.delete, color: Colors.white)),
        });
  }

  void _fillCourseStudentList(
      BuildContext context, String username, String token, int courseid) {
    viewCourses(username, token, courseid).then((ncourse) {
      setState(() {
        profid = ncourse.profe.id;
        profemail = ncourse.profe.email;
        profusername = ncourse.profe.username;
        profname = ncourse.profe.name;
      });
      for (var i = 0; i < ncourse.students.length; i++) {
        Student newstudent = Student(
            id: ncourse.students[i].id,
            name: ncourse.students[i].name,
            email: ncourse.students[i].email,
            username: ncourse.students[i].username);
        setState(() {
          studentsL.add(newstudent);
        });
      }
    }).catchError((error) {
      return print(
          "elerrro---> "); //Scaffold.of(context).showSnackBar(SnackBar(content: Text("Error" + error.toString())));
    });
  }
}

void sharedreflogoutset() async {
  SharedPreferences sharedpref = await SharedPreferences.getInstance();
  sharedpref.setString("tokn", "");
  sharedpref.setString("usrname", "");
  sharedpref.setBool("isloggeda", false);
}
