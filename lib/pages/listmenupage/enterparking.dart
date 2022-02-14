import 'dart:convert';
import 'package:flutter/material.dart';

class Enteparking extends StatefulWidget {
  const Enteparking({Key? key}) : super(key: key);

  @override
  _EnteparkingState createState() => _EnteparkingState();
}

class _EnteparkingState extends State<Enteparking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[300],
          title: Text("Enteparking"),
        ),
    );
  }
}
