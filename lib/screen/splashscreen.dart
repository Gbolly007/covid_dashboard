import 'dart:async';

import 'package:flutter/material.dart';

import '../bottombar.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();

    startSplashCreen();
  }

  startSplashCreen() async {
    var duration = const Duration(seconds: 3);

    return Timer(duration, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) {
          return HomePage();
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4c57C0),
      body: Center(
        child: Image.asset(
          "images/icovid.png",
          width: 200,
          height: 100,
        ),
      ),
    );
  }
}
