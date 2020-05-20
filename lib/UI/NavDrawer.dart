import 'package:flutter/material.dart';
import 'package:login/UI/ConnectionDialog.dart';
import 'package:login/UI/Login.dart';
import 'package:login/UI/RestartDBDialog.dart';
import 'package:login/UI/ShowStudents.dart';
import 'package:login/UI/StudentsDetails.dart';
import 'package:login/viewmodels/AccountState.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: <Widget>[
                Text(
                  'School Ready!',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                Icon(
                  Icons.school,
                  size: 100,
                  color: Colors.white,
                )
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.black,
            ),
          ),
          ListTile(
            leading: Icon(Icons.slideshow),
            title: Text('Show Students'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ShowStudents()))
            },
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Search Professor'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Search Student'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.network_check),
            title: Text('Check connection'),
            onTap: () => {_check(context)},
          ),
          ListTile(
            leading: Icon(Icons.delete_forever),
            title: Text('Reset DB'),
            onTap: () => {_restart(context)},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {sharedreflogoutset(context)},
          ),
        ],
      ),
    );
  }

  void sharedreflogoutset(BuildContext context) async {
    final acState = Provider.of<AccountState>(context);
    acState.setLogout();
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    sharedpref.setString("tokn", "");
    sharedpref.setString("usrname", "");
    sharedpref.setBool("isloggeda", false);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Login()),
      (Route<dynamic> route) => false,
    );
  }
  void _restart(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return RestartDBDialog();
        });
  }

  void _check(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ConnectionDialog();
        });
  }
}
