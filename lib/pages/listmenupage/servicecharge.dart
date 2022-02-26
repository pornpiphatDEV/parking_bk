import 'dart:convert';
import 'package:flutter/material.dart';

import '/constants/addressAPI.dart';
import 'package:http/http.dart' as http;
import '/Popup/customddalog.dart';

import 'package:provider/provider.dart';
import '/providers/userprovider.dart';

class Servicecharge extends StatefulWidget {
  final valuesFrom;
  const Servicecharge({Key? key, this.valuesFrom}) : super(key: key);

  @override
  _ServicechargeState createState() => _ServicechargeState();
}

class _ServicechargeState extends State<Servicecharge> {
  var qrcodeid;
  var timeincar;
  var timeoutcar;
  var hrs;
  var mins;
  var servicecharge;

  @override
  void initState() {
    super.initState();
    print('initState');
    print('${widget.valuesFrom}');

    setState(() {
      qrcodeid = widget.valuesFrom['qrcodeid'];
      timeincar = DateTime.parse(widget.valuesFrom['timeincar']);
      timeoutcar = DateTime.parse(widget.valuesFrom['timeoutcar']);
      hrs = widget.valuesFrom['hrs'];
      mins = widget.valuesFrom['mins'];
      servicecharge = widget.valuesFrom['servicecharge'];
      // qrData = widget.valuesFrom['booking_code'];
      // bookingtime = DateTime.parse(widget.valuesFrom['bookingtime']);
      // expirationtime = DateTime.parse(widget.valuesFrom['expirationtime']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('ชำระค่าบริการ'),
          actions: <Widget>[],
          backgroundColor: Colors.orange),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 4,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/logo_pn_bangkok.png"),
                      fit: BoxFit.cover)),
            ),
            Container(
              child: Text(
                "ค่าบริการชั่วโมงละ 20 บาท",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Color(0xff67727d)),
              ),
            ),
            SizedBox(height: 10.00),
            ListTile(
                title: Text("เวลาเข้า"),
                trailing: Text("${timeincar.toLocal()}")),
            ListTile(
                title: Text("เวลาออก"),
                trailing: Text("${timeoutcar.toLocal()}")),
            ListTile(
                title: Text("ใช้เวลาในการจอดทั้งหมด"),
                trailing: Text("$hrs ชั่วโมง $mins นาที")),
            ListTile(
                title: Text("รวมค่าบริการทั้งสิน"),
                trailing: Text("$servicecharge บาท ",
                    style: TextStyle(fontSize: 20))),
            SizedBox(height: 10.00),
            Padding(
              padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
              child: FlatButton(
                padding: EdgeInsets.all(15.0),
                onPressed: () async {
                  var result = {
                    "qrcodeid": '$qrcodeid',
                    "servicecharge": '$servicecharge',
                    "userid": '${widget.valuesFrom['userid']}',
                  };

                  showAlert(context, result);
                },
                child: Text(
                  "ชำระค่าบริการ",
                  style: TextStyle(
                      color: Colors.orange, fontWeight: FontWeight.bold),
                ),
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.orange, width: 3.0),
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

showAlert(BuildContext context, var result) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('จ่ายค่าบริการ'),
        content: Text("คุณต้องการจ่ายค่าบริการหรือไม่"),
        actions: <Widget>[
          FlatButton(
            child: Text("YES"),
            onPressed: () async {
              //Put your code here which you want to execute on Yes button click.
              print(result);
              var url = Uri.parse('${addressAPI.news_urlAPI2}/pey');

              //  var response = await http.post(url, body: result);
              //   print('Response status: ${response.statusCode}');
              //   print('Response body: ${response.body}');

              try {
                var response = await http.post(url, body: result);
                print('Response status: ${response.statusCode}');
                print('Response body: ${response.body}');

                if (response.statusCode == 200) {
                  Provider.of<Userprovider>(context, listen: false)
                      .pay_setmoney(int.parse(result['servicecharge']));
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) => CustomDialog(
                      title: "สำเร็จ",
                      description: "ท่านได้ทำการชำระเงินเสร็จสิ้นแล้ว",
                      buttonText: "clear",
                    ),
                  );

                  Navigator.of(context).pop();

                  Navigator.of(context).pop();
                } else {
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) => CustomDialog(
                      title: "ไม่สำเร็จ",
                      description: "ยอดเงินของท่านไม่เพียงพอ",
                      buttonText: "clear",
                    ),
                  );

                  Navigator.of(context).pop();
                }
              } catch (e) {
                print(e);
              }
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
