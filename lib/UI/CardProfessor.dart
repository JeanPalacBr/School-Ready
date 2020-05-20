import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/Models/professor.dart';
import 'package:login/UI/ProfessorDetails.dart';
import 'package:login/viewmodels/AccountState.dart';
import 'package:provider/provider.dart';

class CardProfessor extends StatelessWidget {
  final Professor profes;
  CardProfessor(this.profes);
  @override
  Widget build(BuildContext context) {
    final acStates = Provider.of<AccountState>(context);
    return InkWell(
        onTap: () {
          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfessorDetails(
                        profeid:profes.id??"",
                        username: acStates.getUsername??"",
                        logged: acStates.getlogin??"",
                        token: acStates.getToken??"",
                      )));
        },
        child: Card(
            color: const Color(0xff167F67),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
                child: Column(
              children: <Widget>[
                padding(
                    Text("Professor ID: " + profes.id.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 18.0)),
                    1),
                Text("Name: " + profes.name,
                    style: TextStyle(color: Colors.white, fontSize: 18.0)),
                Text("Username: " + profes.username,
                    style: TextStyle(color: Colors.white, fontSize: 18.0)),
                padding(
                    Text("Email:" + profes.email,
                        style: TextStyle(color: Colors.white, fontSize: 18.0)),
                    2),
              ],
            ))));
  }

  Widget padding(Widget widget, int t, [String typeTodo]) {
    Widget pa;
    switch (t) {
      case 1:
        pa =
            Padding(padding: EdgeInsets.fromLTRB(10, 30, 10, 5), child: widget);
        break;
      case 2:
        pa =
            Padding(padding: EdgeInsets.fromLTRB(10, 5, 10, 30), child: widget);
        break;
    }

    return pa;
  }
}
