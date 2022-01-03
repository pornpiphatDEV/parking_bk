import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import '../providers/userprovider.dart';
import '../loginpage.dart';
import 'package:get_storage/get_storage.dart';

import 'package:http/http.dart' as http;

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  int activeCategory = 0;
  TextEditingController _budgetName =
      TextEditingController(text: "2021-8-1 15:20:00");
  TextEditingController _budgetPrice = TextEditingController(text: "20 บาท");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: grey.withOpacity(0.05),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
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
                  border: Border.all(width: 5, color: Colors.greenAccent),
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
                          "5",
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
                  height: 5,
                ),
                TextField(
                  controller: _budgetName,
                  cursorColor: Colors.black,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
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
                onPressed: () {
                  print('ยืนยันการจอง');
                  // showAlert(context);
                },
                child:
                    const Text('ยืนยันการจอง', style: TextStyle(fontSize: 20)),
                color: Colors.green,
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
