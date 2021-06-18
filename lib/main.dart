import 'package:flutter/material.dart';
import 'login_signup_file.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth Screen Challenge',
      debugShowCheckedModeBanner: false,
      home: SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: SafeArea(
        child: Column(
          children: [
            Image.asset("assets/images/login.png"),
            Expanded(
              child: Scaffold(
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                  child: Stack(
                    children: <Widget>[
                      LoginSignUp(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
