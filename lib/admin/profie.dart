import 'package:charitypal/auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({super.key});

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff323232),
      body: SafeArea(child: Stack(
        children: [

          Container(
            margin: EdgeInsets.only(left: 8,top: 20,right: 8),
            height: 50,
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Image.asset("images/logowhite.png", scale: 3.2,),
                ),
                IconButton(onPressed: (){
                  FirebaseAuth.instance.signOut();
                  Get.off(Login());

                }, icon: Icon(Icons.logout, color: Colors.white,))
              ],
            ),
          ),





        ],
      )),
    );
  }
}
