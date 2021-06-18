import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'OtpPage.dart';

class LoginSignUp extends StatefulWidget {
  const LoginSignUp({Key? key}) : super(key: key);

  @override
  _LoginSignUpState createState() => _LoginSignUpState();
}

final phoneController = TextEditingController();
final mailController = TextEditingController();

class _LoginSignUpState extends State<LoginSignUp> {
  var validateMail = false, validatePhone = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            controller: phoneController,
            keyboardType: TextInputType.number,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              errorText: validatePhone?"Please enter a valid phone number":null,
              fillColor: Colors.blue[200],
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: BorderSide(
                  color: Colors.greenAccent,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              hintText: 'Phone Number',
              hintStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            controller: mailController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              errorText: validateMail?"Can't be empty":null,
              fillColor: Colors.blue[200],
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: BorderSide(
                  color: Colors.greenAccent,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              hintText: 'Email',
              hintStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            
            onTap: () {
              final phone = phoneController.text;
              final mail = mailController.text;
              if (phone.isEmpty) {
                setState(() {
                  validateMail = false;
                  validatePhone = true;
                });
              } else if (mail.isEmpty) {
                setState(() {
                  validatePhone = false;
                  validateMail = true;
                });
              } else {
                setState(() {
                  validateMail = false;
                  validatePhone = false;
                });
                getResponse(
                  mail: mail,
                  phone: phone,
                );
              }
            },
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(40),
                border: Border.all(
                  color: Colors.blue,
                ),
              ),
              child: Center(
                child: Text(
                  "CONTINUE",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getResponse({mail, phone}) async {
    Uri uri = Uri.parse('https://skyva-app.herokuapp.com/user/sendotp');

    var params = {"email": mail, "phoneNo": phone, "countryCode": "91"};

    String body = json.encode(params);

    var response = await http.post(
      uri,
      body: body,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return OtpPage(mail, phone);
          },
        ),
      );
    }

    print(response.body);
  }
}
