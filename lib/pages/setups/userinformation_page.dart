import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
// import '../providers/userprovider.dart';

import 'package:get_storage/get_storage.dart';

class Userinformation_page extends StatefulWidget {
  final value;

  const Userinformation_page({Key? key, this.value}) : super(key: key);

  @override
  _Userinformation_pageState createState() => _Userinformation_pageState();
}

class _Userinformation_pageState extends State<Userinformation_page> {
  final storage = GetStorage();
  late String prefix;
  late String firstname;
  late String lastname;
  late String email;
  late String car_carregistration;
  late String car_bran;
  late String car_colar;
  late String cardNumber;
  late String expiryDate;
  late String cvvCode;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    setState(() {
      prefix = widget.value[0]['prefix'];
      firstname = widget.value[0]['firstname'];
      lastname = widget.value[0]['lastname'];
      email = widget.value[0]['email'];
      car_carregistration = widget.value[0]['car_carregistration'];
      car_bran = widget.value[0]['car_bran'];
      car_colar = widget.value[0]['car_colar'];
      cardNumber = widget.value[0]['cardNumber'];
      expiryDate = widget.value[0]['expiryDate'];
      cvvCode = widget.value[0]['cvvCode'];
    
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 5, right: 15, left: 15, bottom: 25),
                  child: Column(
                    children: [
                      Container(
                        width: 85,
                        height: 85,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage('assets/images/users.png'),
                                fit: BoxFit.cover)),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "ข้อมูลผู้ใช้งาน",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text('ชื่อ-นามสกุล : '),
                                  SizedBox(width: 10.0),
                                  Text(
                                    "$prefix $firstname  $lastname",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 17.0),
                                  )
                                ]),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text('email : '),
                                  SizedBox(width: 10.0),
                                  Text(
                                    "$email",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 17.0),
                                  )
                                ]),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "ข้อมูลบัตรเครดิต",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text('cardNumber : '),
                                  SizedBox(width: 10.0),
                                  Text(
                                    "$cardNumber",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 17.0),
                                  )
                                ]),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text('expiryDate : '),
                                  SizedBox(width: 10.0),
                                  Text(
                                    "$expiryDate",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 17.0),
                                  )
                                ]),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text('CCV : '),
                                  SizedBox(width: 10.0),
                                  Text(
                                    "$cvvCode",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 17.0),
                                  )
                                ]),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "ข้อมูลรถผู้ใช้งาน",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text('ยี่ห้อรถ : '),
                                  SizedBox(width: 10.0),
                                  Text(
                                    "$car_bran",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 17.0),
                                  )
                                ]),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text('ทะเบียนรถ : '),
                                  SizedBox(width: 10.0),
                                  Text(
                                    "$car_carregistration",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 17.0),
                                  )
                                ]),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text('สีรถ : '),
                                  SizedBox(width: 10.0),
                                  Text(
                                    "$car_colar",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 17.0),
                                  )
                                ]),
                          ]),
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
