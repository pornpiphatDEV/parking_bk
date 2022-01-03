import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'providers/userprovider.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get_storage/get_storage.dart';

import 'pages/profile_page.dart';
import 'pages/booking_page.dart';

class RootApp extends StatefulWidget {
  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  final storage = GetStorage();
  int pageIndex = 0;
  List<Widget> pages = [
    Text("data"),
    Text("data"),
    Text("data"),
    ProfilePage(),
    BookingPage(),
  ];

  void getUser(BuildContext context) async {
    final response = await http.get(
      Uri.parse('http://192.168.0.103:3000/users/userId'),
      headers: {'userid': storage.read("uid").toString()},
    );
    final resstatusCode = response.statusCode;
    final responseJson = jsonDecode(response.body..toString());

    print(resstatusCode);

    if (resstatusCode == 200) {
      print(responseJson);
      final prefix = responseJson[0]["prefix"];
      final firstname = responseJson[0]["firstname"];
      final lastname = responseJson[0]["lastname"];
      final email = responseJson[0]["email"];
      final money = responseJson[0]["money"];

      Provider.of<Userprovider>(context, listen: false)
          .setuserprovider(email, prefix, firstname, lastname, money);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    this.getUser(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: getBody(),
        bottomNavigationBar: getFooter(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            selectedTab(4);
          },
          // ignore: prefer_const_constructors
          child: Icon(
            Icons.add,
            size: 25,
          ),
          backgroundColor: Colors.green,
          //params
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked);
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }

  Widget getFooter() {
    List<IconData> iconItems = [
      Ionicons.md_calendar,
      Ionicons.md_stats,
      Ionicons.md_wallet,
      Ionicons.ios_person,
    ];

    return AnimatedBottomNavigationBar(
      activeColor: Color.fromARGB(255, 92, 226, 146),
      splashColor: Color.fromARGB(255, 92, 226, 146),
      inactiveColor: Colors.black.withOpacity(0.5),
      icons: iconItems,
      activeIndex: pageIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      leftCornerRadius: 10,
      iconSize: 25,
      rightCornerRadius: 10,
      onTap: (index) {
        selectedTab(index);
      },
      //other params
    );
  }

  selectedTab(index) {
    // _incrementCounter(context);
    setState(() {
      pageIndex = index;
      print(index);
    });
  }
}
