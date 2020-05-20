import 'package:flutter/material.dart';
import 'package:login/UI/NavDrawer.dart';
import 'package:login/services/InfoHandler.dart';
import 'package:login/Models/course.dart';
import 'package:login/UI/Login.dart';
import 'package:login/viewmodels/AccountState.dart';
import 'package:login/UI/CardCourse.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login.dart';
var contexth;
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Course> coursesL = new List<Course>();
  final acState = Provider.of<AccountState>(contextsc);
  @override
  void initState() {
    super.initState();
    acState.getlogin ? Home() : Islogged();
    _getUserCourses(contextsc, acState.getUsername, acState.getToken);
  }

  @override
  Widget build(BuildContext context) {
    final acState = Provider.of<AccountState>(context);
    contexth = context;
    return Scaffold(
      appBar: AppBar(title: Text("School Ready!"),
      backgroundColor: Colors.black),
       drawer: NavDrawer(),
       
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[           
            Expanded(child: _list()),
            FloatingActionButton(
              backgroundColor: const Color(0xff167F67),
                onPressed: () {
                  _addNewCourse(context, acState.getUsername, acState.getToken);
                },
                tooltip: 'Add Course',
                child: new Icon(Icons.add)),
          ],
        ),
      ),
    );
  }

  Widget _list() {
    return ListView.builder(
      itemCount: coursesL.length,
      itemBuilder: (context, posicion) {       
        return Container(
              color: Colors.white10,
              alignment: AlignmentDirectional.centerStart,
              child: CardCourse(coursesL[posicion]),
                
              );
          //Icon(Icons.delete, color: Colors.white)),
          
       } );
      }
  

  void _addNewCourse(BuildContext context, String username, String token) {
    createCourses(username, token,context).then((ncourse) {
      Course newCourse = Course(
          id: ncourse.id,
          name: ncourse.name,
          professor: ncourse.professor,
          students: ncourse.students);
          if(newCourse != null){
            setState(() {
            coursesL.add(newCourse);        
            });
          }
      
    }).catchError((error) {
      return Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Error" + error.toString())));
    });
  }

  void _getUserCourses(BuildContext context, String username, String token) {
    showCourses(username, token,context).then((ncourse) {
      for (var i = 0; i < ncourse.length; i++) {
      Course newCourse = Course(
          id: ncourse[i].id,
          name: ncourse[i].name,
          professor: ncourse[i].professor,
          students: ncourse[i].students);
          setState(() {
          coursesL.add(newCourse);    
          });          
      }
      
    }).catchError((error) {
      return Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("Error" + error.toString())));
    });
  }
}

void sharedreflogoutset() async {
  SharedPreferences sharedpref = await SharedPreferences.getInstance();
  sharedpref.setString("tokn", "");
  sharedpref.setString("usrname", "");
  sharedpref.setBool("isloggeda", false);
}
