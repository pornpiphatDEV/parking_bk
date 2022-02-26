import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
// import 'dart:ui';
// import 'package:flutter/rendering.dart';

import '/Popup/customddalog.dart';
import '/constants/addressAPI.dart';
import 'package:http/http.dart' as http;

class GeneratePage extends StatefulWidget {
  final valuesFrom;

  // var bookingtime = "";
  const GeneratePage({Key? key, this.valuesFrom}) : super(key: key);
  // ignore: avoid_types_as_parameter_names, non_constant_identifier_names

  @override
  State<StatefulWidget> createState() => GeneratePageState();
}

class GeneratePageState extends State<GeneratePage> {
  String qrData = "";
  var bookingtime = null;
  var expirationtime = null;

  var list = [
    DateTime.now().add(Duration(days: 3)),
    DateTime.now().add(Duration(days: 2)),
  ];

  var t = DateTime.now().add(Duration(days: 3));
  var t2 = DateTime.now().add(Duration(days: 2));
  late Timer mytimer;
  @override
  void initState() {
    super.initState();
    print('initState');
    print('${widget.valuesFrom}');

    setState(() {
      qrData = widget.valuesFrom['booking_code'];
      bookingtime = DateTime.parse(widget.valuesFrom['bookingtime']);
      expirationtime = DateTime.parse(widget.valuesFrom['expirationtime']);
    });
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose');
    mytimer.cancel();
  }

  // already generated qr code when the page opens

  @override
  Widget build(BuildContext context) {
    mytimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        final now = DateTime.now().toLocal();

        DateTime dt2 = DateTime.parse("${expirationtime}");

        if (now.compareTo(dt2) > 0) {
          print("now is after DT2");

          var url2 = Uri.parse('${addressAPI.news_urlAPI2}/qrcodeexpire');
          var response2 = await http.post(url2, body: {
            "qrcodeid": '${widget.valuesFrom['qrcodeid']}',
          });
          print('Response status: ${response2.statusCode}');
          print('response2 body: ${response2.body}');

          if (response2.statusCode == 403) {
            var res = jsonDecode(response2.body..toString());
            print(res);

            Navigator.pop(context);

            showDialog(
              context: context,
              builder: (BuildContext context) => CustomDialog(
                title: "QR หมดอายุการใช้งานแล้ว",
                description: "ท่านต้องทำการจองใหม่อีกครั้ง",
                buttonText: "OK",
              ),
            );
          } else {
            Navigator.pop(context);

            showDialog(
              context: context,
              builder: (BuildContext context) => CustomDialog(
                title: "ท่านได้เข้าจอดแล้ว",
                description: "รอชำระค่าบริการ",
                buttonText: "OK",
              ),
            );
          }
        }
      },
    );
    return Scaffold(
      appBar: AppBar(
          title: Text('สะแกนเข้าจอด'),
          actions: <Widget>[],
          backgroundColor: Colors.orange),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Center(
              child: QrImage(
                //plce where the QR Image will be shown
                data: qrData,
                size: 200.0,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
              "รายละเอียดการจอง",
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "เวลาการจอง",
              style: TextStyle(fontSize: 12.0),
            ),
            SizedBox(height: 5.00),
            Text(
              "${bookingtime.toLocal()}",
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.00),
            Text(
              "เวลาการหมดอายุการจอง",
              style: TextStyle(fontSize: 12.0),
            ),
            SizedBox(height: 5.00),
            Text(
              "${expirationtime.toLocal()}",
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10.00),
            Padding(
              padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
              child: FlatButton(
                padding: EdgeInsets.all(15.0),
                onPressed: () async {
                  showAlert(context, '${widget.valuesFrom['qrcodeid']}');
                },
                child: Text(
                  "ยกเลิกการดำเนินการ",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.red, width: 3.0),
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            )
          ],
        ),
      ),
    );
  }

  final qrdataFeed = TextEditingController();
}

showAlert(BuildContext context, String qrcodeid) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('ยกเลิกการจอง'),
        content: Text("คุณต้องการยอกเลิกการจองหรือไม่"),
        actions: <Widget>[
          FlatButton(
            child: Text("YES"),
            onPressed: () async {
              //Put your code here which you want to execute on Yes button click.

              var url = Uri.parse('${addressAPI.news_urlAPI2}/qrcodecancel');
              try {
                var response = await http.post(url, body: {
                  "qrcodeid": qrcodeid,
                });
                print('Response status: ${response.statusCode}');
                print('Response body: ${response.body}');
                // Navigator.pop(context);

                // await showDialog(
                //   context: context,
                //   builder: (BuildContext context) => CustomDialog(
                //     title: "ไม่สามารถยกเลิกได้",
                //     description: "ท่านได้ทำการเข้าจอดแล้ว",
                //     buttonText: "OK",
                //   ),
                // );

                if (response.statusCode != 200) {
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) => CustomDialog(
                      title: "ไม่สามารถยกเลิกได้",
                      description: "ท่านได้ทำการเข้าจอดแล้ว",
                      buttonText: "OK",
                    ),
                  );
                  Navigator.pop(context);
                } else {
                  Navigator.pop(context);
                }
              } catch (e) {
                print(e);
              }
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text("NO"),
            onPressed: () {
              //Put your code here which you want to execute on No button click.
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
