import 'package:charitypal/auth/login.dart';
import 'package:charitypal/controller/allusersController.dart';
import 'package:charitypal/model/usermodel.dart';
import 'package:charitypal/user/contactus.dart';
import 'package:charitypal/user/faqs.dart';
import 'package:charitypal/user/favorite.dart';
import 'package:charitypal/user/myprofile.dart';
import 'package:charitypal/user/notification.dart';
import 'package:charitypal/user/terms.dart';
import 'package:charitypal/user/trackdonation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draggable_menu/draggable_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  final List<Map<String, dynamic>> _options = [
    {'title': 'My Profile', 'icon': Icons.person_2},
    {'title': 'Favorites', 'icon': Icons.bookmark},
    {'title': 'Notification', 'icon': Icons.notifications},
    {'title': 'Track My Donation', 'icon': Icons.track_changes},
    {'title': 'Terms and Condition', 'icon': Icons.info},
    {'title': 'Contact Us', 'icon': Icons.contact_page_outlined },
    {'title': 'FAQ\'s', 'icon': Icons.question_answer },
    {'title': 'Logout', 'icon': Icons.logout },
  ];


  void _handleMenuItemTap(String title) {
    if (title == 'My Profile') {

      Get.to(MyProfile(), fullscreenDialog: true);

    }
    else if (title == 'Favorites') {
      Get.to(Favorite());
    }
    else if (title == 'Notification') {
      Get.to(NotificationPage());
    }
    else if (title == 'Track My Donation') {
      Get.to(Trackdonation());
    }
    else if (title == 'Terms and Condition') {
      Get.to(Terms());
    }
    else if (title == 'Contact Us') {
      Get.to(Contactus());
    }
    else if (title == 'FAQ\'s') {
      Get.to(Faqs());
    }

    else if (title == 'Logout') {
      FirebaseAuth.instance.signOut();
      Get.off(Login());

    }


  }


  AlluserFetch alluserFetch = Get.put(AlluserFetch());
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

                ],
              ),
            ),
          ),


          Container(
            margin: EdgeInsets.only(left: 30,top: 75,right: 18),
            height: 90,
            width: MediaQuery.of(context).size.width,
            child: Container(
              height: 70,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green.withOpacity(0.5),
              ),
              child: StreamBuilder(stream: FirebaseFirestore.instance.collection("transaction").where("user_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    final total = snapshot.data!.docs;
                    double totalamount = 0;

                    for(var useramount in total){
                      totalamount  = totalamount + useramount['amount'];
                    }
                    if(total.isEmpty){
                      return Center(
                        child: Text("My Contribution : 0 Tsh", style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),),
                      );
                    }
                    else{
                      return Center(
                        child: Text("My Contribution : "+ totalamount
                            .toString()+" Tsh", style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),),
                      );
                    }

                  }
                  else{
                    return Center(
                      child: Text("Loading... ", style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),),
                    );
                  }
                },),
            ),
          ),

          Container(
            margin: EdgeInsets.only(left: 18,top: 180,right: 18),
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
