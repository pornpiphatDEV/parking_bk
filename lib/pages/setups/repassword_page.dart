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

class Repassword_page extends StatefulWidget {
  const Repassword_page({Key? key}) : super(key: key);

  @override
  _Repassword_pageState createState() => _Repassword_pageState();
}

class _Repassword_pageState extends State<Repassword_page> {
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
                        Text("เปลี่ยนรหัสผ่าน", style: TextStyle(fontSize: 20)),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _pass,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                              keyboardType: TextInputType.text,
                              obscureText: hidePassword,
                              decoration: InputDecoration(
                                hintText: "Password",
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
                                  Icons.lock,
                                  color: Colors.orange,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      hidePassword = !hidePassword;
                                    });
                                  },
                                  color: Colors.orange,
                                  icon: Icon(hidePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'กรุณาป้อยข้อมูล';
                                } else if (value.length <= 5) {
                                  return 'รหัสผ่านควรมี 5  ตัวอักษรขึ้นไป';
                                }
                              },
                              onSaved: (password) {
                                myuser.password = password!;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                                controller: _confirmPass,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                                keyboardType: TextInputType.text,
                                obscureText: hideConfirmPassword,
                                decoration: InputDecoration(
                                  hintText: "Confirm Password",
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
                                    Icons.vpn_key,
                                    color: Colors.orange,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        hideConfirmPassword =
                                            !hideConfirmPassword;
                                      });
                                    },
                                    color: Colors.orange,
                                    icon: Icon(hideConfirmPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณาป้อยข้อมูล';
                                  } else if (value != _pass.text) {
                                    return 'รหัสผ่านไม่ตรงกัน';
                                  }
                                }),
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
                                        "password": myuser.password,
                                      };
                                      print(users);

                                      var url = Uri.parse(
                                          '${addressAPI.news_urlAPI1}/users/repassword');
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
                                                  "เปลี่ยนรหัสผ่านสำเร็จ",
                                              buttonText: "clear",
                                            ),
                                          );

                                          Navigator.pop(context);
                                        } else if (response.statusCode == 401) {
                                          print("Password มีคนใช้งานแล้ว");

                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                CustomDialog(
                                              title:
                                                  "ผิดพลาด",
                                              description:
                                                  "กรุณาป้อน password ใหม่อีกครั้ง",
                                              buttonText: "clear",
                                            ),
                                          );
                                        }
                                      } catch (e) {
                                        print(e);
                                      }

                                      // httppost(users, context);
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
