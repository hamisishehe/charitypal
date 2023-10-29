import 'package:charitypal/controller/EventM.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;


class SingleDonate extends StatefulWidget {
  final String eventid;

  const SingleDonate({super.key, required this.eventid});

  @override
  State<SingleDonate> createState() => _SingleDonateState();
}

class _SingleDonateState extends State<SingleDonate> {

  EventController eventController = Get.put(EventController());
  
  
  @override
  Widget build(BuildContext context) {
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
                      IconButton(onPressed: (){
                        Navigator.pop(context);
                      }, icon: Icon(Icons.close, color: Colors.black, size: 30,))
                    ],
                  ),
                ),
              ),
              
              
              Container(
                height: 100,
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 8,top: 80,right: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.green.withOpacity(0.5)
                ),
                
                child: StreamBuilder(
                  stream: eventController.topeventsamount(widget.eventid, FirebaseAuth.instance.currentUser!.uid),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasData) {
                      final single = snapshot.data ?? [];
                      return ListView.builder(
                        itemCount: single.length,
                        itemBuilder: (BuildContext context, int index) {
                          final singledonate = single[index];
                          return Container(
                            child: Column(
                              children: [
                                Text("Your Donation Amount : "+ singledonate.amount.toString(), style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                                ),),
                                SizedBox(height: 5,),
                                Text("Transaction Id : "+ singledonate.transaction_id, style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15
                                ),),
                                SizedBox(height: 5,),
                                Text(timeago.format(
                                    singledonate.createdAt
                                        .toDate()),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight
                                          .w600,
                                      fontSize: 15
                                  ),),
                              ],
                            ),
                          );
                        },
                      );

                    } else if (snapshot.hasError) {
                      return Icon(Icons.error_outline);
                    } else {
                      return Center(child: CircularProgressIndicator(color: Colors.white,));
                    }
                  }))






            ],
          )),
    );
  }
}
