import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'carregisterpage.dart';
import 'package:get_storage/get_storage.dart';

class Agreementpage extends StatefulWidget {
  const Agreementpage({Key? key}) : super(key: key);

  @override
  _AgreementpageState createState() => _AgreementpageState();
}

class _AgreementpageState extends State<Agreementpage> {
  String engText =
      """A common type of text alignment in print media is "justification", where the spaces between words, and, to a lesser extent, between glyphs or letters, are stretched or compressed to align both the left and right ends of each line of text. When using justification, it is customary to treat the last line of a paragraph separately by simply left or right aligning it, depending on the language direction. Lines in which the spaces have been stretched beyond their normal width are called lines, while those whose spaces have been compressed are called tight lines.""";

  bool _checkbox = false;
  bool isDisabled = false;
  final storage = GetStorage();

  var uid;
  @override
  void initState() {
    uid = storage.read("uid");
    print(uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Center(
                child: Container(
                    child: Image.asset(
              'assets/logo_pn_bangkok.png',
              height: 100,
              // width: 100,
            ))),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      // Text(engText, textAlign: TextAlign.justify),
                      Divider(height: 20.0),
                      Text("Hebrew Text TextAlign.justify"),
                      Text(
                        engText,
                        textAlign: TextAlign.justify,
                        textDirection: TextDirection.rtl,
                      ),
                      Divider(height: 20.0),
                      Text("Hebrew Text TextAlign.justify"),
                      Text(
                        engText,
                        textAlign: TextAlign.justify,
                        textDirection: TextDirection.rtl,
                      ),
                      Divider(height: 20.0),
                      Text("Hebrew Text TextAlign.justify"),
                      Text(
                        engText,
                        textAlign: TextAlign.justify,
                        textDirection: TextDirection.rtl,
                      ),
                      Divider(height: 20.0),
                      Text("Hebrew Text TextAlign.justify"),
                      Text(
                        engText,
                        textAlign: TextAlign.justify,
                        textDirection: TextDirection.rtl,
                      ),

                      Divider(height: 20.0),
                    ],
                  ),
                ),
              ),
            ),
            Divider(height: 20.0),
            Row(
              children: [
                Checkbox(
                  value: _checkbox,
                  onChanged: (value) {
                    setState(() {
                      _checkbox = true;
                      isDisabled = true;
                    });
                  },
                ),
                Text('ฉันยอมรับนโยบายของแอปฟริเคชั่น'),
              ],
            ),
            ElevatedButton(
              // disabledColor: Colors.grey,
              style: ElevatedButton.styleFrom(
                onSurface: Colors.blue,
              ),

              onPressed: isDisabled
                  ? () {
                      // print("Clicked");
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Carregiisterpage()));
                    }
                  : null,
              child: Text(
                "ถัดไป",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Divider(height: 20.0),
          ],
        ),
      ),
    );
  }
}
