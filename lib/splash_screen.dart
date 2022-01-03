import 'dart:async';
import 'package:flutter/material.dart';
import 'loginpage.dart';
import 'carregisterpage.dart';
import 'agreementpage.dart';
import 'creditcard.dart';
import 'root_app.dart';

import 'package:get_storage/get_storage.dart';

class Splash extends StatefulWidget {
  @override
  VideoState createState() => VideoState();
}

class VideoState extends State<Splash> with SingleTickerProviderStateMixin {
  var _visible = true;

  late AnimationController animationController;
  late Animation<double> animation;
  final storage = GetStorage();
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    // storage.read("uid").toString();

    if (storage.read("uid") != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => RootApp()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => LoginPage()));
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => Agreementpage()));
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => RootApp()));
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
