// @dart=2.9
import 'dart:ui';
import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'package:provider/provider.dart';
import 'providers/userprovider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import './function/socker.dart';


void main() {
  Intl.defaultLocale = 'th';
  initializeDateFormatting();
  contentToServer();
  // contentToServer();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(
        value: Userprovider(),
      ),
     
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    ),
  ));
}
