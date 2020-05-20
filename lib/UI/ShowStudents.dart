import 'package:flutter/material.dart';
import 'package:login/Models/student.dart';
import 'package:login/UI/CardStudents.dart';
import 'package:login/UI/NavDrawer.dart';
import 'package:login/services/InfoHandler.dart';
import 'package:login/UI/Login.dart';
import 'package:login/viewmodels/AccountState.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login.dart';

class ShowStudents extends StatefulWidget {
  @override
  ShowStudentsState createState() => ShowStudentsState();
}

class ShowStudentsState extends State<ShowStudents> {
  List<Student> studentsList = new List<Student>();
  final acState = Provider.of<AccountState>(contextsc);
  @override
  void initState() {
    super.initState();
    acState.getlogin ? ShowStudents() : Islogged();
    _getStudents(contextsc, acState.getUsername, acState.getToken);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text("School Ready!"),),
       drawer: NavDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[           
            Expanded(child: _list()),
          ],
        ),
      ),
    );
  }

  Widget _list() {
    return ListView.builder(
      itemCount: studentsList.length,
      itemBuilder: (context, posicion) {       
        return Container(
              color: Colors.white10,
              alignment: AlignmentDirectional.centerStart,
              child: CardStudents(studentsList[posicion]),
                
              );
          //Icon(Icons.delete, color: Colors.white)),
          
       } );
      }
  
  void _getStudents(BuildContext context, String username, String token) {
    showStudents(username, token,context).then((studt) {
      for (var i = 0; i < studt.length; i++) {
      Student newstudent = Student(
          id: studt[i].id,
          name: studt[i].name,
          username: studt[i].username,
          email: studt[i].email);
          setState(() {
          studentsList.add(newstudent);    
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
