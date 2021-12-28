// @dart=2.9
import 'dart:ui';
import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'package:provider/provider.dart';
import 'providers/userprovider.dart';

void main() {
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
