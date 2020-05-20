import 'package:flutter/material.dart';
import 'package:login/Models/student.dart';
import 'package:login/UI/CardStudents.dart';
import 'package:login/UI/NavDrawer.dart';
import 'package:login/UI/ProfessorDetails.dart';
import 'package:login/services/InfoHandler.dart';
import 'package:login/UI/Login.dart';
import 'package:login/viewmodels/AccountState.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login.dart';

class CourseDetails extends StatefulWidget {
  int courseid;
  String username;
  String token;
  bool logged;
  CourseDetails(this.courseid, this.username, this.token, this.logged);
  @override
  CourseDetailstate createState() =>
      CourseDetailstate(this.courseid, this.username, this.token, this.logged);
}

class CourseDetailstate extends State<CourseDetails> {
  int courseid;
  String profname;
  String profusername;
  String profemail;
  int profid;
  String username;
  String token;
  bool logged;
  CourseDetailstate(this.courseid, this.username, this.token, this.logged);
  List<Student> studentsL = new List<Student>();

  @override
  void initState() {
    super.initState();
    if (logged) {
      CourseDetails(courseid, username, token, logged);
    } else {
      Islogged();
    }
    _fillCourseStudentList(username, token, courseid);
  }

  @override
  Widget build(BuildContext context) {
    final acStates = Provider.of<AccountState>(context);
    return Scaffold(
      appBar: AppBar(title: Text("SchoolReady!"),backgroundColor: Colors.black, actions: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0, 15, 18, 0),
          child: Text(
            username,
            style: TextStyle(fontSize: 19, color: Colors.white),
          ),
        ),
      ]),
      drawer: NavDrawer(),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Card(
            elevation: 3,
            color: const Color(0xff167F67),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[],
                ),
                //Container(child: Text("Course Details")),
                Text("Course ID: " + courseid.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 18.0)),

                Text("Professor username: " + profusername,
                    style: TextStyle(color: Colors.white, fontSize: 18.0)),

                Text("professor ID: " + profid.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 18.0)),

                Text("Professor name: " + profname,
                    style: TextStyle(color: Colors.white, fontSize: 18.0)),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                      child: Text("Professor details"),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfessorDetails(
                                      profeid: profid,
                                      username: acStates.getUsername,
                                      logged: acStates.getlogin,
                                      token: acStates.getToken,
                                    )));
                      }),
                ),

               
              ],
            ),
          ), Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              studentlistadvice(),FloatingActionButton(

                backgroundColor: const Color(0xff167F67),
                onPressed: () {
                  _addNewStudent(context,username, token,courseid);
                },
                tooltip: 'Add Course',
                child: new Icon(Icons.add))
            ],
          ),
          Expanded(child: _list())
        ],
      ),
    );
  }

  Widget _list() {
    return ListView.builder(
        itemCount: studentsL.length,
        itemBuilder: (context, posicion) {
          return Container(
            color: Colors.white10,
            alignment: AlignmentDirectional.centerStart,
            child: CardStudents(studentsL[posicion]),
          );
          //Icon(Icons.delete, color: Colors.white)),
        });
  }

    void _addNewStudent(BuildContext context, String username, String token, int courseID) {
    createStudents(username, token,courseID.toString()).then((nstudent) {
        setState(() {
          studentsL.clear();
          _fillCourseStudentList(username, token, courseid);
        });
      
    }).catchError((error) {
      return Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Error" + error.toString())));
    });
  }

  void _fillCourseStudentList(String username, String token, int courseid) {
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
      print(
          "elerrro---> "); 
    });
  }
}

Widget studentlistadvice() {
  return Container(
    margin: const EdgeInsets.all(2.0),
    padding: const EdgeInsets.all(1.0),
    decoration: BoxDecoration(
    border: Border.all(
      color: const Color(0xff167F67),
      width: 3.0
    ),
    borderRadius: BorderRadius.all(
        Radius.circular(20.0) 
    ),
  ),
    child: Text(
      "Students list",
      style: TextStyle(fontSize: 30.0),
    ),
  );
}

void sharedreflogoutset() async {
  SharedPreferences sharedpref = await SharedPreferences.getInstance();
  sharedpref.setString("tokn", "");
  sharedpref.setString("usrname", "");
  sharedpref.setBool("isloggeda", false);
}
