import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import '../providers/userprovider.dart';
import '../loginpage.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../function/socker.dart';
import '../constants/addressAPI.dart';
import '../Popup/customddalog.dart';
// import './listmenupage/enterparking.dart';
import './listmenupage/generate.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  String limitbooking = '';
  bool isDisabled = true;
  late String currenttime = 'วันที่ - เดือน - ปี - 00:00:00';
  


  void getlimitbooking() async {
    final response = await http.get(
      Uri.parse('${addressAPI.news_urlAPI2}'),
    );
    final resstatusCode = response.statusCode;
    final responseJson = jsonDecode(response.body..toString());

    setState(() {
      limitbooking = '${responseJson[0]['limitbooking']}';
      if (responseJson[0]['limitbooking'] == 0) {
        isDisabled = false;
      } else {
        isDisabled = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: grey.withOpacity(0.05),
      body: getBody(),
    );
  }

  final dateStr = DateFormat('วันที่ d เดือน MMM ปี y - kk:mm:ss', 'th')
      .format(DateTime.now());

  @override
  void initState() {
    super.initState();

    print("initstate");
    // contentToServer();
    getlimitbooking();
    setState(() {
      currenttime = dateStr.toString();
    });

    socket.on('bookingrights2', (data) {
      print('bookingrights2');
      print(data);
      setState(() {
        limitbooking = '$data';
        if (data == 0) {
          isDisabled = false;
        } else {
          isDisabled = true;
        }
      });
    });

    
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didUpdateWidget');
  }

  @override
  void dispose() {
    // mytimer.cancel();
    super.dispose();
    print('dispose');
  }

  Widget getBody() {


    var size = MediaQuery.of(context).size;
    final storage = GetStorage();



    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 50, right: 20, left: 20, bottom: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "จองที่จอดรถ",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),

                          // Icon(Icons.logout)
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: Container(
              margin: EdgeInsets.only(
                left: 10,
              ),
              width: 350,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 5, color: Colors.orangeAccent),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                              top: 1,
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/images/auto.png',
                                width: 30,
                                height: 30,
                                fit: BoxFit.contain,
                              ),
                            )),
                        Padding(
                          padding: EdgeInsets.only(top: 1, right: 40),
                          child: Text(
                            "จำนวนช่องจอดที่ว่าง",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),

                        // Icon(AntDesign.search1)s
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(),
                      child: Center(
                        child: Text(
                          "${limitbooking}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "เวลาที่เข้าจอด",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Color(0xff67727d)),
                ),
                Text(
                  "*หมายเหตุ สแกนคิวอาร์โค้ดหลังจากเวลาจองไม่เกิน 1 ชั่วโมง 15นาที",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                      color: Colors.red),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromARGB(255, 230, 178, 122))),
                  child:
                      Text('${currenttime} ', style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ชำระค่าการจองจำนวน  20 บาท",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Color(0xff67727d)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(),
            child: Center(
              child: RaisedButton(
                onPressed: isDisabled
                    ? () async {
                        var userid = storage.read("uid").toString();

                        var url =
                            Uri.parse('${addressAPI.news_urlAPI2}/booking');
                        try {
                          var response = await http.post(url, body: {
                            "userid": userid,
                          });
                          print('Response status: ${response.statusCode}');
                          print('Response body: ${response.body}');

                          if (response.statusCode == 401) {
                            var message = jsonDecode(response.body);
                            print(message['message']);

                            if (message['message'] ==
                                'has already been reserved in the system.') {
                              await showDialog(
                                context: context,
                                builder: (BuildContext context) => CustomDialog(
                                  title: "ไม่สาารถจองได้",
                                  description: "ท่านได้ทำการจองสิทธ์ไว้แล้ว",
                                  buttonText: "clear",
                                ),
                              );
                            } else if (message['message'] ==
                                'have been parked in the parking.') {
                              await showDialog(
                                context: context,
                                builder: (BuildContext context) => CustomDialog(
                                  title: "ไม่สาารถจองได้",
                                  description: "ท่านได้ทำการเข้าจอดแล้ว",
                                  buttonText: "clear",
                                ),
                              );
                            }else if (message['message'] ==
                                'lower limit than we set.') {
                              await showDialog(
                                context: context,
                                builder: (BuildContext context) => CustomDialog(
                                  title: "ไม่สาารถจองได้",
                                  description: "วงเงินต่ำกาว่าที่เรากำหนด",
                                  buttonText: "clear",
                                ),
                              );
                            }




  
                          } else if (response.statusCode == 200) {
                            var url2 = Uri.parse(
                                '${addressAPI.news_urlAPI1}/bookingtime/bookingqrcode');
                            var response2 = await http.post(url2, body: {
                              "userid": userid,
                            });
                            print('Response status: ${response2.statusCode}');
                            print('response2 body: ${response2.body}');

                            var res = jsonDecode(response2.body..toString());
                            print(res);

                            Provider.of<Userprovider>(context, listen: false)
                                .booking_setmoney();

                            await showDialog(
                              context: context,
                              builder: (BuildContext context) => CustomDialog(
                                title: "สำเร็จ",
                                description: "ท่านได้ทำการจองสิทธืสำเร็จแล้ว",
                                buttonText: "OK",
                              ),
                            );

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        GeneratePage(valuesFrom: res)));
                          }
                        } catch (e) {
                          print(e);
                        }
                      }
                    : null,
                child:
                    const Text('ยืนยันการจอง', style: TextStyle(fontSize: 20)),
                color: Colors.orange,
                textColor: Colors.white,
                elevation: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
