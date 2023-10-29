import 'package:charitypal/auth/login.dart';
import 'package:charitypal/org/orgcontactus.dart';
import 'package:charitypal/org/orgfaqs.dart';
import 'package:charitypal/org/orgmyprofile.dart';
import 'package:charitypal/org/orgterms.dart';
import 'package:charitypal/org/orgtrack.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Orgprofile extends StatefulWidget {
  const Orgprofile({super.key});

  @override
  State<Orgprofile> createState() => _OrgprofileState();
}

class _OrgprofileState extends State<Orgprofile> {

  final List<Map<String, dynamic>> _options = [
    {'title': 'My Profile', 'icon': Icons.person_2},
    {'title': 'Track My Events', 'icon': Icons.track_changes},
    {'title': 'Terms and Condition', 'icon': Icons.info},
    {'title': 'Contact Us', 'icon': Icons.contact_page_outlined },
    {'title': 'FAQ\'s', 'icon': Icons.question_answer },
    {'title': 'Logout', 'icon': Icons.logout },
  ];

  void _handleMenuItemTap(String title) {
    if (title == 'My Profile') {

      Get.to(Orgmyprofile(), fullscreenDialog: true);

    }


    else if (title == 'Track My Donation') {
      Get.to(Orgtrack());
    }
    else if (title == 'Terms and Condition') {
      Get.to(Orgterms());
    }
    else if (title == 'Contact Us') {
      Get.to(OrgContactus());
    }
    else if (title == 'FAQ\'s') {
      Get.to(Orgfaqs());
    }

    else if (title == 'Logout') {
      FirebaseAuth.instance.signOut();
      Get.off(Login());

    }


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: Stack(
        children: [

          Material(
            elevation: 5,
            child: Container(
              margin: EdgeInsets.only(left: 8,top: 20,right: 8),
              height: 50,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Image.asset("images/lv2.png", scale: 3.2,),
                  ),
                  IconButton(onPressed: (){
                    FirebaseAuth.instance.signOut();
                    Get.off(Login());

                  }, icon: Icon(Icons.logout, color: Colors.black,))
                ],
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.only(left: 18,top: 80,right: 18),
            width: 300 ,
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: _options.length,
              itemBuilder: (context, index) {
                final option = _options[index];
                return ListTile(
                  leading: Icon(option['icon'], color: Colors.green, size:
                  30,),
                  title: Text(option['title'], style: TextStyle(
                      fontFamily: 'sansita',
                      color: Colors.black,
                      fontSize: 20
                  ),),
                  onTap: () => _handleMenuItemTap(option['title']),
                  // Handle the tap event for each option

                );
              },
            ),
          )





        ],
      )),
    );
  }
}
