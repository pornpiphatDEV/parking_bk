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

class Memupage extends StatefulWidget {
  const Memupage({Key? key}) : super(key: key);

  @override
  _MemupageState createState() => _MemupageState();
}

class _MemupageState extends State<Memupage> {
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
                        height: 25,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Card(
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () async {
                            var email = context.read<Userprovider>().email;

                            print("Card Clicked");
                            var url2 = Uri.parse(
                                '${addressAPI.news_urlAPI1}/bookingtime/bookingqrcode');
                            var response2 = await http.post(url2, body: {
                              "email": email,
                            });
                            print('Response status: ${response2.statusCode}');
                            print('response2 body: ${response2.body}');

                            var res = jsonDecode(response2.body..toString());
                           

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        GeneratePage(valuesFrom: res)));

                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             GeneratePage(valuesFrom: res)));
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => GeneratePage()));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    16.0, 12.0, 16.0, 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 5),
                                    Image.asset('assets/images/qr-code1.png',
                                        width: 100, height: 120),
                                    const SizedBox(height: 15.0),
                                    Text(
                                      '    สแกนเข้าลานจอดรถ ',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () {
                            print("Card Clicked");
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    16.0, 12.0, 16.0, 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 5),
                                    Image.asset(
                                        'assets/images/qrcode-parking.png',
                                        width: 100,
                                        height: 120),
                                    const SizedBox(height: 15.0),
                                    Text(
                                      '    สแกนออกลานจอดรถ ',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Card(
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () {
                            print("Card Clicked");
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    16.0, 12.0, 16.0, 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 5),
                                    Image.asset('assets/images/signage.png',
                                        width: 150, height: 120),
                                    const SizedBox(height: 15.0),
                                    Text(
                                      '         ที่ตั้งลานจอดรถ ',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
