import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smarthomeapp/main.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 7), () {
      Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => LoginPage(),)
      );
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Container(
            child: Image.asset('smarthomeapp/assets/company_logo/bharat_innovation_logo.png')
        ),
      ),
    );
  }

}