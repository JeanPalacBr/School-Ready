import 'package:flutter/material.dart';
import 'package:login/Models/student.dart';
import 'package:login/viewmodels/AccountState.dart';
import 'package:login/services/InfoHandler.dart';
import 'package:provider/provider.dart';
import 'package:login/UI/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login.dart';

class ProfessorDetails extends StatefulWidget {
  int profeid;
  ProfessorDetails(this.profeid);
  @override
  ProfessorDetailsstate createState() => ProfessorDetailsstate(profeid);
}

class ProfessorDetailsstate extends State<ProfessorDetails> {
  int profeid;
  int profidcourse;
  String profname;
  String profusername;
  String profemail;
  String profphone;
  String profcity;
  String profcountry;
  String profbirthday;
  ProfessorDetailsstate(this.profeid);
  List<Student> studentsL = new List<Student>();
  final acState = Provider.of<AccountState>(contextsc);
  @override
  void initState() {
    super.initState();
    acState.getlogin ? ProfessorDetailsstate(profeid) : Islogged();
    _fillProfessorDetails(
        contextsc, acState.getUsername, acState.getToken, profeid);
  }

  @override
  Widget build(BuildContext context) {
    final acState = Provider.of<AccountState>(context);
    return Scaffold(
      appBar: AppBar(title: Text("SchoolReady!"), actions: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  acState.setLogout();
                  sharedreflogoutset();
                });
              },
              child: 
              Row(
                children: <Widget>[Text("Logout"),
                  Icon(
                    Icons.exit_to_app,
                    size: 26.0,
                  ),
                ],
              ),
            ))
      ]),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                acState.getUsername,
                style: TextStyle(fontSize: 18),
              ),
              FlatButton(
                  child: Text("Log Out"),
                  onPressed: () {
                    acState.setLogout();
                    sharedreflogoutset();
                  }),
            ],
          ),
          Container(child: Text("Professor Details")),
          Text(
            "Professor ID: " + profeid.toString(),
            style: TextStyle(fontSize: 21),
          ),
          Text(
            "Username: " + profusername,
            style: TextStyle(fontSize: 21),
          ),
          Text(
            "Name: " + profname,
            style: TextStyle(fontSize: 21),
          ),
          Text(
            "Email: " + profemail,
            style: TextStyle(fontSize: 21),
          ),
          Text(
            "Phone: " + profphone,
            style: TextStyle(fontSize: 21),
          ),
          Text(
            "City: " + profcity,
            style: TextStyle(fontSize: 21),
          ),
          Text(
            "Country: " + profcountry,
            style: TextStyle(fontSize: 21),
          ),
          Text(
            "Birthday: " + profbirthday,
            style: TextStyle(fontSize: 21),
          ),
        ],
      ),
    );
  }

  void _fillProfessorDetails(
      BuildContext context, String username, String token, int courseid) {
    viewProfessor(username, token, courseid).then((profedet) {
      setState(() {
        profidcourse = profedet.idcourse;
        profname = profedet.name;
        profusername = profedet.username;
        profemail = profedet.email;
        profphone = profedet.phone;
        profcity = profedet.city;
        profcountry = profedet.country;
        profbirthday = profedet.birthday;
      });
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
