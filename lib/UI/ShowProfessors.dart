import 'package:flutter/material.dart';
import 'package:login/Models/professor.dart';
import 'package:login/UI/CardProfessor.dart';
import 'package:login/UI/NavDrawer.dart';
import 'package:login/services/InfoHandler.dart';
import 'package:login/UI/Login.dart';
import 'package:login/viewmodels/AccountState.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login.dart';

class ShowProfessors extends StatefulWidget {
  @override
  ShowProfessorsState createState() => ShowProfessorsState();
}

class ShowProfessorsState extends State<ShowProfessors> {
  List<Professor> professorsList = new List<Professor>();
  final acState = Provider.of<AccountState>(contextsc);
  @override
  void initState() {
    super.initState();
    acState.getlogin ? ShowProfessors() : Islogged();
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
      itemCount: professorsList.length,
      itemBuilder: (context, posicion) {       
        return Container(
              color: Colors.white10,
              alignment: AlignmentDirectional.centerStart,
              child: CardProfessor(professorsList[posicion]),
                
              );
          //Icon(Icons.delete, color: Colors.white)),
          
       } );
      }
  
  void _getStudents(BuildContext context, String username, String token) {
    showProfessors(username, token).then((profes) {
      for (var i = 0; i < profes.length; i++) {
      Professor newprofe = Professor(
          id: profes[i].id,
          name: profes[i].name,
          username: profes[i].username,
          email: profes[i].email);
          setState(() {
          professorsList.add(newprofe);    
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
