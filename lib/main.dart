import 'package:flutter/material.dart';
import 'package:login/UI/Login.dart';
import 'package:provider/provider.dart';
import 'viewmodels/AccountState.dart';
void main() {
  
  
runApp(
  ChangeNotifierProvider(
    
  builder: (context) => AccountState(),  
  
  child:Login(),
  ),
);
}
