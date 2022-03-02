import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'dart:async';
import './listmenupage/generate.dart';
import 'package:http/http.dart' as http;
// import '../providers/userprovider.dart';
import '../constants/addressAPI.dart';

import '../providers/userprovider.dart';
import 'package:provider/provider.dart';
import './listmenupage/generate.dart';
import 'package:get_storage/get_storage.dart';
import '../Popup/customddalog.dart';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'listmenupage/servicecharge.dart';

class Memu_page extends StatefulWidget {
  const Memu_page({Key? key}) : super(key: key);

  @override
  _Memu_pageState createState() => _Memu_pageState();
}

class _Memu_pageState extends State<Memu_page> {
  final storage = GetStorage();
  @override
  Widget build(BuildContext context) {
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
                            "เมนู",
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
                  SizedBox(
                    height: 15,
                  ),
                  Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/qr-code1.png'),
                      ),
                      title: Text('สแกนเข้าลานจอดรถ'),
                      onTap: () async {
                        // var email = context.read<Userprovider>().email;
                        var userid = storage.read("uid").toString();

                        var url2 = Uri.parse(
                            '${addressAPI.news_urlAPI2}/bookingqrcodegenerate');
                        var response2 = await http.post(url2, body: {
                          "userid": userid,
                        });
                        print('Response status: ${response2.statusCode}');
                        print('response2 body: ${response2.body}');

                        var res = jsonDecode(response2.body..toString());
                        print(res);

                        switch (response2.statusCode) {
                          case 200:
                            {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          GeneratePage(valuesFrom: res)));
                            }
                            break;
                          case 403:
                            {
                              await showDialog(
                                context: context,
                                builder: (BuildContext context) => CustomDialog(
                                  title: "หมดเวลาการจองแล้ว",
                                  description:
                                      "กรุณาจองสิทธ์การใช้งานใหม่อีกครั้ง",
                                  buttonText: "OK",
                                ),
                              );
                            }
                            break;

                          case 401:
                            {
                              var message = jsonDecode(response2.body);

                              if (message['message'] == 'you have parked') {
                                await showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      CustomDialog(
                                    title: "ท่านได้ทำการเข้าจอด",
                                    description: "กรุณาชำระค่าบริการ",
                                    buttonText: "OK",
                                  ),
                                );
                              } else {
                                await showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      CustomDialog(
                                    title: "ไม่มีการจอง",
                                    description: "กรุณาจองสิทธ์การใช้งานก่อน",
                                    buttonText: "OK",
                                  ),
                                );
                              }
                            }
                            break;

                          default:
                        }
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/qrcode-parking.png'),
                      ),
                      title: Text('สแกนออกลานจอดรถ'),

                      onTap: () async {
                        // print("Card Clicked");

                        // ******************************************************************
                        //  ใช้งาน
                        // ******************************************************************

                        var result = await BarcodeScanner.scan();

                        String qrCodeResultscan = '${result.rawContent}';
                        print(qrCodeResultscan);
                        if (qrCodeResultscan == '6202021511054&6202021521149') {
                          var userid = storage.read("uid").toString();

                          var url2 =
                              Uri.parse('${addressAPI.news_urlAPI2}/chekbill');
                          var response2 = await http.post(url2, body: {
                            "userid": userid,
                          });
                          print('Response status: ${response2.statusCode}');
                          print('response2 body: ${response2.body}');

                          var res = jsonDecode(response2.body..toString());
                          print(res);

                          if (response2.statusCode == 200) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Servicecharge(valuesFrom: res)));
                          } else {
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) => CustomDialog(
                                title: "ผิดพลาด",
                                description: "ท่านยังไม่ทำการเข้าจอด",
                                buttonText: "OK",
                              ),
                            );
                          }
                        } else if (qrCodeResultscan == "") {
                          print("asfsaf");
                        } else {
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) => CustomDialog(
                              title: "ผิดพลาด",
                              description: "กรุณาจลองใหม่อีกครั้ง",
                              buttonText: "OK",
                            ),
                          );
                        }

                        // ******************************************************************

                        // var userid = storage.read("uid").toString();
                        // var url2 =
                        //     Uri.parse('${addressAPI.news_urlAPI2}/chekbill');
                        // var response2 = await http.post(url2, body: {
                        //   "userid": userid,
                        // });
                        // print('Response status: ${response2.statusCode}');
                        // print('response2 body: ${response2.body}');

                        // var res = jsonDecode(response2.body..toString());
                        // print(res);

                        // if (response2.statusCode == 200) {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) =>
                        //               Servicecharge(valuesFrom: res)));
                        // } else {
                        //   await showDialog(
                        //     context: context,
                        //     builder: (BuildContext context) => CustomDialog(
                        //       title: "ผิดพลาด",
                        //       description: "ท่านยังไม่ทำการเข้าจอด",
                        //       buttonText: "OK",
                        //     ),
                        //   );
                        // }
                      },
                      // subtitle: Text(movie.genre),
                      // trailing: Text(movie.year),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
