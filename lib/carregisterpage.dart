import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'creditcard.dart';
import 'package:get_storage/get_storage.dart';
import 'model/car.dart';

class Carregiisterpage extends StatefulWidget {
  const Carregiisterpage({Key? key}) : super(key: key);
  @override
  _CarregiisterpageState createState() => _CarregiisterpageState();
}

class _CarregiisterpageState extends State<Carregiisterpage> {
  final _formKey = GlobalKey<FormState>();

  var brandcar = [
    "TOYOTA",
    "ISUZU",
    "HONDA",
    "MITSUBISHI",
    "NISSAN",
    "MAZDA",
    "FORD",
    "MG",
    "SUZUKI",
    "CHEVROLET",
    "BMW",
    "BENZ",
    "HYUNDAI",
    "อื่นๆ",
  ];

  Cars mycar = Cars(brandcar: '', carpaint: '', carregistration: '');
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
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // ignore: prefer_const_constructors
                      Image.asset(
                        'assets/logo_pn_bangkok.png',
                        width: 150,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          "กรอกข้อมูลรายระเอียดรถ",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FormBuilderDropdown(
                        name: 'gender',
                        allowClear: true,
                        hint: Text('ยี่ห้อรถ'),
                        //  hintText: 'Hint Text',
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.view_carousel_outlined,
                            color: Colors.blue,
                          ),
                        ),

                        items: brandcar
                            .map((brandcar) => DropdownMenuItem(
                                  onTap: () {
                                    mycar.brandcar = brandcar;
                                  },
                                  value: brandcar,
                                  child: Text('$brandcar'),
                                ))
                            .toList(),

                        validator: (value) {
                          if (value == null) {
                            return 'กรุณาเลือกยี่ห้อรถ';
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "ทะเบียนรถ",
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.2))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.secondary)),
                          prefixIcon: Icon(
                            Icons.car_rental_rounded,
                            color: Colors.blue,
                          ),
                        ),
                        onSaved: (String? carregistration) {
                          mycar.carregistration = carregistration!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณาป้อยข้อมูล';
                          } else if (value.length < 3) {
                            return 'กอกข้อมูลทะเบียนรถให้ถูกต้อง';
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
                          hintText: "สีรถ",
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.2))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.secondary)),
                          prefixIcon: Icon(
                            Icons.color_lens,
                            color: Colors.blue,
                          ),
                        ),
                        onSaved: (String? carpaint) {
                          mycar.carpaint = carpaint!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณาป้อยข้อมูล';
                          }
                          // return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 1, left: 3),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 40,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              print(mycar.brandcar);
                              print(mycar.carregistration);
                              print(mycar.carpaint);

                              var _mycar = {
                                "brandcar": mycar.brandcar,
                                "carregistration": mycar.carregistration,
                                "carpaint": mycar.carpaint,
                              };
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Creditcard(
                                          valueFromcarregisterpage: _mycar)));
                            }
                          },
                          // #1FB684
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Text(
                            "ถัดไป",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
