import 'package:charitypal/auth/login.dart';
import 'package:charitypal/auth/usercheck.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 5)).then((value) => {
      Get.off(Usercheck())

    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: Center(
        child: Container(
          child: Image.asset("images/lv2.png", scale: 2.2,),
        ),
      )),
    );
  }
}
