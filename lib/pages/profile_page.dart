// import 'package:budget_tracker_ui/theme/colors.dart';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import '../providers/userprovider.dart';
import '../loginpage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:restart_app/restart_app.dart';
import './setups/setupuserinformation_page.dart';
import './setups/repassword_page.dart';
import './setups/recarregister_page.dart';
import './setups/userinformation_page.dart';
import 'package:http/http.dart' as http;
import 'package:parking_bk/constants/addressAPI.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final storage = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    var prefix = Provider.of<Userprovider>(context).prefix;
    var fname = Provider.of<Userprovider>(context).fname;
    var lname = Provider.of<Userprovider>(context).lname;
    var email = Provider.of<Userprovider>(context).email;
    var amountmoney = Provider.of<Userprovider>(context).amountmoney;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.white,
                spreadRadius: 10,
                blurRadius: 3,
                // changes position of shadow
              ),
            ]),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 60, right: 20, left: 20, bottom: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Profile",
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
                  Row(
                    children: [
                      Container(
                        width: (size.width - 40) * 0.4,
                        child: Container(
                          child: Stack(
                            children: [
                              RotatedBox(
                                quarterTurns: -2,
                                child: CircularPercentIndicator(
                                  circularStrokeCap: CircularStrokeCap.round,
                                  backgroundColor: Colors.white,
                                  radius: 110.0,
                                  lineWidth: 6.0,
                                  percent: 0.53,
                                  progressColor: Colors.orange,
                                ),
                              ),
                              Positioned(
                                top: 16,
                                left: 13,
                                child: Container(
                                  width: 85,
                                  height: 85,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/users.png'),
                                          fit: BoxFit.cover)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: (size.width - 40) * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "$prefix $fname $lname",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "email : $email",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black.withOpacity(0.4)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.orange,
                            spreadRadius: 10,
                            blurRadius: 3,
                            // changes position of shadow
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 25, bottom: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ยอดเงินล่าสุด",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "$amountmoney บาท",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.account_circle_rounded),
              title: Text('ข้อมูลผู้ใช้งาน'),
              onTap: () async {
                final response = await http.get(
                  Uri.parse('${addressAPI.news_urlAPI1}/users/userinformation'),
                  headers: {'userid': storage.read("uid").toString()},
                );
                final resstatusCode = response.statusCode;
                final responseJson = jsonDecode(response.body..toString());

                print(resstatusCode);

                if (resstatusCode == 200) {
                  print(responseJson);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Userinformation_page(value:responseJson)));
                }
              },
            ),
          ),
          Card(
            child: ExpansionTile(
              leading: Icon(Icons.settings),
              title: Text('ตั้งค่าผู้ใช้งาน'),
              children: <Widget>[
                ListTile(
                  leading: Text(''),
                  title: Text('ข้อมูลส่วนตัวและข้อมูลบัญชี'),
                  onTap: () async {
                    // print("Card Clicked");

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Setupuserinformation_page()));
                  },
                ),
                ListTile(
                  leading: Text(''),
                  title: Text('ข้อมูลรถผู้ใช้งาน'),
                  onTap: () async {
                    // print("Card Clicked");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Recarregister_page()));
                  },
                ),
                ListTile(
                  leading: Text(''),
                  title: Text('เปลี่ยนรหัสผ่าน'),
                  onTap: () async {
                    // print("Card Clicked");

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Repassword_page()));
                  },
                ),
              ],
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text('ออกจากระบบ'),
              onTap: () async {
                print("ออกจากระบบ");

                await storage.remove('uid');
                var uid = await storage.read('uid');

                storage.listen(() {
                  print('box changed');
                });

                if (uid == null) {
                  Restart.restartApp();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
