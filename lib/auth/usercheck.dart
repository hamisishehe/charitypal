import 'package:charitypal/admin/adminhome.dart';
import 'package:charitypal/auth/login.dart';
import 'package:charitypal/org/orghomepage.dart';
import 'package:charitypal/user/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Usercheck extends StatefulWidget {
  const Usercheck({super.key});

  @override
  State<Usercheck> createState() => _UsercheckState();
}

class _UsercheckState extends State<Usercheck> {



  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.authStateChanges().first,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center( child: CircularProgressIndicator(),);
        }
        else if(snapshot.hasData){

            FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get().then((DocumentSnapshot documentSnapshot) {

              if(documentSnapshot.exists){
                if(documentSnapshot.get("role") == "user"){
                  Get.off(Home());
                }
                else if(documentSnapshot.get("role") == "admin"){

                  Get.off(AdminHome());

                }
                else if(documentSnapshot.get("role") == "org"){

                  Get.off(Orghomepage());

                }
                else{

                  Get.off(Orghomepage());

                }

              }else{
                return Center(child: CircularProgressIndicator(color: Colors.white,),);
              }

            });

            return Center(child: CircularProgressIndicator(color: Colors.white,),);
          }

        else{
          return Login();
        }
      },
    );
  }
}
