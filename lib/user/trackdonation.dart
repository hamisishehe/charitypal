import 'package:charitypal/controller/EventM.dart';
import 'package:charitypal/user/eventdetail.dart';
import 'package:charitypal/user/singledonate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:get/get.dart';

class Trackdonation extends StatefulWidget {
  const Trackdonation({super.key});

  @override
  State<Trackdonation> createState() => _TrackdonationState();
}

class _TrackdonationState extends State<Trackdonation> {
  EventController eventController = Get.put(EventController());
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
                    Navigator.pop(context);
                  }, icon: Icon(Icons.close, color: Colors.black, size: 30,))
                ],
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.only(left: 15,top: 90,right: 8),
            child: Text("Track My Donation:", style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25,
                overflow: TextOverflow.ellipsis
            ),),
          ),

          Container(
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(left: 8,top: 120,right: 8),
              child: StreamBuilder(
                stream: eventController.topevents(FirebaseAuth.instance.currentUser!.uid),
                builder: (context, snapshot) {

                  if(snapshot.hasError){

                    return Text('${snapshot.error}', style: TextStyle(
                        color: Colors.orange
                    ),);

                  }
                  else if(snapshot.hasData){

                    final track = snapshot.data ?? [];

                    int totalAmount = 0;
                    for (var transaction in track) {
                      totalAmount += transaction.amount;
                    }


                    return ListView.builder(itemCount: track.length,
                      itemBuilder: (BuildContext context, int index) {

                      final tracks = track[index];

                        return StreamBuilder(
                            stream: eventController.umenisumbua(tracks.event_id),
                            builder: (context, snapshot) {
                        if (snapshot.hasError) {
                             return Text('Error: ${snapshot.error}');
                        }
                        else if(snapshot.hasData){
                          final toplists = snapshot.data ?? [];

                          return Column(
                            children: toplists.map((e) {
                              return Container(
                                padding: EdgeInsets.all(5),
                                margin: EdgeInsets.only(left: 10,top: 5, right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green.withOpacity(0.5),
                                ),

                                
                                child: InkWell(
                                  child: ListTile(
                                    leading: Container(
                                      child: Image.network(e.image),
                                    ),
                                    title: Text(e.title, style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        overflow: TextOverflow.ellipsis

                                    ),
                                    ),

                                    trailing:Icon(Icons.visibility, color: Colors.white,),

                                  ),

                                  onTap: (){
                                    Get.to(SingleDonate(eventid: e.event_id));
                                  },
                                ),
                              );

                            }).toList(),
                          );

                        }
                        return Container();

                              },
                            );



                      },
                    );
                        

                  }
                  else{
                    return Center(child: CircularProgressIndicator(),);
                  }
                },)

          )




        ],
      )),
    );
  }
}
