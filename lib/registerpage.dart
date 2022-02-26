import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'model/users.dart';
import 'Popup/customddalog.dart';
import 'agreementpage.dart';
import 'package:get_storage/get_storage.dart';
import './constants/addressAPI.dart';
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  bool hidePassword = true;
  bool hideConfirmPassword = true;

  final storage = GetStorage();

  Users myuser =
      Users(prefix: '', firstname: '', lastname: '', email: '', password: '');
  // String dropdownvalue = 'Apple';
  var prefixitems = [
    'นาย',
    'นางสาว',
    'นาง',
  ];


  @override
  void initState()  {

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
                        Image.asset(
                          'assets/logo_pn_bangkok.png',
                          width: 150,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            FormBuilderDropdown(
                              name: 'gender',
                              allowClear: true,
                              hint: Text('คำนำหน้า'),
                              //  hintText: 'Hint Text',
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.view_carousel_outlined,
                                  color: Colors.orange,
                                ),
                              ),

                              items: prefixitems
                                  .map((prefix) => DropdownMenuItem(
                                        onTap: () {
                                          myuser.prefix = prefix;
                                          print(myuser.prefix);
                                        },
                                        value: prefix,
                                        child: Text('$prefix'),
                                      ))
                                  .toList(),

                              validator: (value) {
                                if (value == null) {
                                  return 'กรุณาเลือกคำนำหน้า';
                                }
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
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
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: "Email Address",
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
                                  Icons.email,
                                  color: Colors.orange,
                                ),
                              ),
                              validator: MultiValidator([
                                EmailValidator(
                                    errorText: "รูปแบบอีเมลไม่ถูกต้อง"),
                                RequiredValidator(errorText: "กรุณาป้อนอีเมล")
                              ]),
                              onSaved: (email) {
                                myuser.email = email!;
                              },
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

                                      Map<String, String> users = {
                                        "prefix": myuser.prefix,
                                        "firstname": myuser.firstname,
                                        "lastname": myuser.lastname,
                                        "email": myuser.email,
                                        "password": myuser.password,
                                      };
                                      print(users);
                                      var url = Uri.parse(
                                          '${addressAPI.news_urlAPI1}/users/register');
                                      try {
                                        var response =
                                            await http.post(url, body: users);
                                        print(
                                            'Response status: ${response.statusCode}');
                                        print(
                                            'Response body: ${response.body}');

                                        if (response.statusCode == 201) {
                                          print("เพิ่มข้อมูลสำเร็จ");
                                          var res = jsonDecode(response.body);
                                          print(res[0]['id']);
                                          storage.write('uid', res[0]['id']);

                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Agreementpage()));
                                        } else if (response.statusCode == 401) {
                                          print("email มีคนใช้งานแล้ว");

                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                CustomDialog(
                                              title:
                                                  "อีเมลล์ นี้มีคนใช้งานแล้ว",
                                              description:
                                                  "กรุณาป้อนอีเมลล์ใหม่อีกครั้ง",
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
                                  color: Color(0xFF1FB684),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Text(
                                    "Registerp",
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

