// import 'package:budget_tracker_ui/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import '../providers/userprovider.dart';
import '../loginpage.dart';
import 'package:get_storage/get_storage.dart';

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
                                  progressColor:
                                      Color.fromARGB(255, 23, 175, 89),
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
                                          image: NetworkImage(
                                              "https://images.unsplash.com/photo-1531256456869-ce942a665e80?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTI4fHxwcm9maWxlfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60"),
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
                        color: Color.fromARGB(255, 23, 175, 89),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 23, 175, 89),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.96,
                    height: MediaQuery.of(context).size.width * 0.15,
                    margin: EdgeInsets.all(20),
                    child: FlatButton(
                        color: Color.fromARGB(255, 185, 189, 187),
                        onPressed: () => {print("ตั้งค่า")},
                        child: Row(children: <Widget>[
                          Icon(Icons.settings),
                          Text("ตั้งค่า")
                        ]))),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.96,
                    height: MediaQuery.of(context).size.width * 0.15,
                    margin: EdgeInsets.all(20),
                    child: FlatButton(
                        color: Color.fromARGB(255, 185, 189, 187),
                        onPressed: () {
                          print("ออกจากระบบ");
                          storage.remove('uid');
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: Row(children: <Widget>[
                          Icon(Icons.logout),
                          Text("ออกจากระบบ")
                        ]))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
