import 'package:flutter/material.dart';
import 'package:login/Models/student.dart';
import 'package:login/UI/SignUp.dart';
import 'package:login/viewmodels/AccountState.dart';
import 'package:login/services/InfoHandler.dart';
import 'package:provider/provider.dart';

var contextsc;
bool islogd;
String usrn;
String tokn;

List<Student> studentsL = new List<Student>();

class CourseDetails extends StatelessWidget {
  final int idcourse;
  CourseDetails(this.idcourse);

  @override
  Widget build(BuildContext context) {
    contextsc = context;
    return MaterialApp(
        title: "CoursesAPP",
        home: Scaffold(
          //resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            title: Text("CoursesAPP"),
          ),
          body: CourseDetail(idcourse),
        ));
  }
}

class CourseDetail extends StatefulWidget {
  int courseid;
  CourseDetail(this.courseid);
  CourseDetailstate createState() => CourseDetailstate(courseid);
}

class CourseDetailstate extends State {
  int idcourse;
  CourseDetailstate(this.idcourse);
  final acState = Provider.of<AccountState>(contextsc);
  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    acState.auth();
  }

  void _fillCourseStudentList(
      BuildContext context,
      String username,
      String token,
      int courseid,
      String profname,
      String profusername,
      String profemail,
      int profid) {
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
      return Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Error" + error.toString())));
    });
  }

  bool auxlog = true;
  final _signUpfkey = GlobalKey<FormState>();
  final _email = new TextEditingController();
  final _password = new TextEditingController();
        String profname="";
      String profusername="";
      String profemail="";
      int profid;
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(child: Text("Course Details")),
          Text("  " + idcourse.toString()),
          Text("  " + profusername),
          Text("  " + profid.toString()),
          Text("  " + profname),
          Text("ID"),
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
