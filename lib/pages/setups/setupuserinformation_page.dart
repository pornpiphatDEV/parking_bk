import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import '/model/users.dart';
import '/Popup/customddalog.dart';
import '/agreementpage.dart';
import 'package:get_storage/get_storage.dart';
import '/constants/addressAPI.dart';

import 'package:provider/provider.dart';
import '/providers/userprovider.dart';

class Setupuserinformation_page extends StatefulWidget {
  const Setupuserinformation_page({Key? key}) : super(key: key);

  @override
  _Setupuserinformation_pageState createState() =>
      _Setupuserinformation_pageState();
}

class _Setupuserinformation_pageState extends State<Setupuserinformation_page> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  bool hidePassword = true;
  bool hideConfirmPassword = true;

  final storage = GetStorage();

  Users myuser =
      Users(prefix: '', firstname: '', lastname: '', email: '', password: '');
  // String dropdownvalue = 'Apple';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var fname = Provider.of<Userprovider>(context).fname;
    var lname = Provider.of<Userprovider>(context).lname;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
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
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Text("ตั้งค่าบัญชีผู้ชื่อผู้ใช้งาน",
                            style: TextStyle(fontSize: 20)),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              initialValue: fname,
                              decoration: InputDecoration(
                                hintText: "ชื่อจริง",
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary
                                            .withOpacity(0.2))),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary)),
                                prefixIcon: Icon(
                                  Icons.perm_contact_cal,
                                  color: Colors.orange,
                                ),
                              ),
                              onSaved: (String? firstname) {
                                // print("object");
                                // print(firstname);
                                myuser.firstname = firstname!;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'กรุณาป้อยข้อมูล';
                                } else if (value.length <= 1) {
                                  return 'ชื่อควรมีมากกว่า 1 ตัวอักษร';
                                }
                                // return null;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              initialValue: lname,
                              decoration: InputDecoration(
                                hintText: "นามสกุล",
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary
                                            .withOpacity(0.2))),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary)),
                                prefixIcon: Icon(
                                  Icons.person_pin_sharp,
                                  color: Colors.orange,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'กรุณาป้อยข้อมูล';
                                } else if (value.length <= 1) {
                                  return 'นามสกุล ควรมีมากกว่า 1 ตัวอักษร';
                                }
                              },
                              onSaved: (lastname) {
                                myuser.lastname = lastname!;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 70),
                              child: Container(
                                padding: EdgeInsets.only(top: 1, left: 3),
                                child: MaterialButton(
                                  minWidth: double.infinity,
                                  height: 40,
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();

                                      var userid =
                                          storage.read("uid").toString();
                                      Map<String, String> users = {
                                        "userid": userid,
                                        "firstname": myuser.firstname,
                                        "lastname": myuser.lastname,
                                      };
                                      print(users);

                                      var url = Uri.parse(
                                          '${addressAPI.news_urlAPI1}/users/reusername');
                                      try {
                                        var response =
                                            await http.post(url, body: users);
                                        print(
                                            'Response status: ${response.statusCode}');
                                        print(
                                            'Response body: ${response.body}');

                                        if (response.statusCode == 200) {
                                          await showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                CustomDialog(
                                              title: "เสร็จสิน",
                                              description:
                                                  "เปลี่ยนข้อมูลผู้ใช้แล้ว",
                                              buttonText: "clear",
                                            ),
                                          );
                                            Provider.of<Userprovider>(context, listen: false).setusername(myuser.firstname, myuser.lastname);
                                          Navigator.pop(context);
                                        } else if (response.statusCode == 401) {
                                          

                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                CustomDialog(
                                              title: "ผิดพลาด",
                                              description:
                                                  "โปรดลงใหม่อีกครั้ง",
                                              buttonText: "clear",
                                            ),
                                          );
                                        }
                                      } catch (e) {
                                        print(e);
                                      }

                           
                                    }
                                  },
                                  // #1FB684
                                  color: Color.fromARGB(255, 252, 148, 38),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Text(
                                    "ตั้งค่าบัญชี",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SimpleDialog extends StatelessWidget {
  final title;
  SimpleDialog(this.title);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      //title: Text('Alert'),
      content: Text(title),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        new FlatButton(
          child: new Text("Close"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

Widget _buildPopupError(BuildContext context) {
  return new AlertDialog(
    title: const Text('Email นี้ได้ถูกใช้งานแล้ว'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(" กรุณาตรวจสอบ Email"),
      ],
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Close'),
      ),
    ],
  );
}
