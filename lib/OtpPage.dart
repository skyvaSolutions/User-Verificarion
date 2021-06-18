import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:http/http.dart' as http;

class OtpPage extends StatelessWidget {
  final otpController = TextEditingController();

  final mail;
  final phone;

  OtpPage(this.mail, this.phone);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset("assets/images/otp_background.png"),
                  SizedBox(height: 20),
                  Text(
                    "VERIFY OTP",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  SizedBox(height: 20),
                  PinCodeTextField(
                    controller: otpController,
                    onChanged: (String value) {
                      if (value.length == 6) {
                        print(value);
                      }
                    },
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    length: 6,
                    appContext: context,
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      final otp = otpController.text;
                      if (otp.length == 6) {
                        verifyOtp(otp, context);
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Center(
                        child: Text(
                          "VERIFY",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
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

  void verifyOtp(otp, context) async {
    print("async");
    Uri uri = Uri.parse("https://skyva-app.herokuapp.com/user/verifyotp");
    final params = {
      "email": mail,
      "phoneNo": phone,
      "countryCode": 91,
      "otp": otp
    };
    http.Response response = await http.post(
      uri,
      body: json.encode(params),
      headers: {"Content-Type": "application/json"},
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200){
      Navigator.pop(context);
    }
  }
}
