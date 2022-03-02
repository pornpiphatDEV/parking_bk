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

class Usagehistory_page extends StatefulWidget {
  const Usagehistory_page({Key? key}) : super(key: key);

  @override
  _Usagehistory_pageState createState() => _Usagehistory_pageState();
}

class _Usagehistory_pageState extends State<Usagehistory_page> {
  final storage = GetStorage();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  
  }

  @override
  Widget build(BuildContext context) {
    var usagehistory = Provider.of<Userprovider>(context).usagehistory;
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
                            "ประวัติการใช้งาน",
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
                children: List.generate(usagehistory.length, (index) {
              return Card(
                child: Column(children: [
                  SizedBox(
                    height: 5,
                  ),                  
                  Container(
                    height: 60.0,
                    color: Colors.orange,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.centerLeft,
                    child:(index == 0)? Text('ลำดับที่ ${index + 1} ** ล่าสุด',style: const TextStyle(color: Colors.white)): Text('ลำดับที่ ${index + 1}',style: const TextStyle(color: Colors.white))
                  ),
                  ListTile(
                      title: Text("ค่าการจองสิทธ์"),
                      trailing:
                          Text("20 บาท ", style: TextStyle(fontSize: 12))),
                  ListTile(
                      title: Text("เวลาเข้าจอด"),
                      trailing: Text(
                          "${DateTime.parse(usagehistory[index]['timeincar']).toLocal()} ",
                          style: TextStyle(fontSize: 12))),
                  ListTile(
                      title: Text("เวลาออก"),
                      trailing: Text(
                          "${DateTime.parse(usagehistory[index]['timeoutcar']).toLocal()} ",
                          style: TextStyle(fontSize: 12))),
                  ListTile(
                      title: Text("จำนวนชั่วโมงที่จอด"),
                      trailing:
                          Text("${usagehistory[index]['hourincar']}", style: TextStyle(fontSize: 12))),
                  ListTile(
                      title: Text("ค่าบริการที่ชำระแล้ว"),
                      trailing: Text("${usagehistory[index]['servicecharge']} บาท ", style: TextStyle(fontSize: 12))),
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
