import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
// import '../providers/userprovider.dart';
import '../constants/addressAPI.dart';

import 'package:provider/provider.dart';
import '../providers/userprovider.dart';

import './listmenupage/generate.dart';
import 'package:get_storage/get_storage.dart';

class Parkinghistory_page extends StatefulWidget {
  const Parkinghistory_page({Key? key}) : super(key: key);

  @override
  _Parkinghistory_pageState createState() => _Parkinghistory_pageState();
}

class _Parkinghistory_pageState extends State<Parkinghistory_page> {
  final storage = GetStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var parkinghistory = Provider.of<Userprovider>(context).parkinghistory;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 50, right: 15, left: 15, bottom: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "ประวัติการเข้าจอด",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
                children: List.generate(parkinghistory.length, (index) {
              return Card(
                child: Column(children: [
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      height: 60.0,
                      color: Colors.orangeAccent,
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.centerLeft,
                      child: (index == 0)
                          ? Text('ลำดับที่ ${index + 1} ** ล่าสุด',
                              style: const TextStyle(color: Colors.white))
                          : Text('ลำดับที่ ${index + 1}',
                              style: const TextStyle(color: Colors.white))),
                  ListTile(
                      title: Text("สถานะการจอด"),
                      trailing: Text(
                          "${parkinghistory[index]['booking_status']} ",
                          style: TextStyle(fontSize: 16))),
                  ListTile(
                      title: Text("เวลาเข้าจอด"),
                      trailing: (parkinghistory[index]['timeincar'] == null)
                          ? Text("-", style: TextStyle(fontSize: 16))
                          : Text(
                              "${DateTime.parse(parkinghistory[index]['timeincar']).toLocal()} ",
                              style: TextStyle(fontSize: 12))),
                  ListTile(
                      title: Text("เวลาออก"),
                      trailing: (parkinghistory[index]['timeoutcar'] == null)
                          ? Text("-", style: TextStyle(fontSize: 16))
                          : Text(
                              "${DateTime.parse(parkinghistory[index]['timeoutcar']).toLocal()} ",
                              style: TextStyle(fontSize: 12))),
                  Container(
                    height: 5.0,
                    color: Colors.black,
                  ),
                ]),
              );
            })),
          )
        ],
      ),
    ));
  }
}
