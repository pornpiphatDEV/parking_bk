import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Userprovider extends ChangeNotifier {
  String _email = "";
  String _prefix = "";
  String _fname = "";
  String _lname = "";
  int _amountmoney = 0;
  List _usagehistory = [];
  List _parkinghistory = [];
  String get email => _email;
  String get prefix => _prefix;
  String get fname => _fname;
  String get lname => _lname;
  int get amountmoney => _amountmoney;
  List get usagehistory => _usagehistory;
  List get parkinghistory => _parkinghistory;

  void setuserprovider(String email, String prefix, String fname, String lname,
      int amountmoney) {
    _email = email;
    _prefix = prefix;
    _fname = fname;
    _lname = lname;
    _amountmoney = amountmoney;
    notifyListeners();
  }

  void booking_setmoney() {
    _amountmoney = amountmoney - 20;
    notifyListeners();
  }

  void pay_setmoney(int servicecharge) {
    _amountmoney = amountmoney - servicecharge;
    notifyListeners();
  }

  void getusagehistory(value) {
    _usagehistory = value;
    notifyListeners();
  }

  void getparkinghistory(value) {
    _parkinghistory = value;
    notifyListeners();
  }

  void setusername(
    String fname,
    String lname,
  ) {
    _fname = fname;
    _lname = lname;

    notifyListeners();
  }
}
