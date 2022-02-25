import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'loginpage.dart';
import 'carregisterpage.dart';
import 'agreementpage.dart';
import 'creditcard.dart';
import 'root_app.dart';

import 'package:get_storage/get_storage.dart';
import './function/socker.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'Popup/customddalog.dart';

import 'package:http/http.dart' as http;

import 'package:parking_bk/constants/addressAPI.dart';

class Splash extends StatefulWidget {
  @override
  VideoState createState() => VideoState();
}

class VideoState extends State<Splash> with SingleTickerProviderStateMixin {
  var _visible = true;

  late AnimationController animationController;
  late Animation<double> animation;
  final storage = GetStorage();

  // Bookingrightsproviderprovider model = Bookingrightsproviderprovider();
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    // storage.read("uid").toString();

    final bool isConnected = await InternetConnectionChecker().hasConnection;

    if (isConnected) {
      if (storage.read("uid") != null) {
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => RootApp()));

        final response = await http.get(
          Uri.parse('${addressAPI.news_urlAPI1}/users/userId'),
          headers: {'userid': storage.read("uid").toString()},
        );
        final resstatusCode = response.statusCode;
        final responseJson = jsonDecode(response.body..toString());
        final status_agreement = responseJson[0]["status_agreement"];
        if (status_agreement != 0) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => RootApp()));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => Agreementpage()));
        }

        print(responseJson);
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    } else {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CustomDialog(
          title: "ไม่มีการเชื่อมต่ออินเตอร์เน๊ต",
          description: "กรุณาเชื่อมต่ออินเตอร์เน๊ต",
          buttonText: "clear",
        ),
      );
      exit(0);
    }
  }

  @override
  void initState() {
    super.initState();

    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 1));
    animation =
        new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();

    print('initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Image.asset(
                    'assets/logo_KMUTNB.png',
                    height: 25.0,
                    fit: BoxFit.scaleDown,
                  )),
              Text("Parking KMUTNB APP")
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/logo_pn_bangkok.png',
                width: animation.value * 250,
                height: animation.value * 250,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
