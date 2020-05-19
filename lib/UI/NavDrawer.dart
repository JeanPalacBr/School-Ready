import 'package:flutter/material.dart';
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
                ),Icon(Icons.school,
            size: 100,color: Colors.white,)
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.black,
                ),
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
            leading: Icon(Icons.verified_user),
            title: Text('Check connection'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.delete_forever),
            title: Text('Reset DB'),
            onTap: () => {Navigator.of(context).pop()},
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
}

}