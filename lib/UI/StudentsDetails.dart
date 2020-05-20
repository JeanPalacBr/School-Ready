import 'package:flutter/material.dart';
import 'package:login/Models/student.dart';
import 'package:login/UI/NavDrawer.dart';
import 'package:login/services/InfoHandler.dart';
import 'package:login/UI/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login.dart';

class StudentsDetails extends StatefulWidget {
  final int studid;
  final String username;
  final String token;
  bool logged;

  StudentsDetails(
      {Key key, @required this.studid, this.username, this.token, this.logged})
      : super(key: key);
  @override
  StudentsDetailsstate createState() => StudentsDetailsstate(
      studid: studid, username: username, logged: logged, token: token);
}

class StudentsDetailsstate extends State<StudentsDetails> {
  int studid;
  int studidcourse;
  String studname;
  String studusername;
  String studemail;
  String studphone;
  String studcity;
  String studcountry;
  String studbirthday;
  String username;
  String token;
  bool logged;
  StudentsDetailsstate(
      {@required this.studid, this.username, this.token, this.logged});
  List<Student> studentsL = new List<Student>();
  @override
  void initState() {
    super.initState();
    if (logged??false) {
      StudentsDetailsstate(studid: studid);
    } else {
      Islogged();
    }
    _fillStudentDetails(
        username??"", token??"", studid??0,context);
  }

  @override
  Widget build(BuildContext context) {
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          headerWidget(),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 36, 8, 15),
            child: Row(
              children: <Widget>[
                Icon(Icons.confirmation_number),
                Text(
                  "Student ID: " + studid.toString(),
                  style: TextStyle(fontSize: 21),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Icon(Icons.person),
                Text(
                  "Username: " + studusername??"",
                  style: TextStyle(fontSize: 21),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Icon(Icons.alternate_email),
                Text(
                  "Email: " + studemail??"",
                  style: TextStyle(fontSize: 21),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Icon(Icons.phone),
                Text(
                  "Phone: " + studphone??"",
                  style: TextStyle(fontSize: 21),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Icon(Icons.location_on),
                Text(
                  "City: " + studcity??"",
                  style: TextStyle(fontSize: 21),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Icon(Icons.location_city),
                Text(
                  "Country: " + studcountry??"",
                  style: TextStyle(fontSize: 21),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Icon(Icons.date_range),
                Text(
                  "Birthday: " + studbirthday??"",
                  style: TextStyle(fontSize: 21),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _fillStudentDetails(
    String username, String token, int studid, BuildContext context) {
    viewStudent(username, token, studid,context).then((studedet) {
      setState(() {
        studidcourse = studedet.idcourse;
        studname = studedet.name;
        studusername = studedet.username;
        studemail = studedet.email;
        studphone = studedet.phone;
        studcity = studedet.city;
        studcountry = studedet.country;
        studbirthday = studedet.birthday;
      });
    }).catchError((error) {
      print(
          "elerrro---> "); //Scaffold.of(context).showSnackBar(SnackBar(content: Text("Error" + error.toString())));
    });
  }

  Widget headerWidget() {
    return new Card(
      elevation: 3,
      color: const Color(0xff167F67),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Center(
            child: new Container(
              margin: EdgeInsets.only(bottom: 5.0),
              height: 20.0,
              width: 80.0,
            ),
          ),
          Text(
            'School Ready!',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          Icon(
            Icons.school,
            size: 100,
            color: Colors.white,
          ),
          new Text(
            "Student Details",
            textAlign: TextAlign.center,
            style: new TextStyle(
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
            child: Text(
              studname??"",
              textAlign: TextAlign.center,
              style: new TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
    //flex: 1,
  }
}

void sharedreflogoutset() async {
  SharedPreferences sharedpref = await SharedPreferences.getInstance();
  sharedpref.setString("tokn", "");
  sharedpref.setString("usrname", "");
  sharedpref.setBool("isloggeda", false);
}
