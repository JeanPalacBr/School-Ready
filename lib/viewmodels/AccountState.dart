import 'package:flutter/material.dart';
import 'package:login/services/InfoHandler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountState with ChangeNotifier {
  AccountState();

  bool _isLogged = false;
  String _email;
  String _username;
  String _token;
  bool rememberme = false;

  void setLoggedin(String usern, String token, bool log, bool remember) async {
    String exist = "";
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    exist = await sharedusernameget();
    if (exist.length != 0) {
      _isLogged = await sharedLoggedget();
      _username = await sharedusernameget();
      _token = await sharedtokenget();
    } else {
      _token = token;
      _username = usern;
      _isLogged = log;
    }
    if (remember) {
      sharedLoggedset(log);
      sharedtokenset(token);
      sharedusernameset(usern);
    }

    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setToken(String token) {
    _token = token;
    notifyListeners();
  }

  void setUsername(String username) {
    _username = username;
    notifyListeners();
  }

  void setLogged(bool log) {
    _isLogged = log;
    notifyListeners();
  }

  void setRememberMe(bool remember) {
    rememberme = remember;
    notifyListeners();
  }

  void setLogout() {
    _isLogged = false;
    notifyListeners();
  }

  auth() async {
    bool valid = false;

    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    _isLogged = sharedpref.getBool("isloggeda") ?? false;
    if (_isLogged) {
      _username = await sharedusernameget();
      _token = await sharedtokenget();
      checkToken(_token).then((validity) {
        valid = validity.valid;
        if (valid) {
        _isLogged = true;
      } else {
        _isLogged = false;
      }
      });
    } else {
      _isLogged = false;
    }
    notifyListeners();
  }

  bool get getlogin => _isLogged;
  String get getEmail => _email;
  String get getUsername => _username;
  String get getToken => _token;
  bool get getrememberMe => rememberme;
  Future<String> sharedtokenget() async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    return sharedpref.getString("tokn");
  }

  Future<String> sharedusernameget() async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    return sharedpref.getString("usrname");
  }

  Future<bool> sharedLoggedget() async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    return sharedpref.getBool("isloggeda") ?? false;
  }

  Future<bool> sharedtokenset(String token) async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    return sharedpref.setString("tokn", token);
  }

  Future<bool> sharedusernameset(String username) async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    return sharedpref.setString("usrname", username);
  }

  Future<bool> sharedLoggedset(bool log) async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    return sharedpref.setBool("isloggeda", log);
  }
}
