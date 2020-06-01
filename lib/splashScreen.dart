import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Material(
          child: Container(
            child: Image.asset(
              'assets/icon.png',
              height: 350,
              width: 350,
              fit: BoxFit.fitWidth,
            ),
          ),
        ), 
      ),
    );
  }
}
