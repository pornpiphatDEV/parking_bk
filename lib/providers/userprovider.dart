import 'package:flutter/material.dart';

class Userprovider extends ChangeNotifier {

  String _email = "";
  String _fname = "";
  String _lname = "";
  int _amount_money = 0;



  String get email => _email;
  String get fname => _fname;
  String get lname => _lname;
  int get amount_money => _amount_money;



  void setuserprovider(String email, String fname , String  lname , int  amount_money ) {
    _email = email;
    _fname = fname;
    _lname = lname;
    _amount_money = amount_money;
    notifyListeners();
  }
}
