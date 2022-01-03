import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'registerpage.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:http/http.dart' as http;
import 'Popup/customddalog.dart';
import 'agreementpage.dart';
import 'package:get_storage/get_storage.dart';
import 'root_app.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  bool hidePassword = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final storage = GetStorage();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          brightness: Brightness.light,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/logo_pn_bangkok.png"),
                                fit: BoxFit.cover)),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            controller: _emailController,
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
                                color: Colors.green,
                              ),
                            ),
                            validator: MultiValidator([
                              EmailValidator(
                                  errorText: "รูปแบบอีเมลไม่ถูกต้อง"),
                              RequiredValidator(errorText: "กรุณาป้อนอีเมล")
                            ]),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary),
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
                                color: Colors.green,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                                color: Colors.green,
                                icon: Icon(hidePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                            ),
                            validator: RequiredValidator(
                                errorText: "กรุณาป้อนรหัสผ่าน"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Text("Forgot Password?",
                                style: TextStyle(color: Colors.green)),
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

                                    print(_emailController.text);
                                    print(_passwordController.text);

                                    Map<String, String> users = {
                                      "email": _emailController.text,
                                      "password": _passwordController.text,
                                    };

                                    var url = Uri.parse(
                                        'http://192.168.0.103:3000/users/login');
                                    try {
                                      var response =
                                          await http.post(url, body: users);
                                      print(
                                          'Response status: ${response.statusCode}');
                                      print('Response body: ${response.body}');

                                      if (response.statusCode == 403) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              CustomDialog(
                                            title: "ไม่มีบัญชีผู้ใช้นี้",
                                            description:
                                                "กรุณาตรวจสอบอีเมลล์และรหัสผ่าน อีกครั้ง",
                                            buttonText: "clear",
                                          ),
                                        );
                                      } else if (response.statusCode == 401) {
                                        // print(response.body);
                                        var res = jsonDecode(response.body);
                                        print(res[0]['id']);
                                        storage.write('uid', res[0]['id']);
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Agreementpage()));
                                      } else if (response.statusCode == 200) {
                                        print("เข้าสู่ระบบได้");
                                        var res = jsonDecode(response.body);
                                        storage.write('uid', res[0]['id']);
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RootApp()));
                                      }
                                    } catch (e) {
                                      print(e);
                                    }
                                  }
                                  // Navigator.pushReplacement(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             RegisterPage()));
                                },
                                // #1FB684
                                color: Color(0xFF1FB684),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Center(
                            child: Text("Or via social media",
                                style: TextStyle(color: Colors.grey)),
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don’t have an account?"),
                              new GestureDetector(
                                onTap: () {
                                  // Navigator.pushNamed(context, "myRoute");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterPage()));
                                  print("Sign up");
                                },
                                child: new Text(
                                  " Register now",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "By signing up, you are agree with our",
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(" Terms & Conditions",
                                  style: TextStyle(fontSize: 12)),
                            ],
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
    );
  }
}
