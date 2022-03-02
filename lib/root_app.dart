import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:parking_bk/constants/addressAPI.dart';
import 'package:provider/provider.dart';
import 'providers/userprovider.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get_storage/get_storage.dart';

import 'pages/profile_page.dart';
import 'pages/booking_page.dart';
import 'pages/memu_page.dart';
import 'pages/usagehistory_page.dart';
import 'pages/parkinghistory_page.dart';

class RootApp extends StatefulWidget {
  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  final storage = GetStorage();
  int pageIndex = 0;
  bool loop = true;

  List<Widget> pages = [
    Parkinghistory_page(),
    Usagehistory_page(),
    Memu_page(),
    ProfilePage(),
    BookingPage(),
  ];

  void getUser(BuildContext context) async {
    final response = await http.get(
      Uri.parse('${addressAPI.news_urlAPI1}/users/userId'),
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

  void getUsagehistory(BuildContext context) async {
    final response = await http.get(
      Uri.parse('${addressAPI.news_urlAPI1}/users/usagehistory'),
      headers: {'userid': storage.read("uid").toString()},
    );
    final resstatusCode = response.statusCode;
    final responseJson = jsonDecode(response.body..toString());

    print(responseJson);

    if (resstatusCode == 200) {
      Provider.of<Userprovider>(context, listen: false)
          .getusagehistory(responseJson);
    }
  }

  void getParkinghistory(BuildContext context) async {
    final response = await http.get(
      Uri.parse('${addressAPI.news_urlAPI1}/users/parkinghistory'),
      headers: {'userid': storage.read("uid").toString()},
    );
    final resstatusCode = response.statusCode;
    final responseJson = jsonDecode(response.body..toString());

    print(responseJson);

    if (resstatusCode == 200) {
        Provider.of<Userprovider>(context, listen: false)
        .getparkinghistory(responseJson);
    }

  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    this.getUser(context);
    this.getUsagehistory(context);
    this.getParkinghistory(context);
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
          backgroundColor: Colors.orange,
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
      activeColor: Colors.orange,
      splashColor: Colors.orange,
      inactiveColor: Colors.black.withOpacity(0.5),
      icons: iconItems,
      activeIndex: pageIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      leftCornerRadius: 10,
      iconSize: 25,
      rightCornerRadius: 10,
      onTap: (index) {
        if (index == 0) {
      
          this.getParkinghistory(context);
        } else if (index == 1) {
          this.getUsagehistory(context);
        } 
        selectedTab(index);
      },
      //other params
    );
  }

  selectedTab(index) {
    // _incrementCounter(context);

    setState(() {
      pageIndex = index;
    });
  }
}
