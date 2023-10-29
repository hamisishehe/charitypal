import 'package:charitypal/controller/EventM.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Orgdashboard extends StatefulWidget {
  const Orgdashboard({super.key});

  @override
  State<Orgdashboard> createState() => _OrgdashboardState();
}

class _OrgdashboardState extends State<Orgdashboard> {
  @override
  Widget build(BuildContext context) {

    EventController eventController = Get.put(EventController());
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Stack(
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
                    IconButton(onPressed: (){}, icon: Icon(Icons.notifications, color: Colors.green,))
                  ],
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 80,left: 8,right: 8),
              child: Column(
                children: [

                  Container(
                    height: 150,
                    padding: EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [
                        
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text("Total Events :", style: TextStyle(
                                fontSize: 25,
                                color: Colors.black
                              ),),
                             StreamBuilder(stream: eventController.getevent(FirebaseAuth.instance.currentUser!.uid),
                                 builder: (context, snapshot) {
                                   if(snapshot.hasData){
                                     final event = snapshot.data ?? [];

                                     return  Text(event.length.toString(), style: TextStyle(
                                         fontSize: 25,
                                         color: Colors.black
                                     ),);

                                   }
                                   else{
                                     return Center(child: CircularProgressIndicator(),);
                                   }
                                 },)


                            ],
                          ),
                        ),



                        
                        
                      ],
                    ),
                  )








                ],
              ),
            )

          ],
        ),
      ) ,
    );
  }
}
