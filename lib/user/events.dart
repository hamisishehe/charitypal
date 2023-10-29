import 'package:charitypal/controller/EventM.dart';
import 'package:charitypal/user/eventdetail.dart';
import 'package:charitypal/user/notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:badges/badges.dart' as badges;

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {

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
                  StreamBuilder(stream: eventController.fetchnot(
                      FirebaseAuth.instance.currentUser!.uid),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        final usernot = snapshot.data ?? [];

                        return  GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute
                              (builder: (context) => NotificationPage(),));
                          },
                          child: badges.Badge(
                            position: badges.BadgePosition.topEnd(top: -2, end: 5),
                            badgeContent: Text(usernot.length.toString()),
                            badgeStyle: badges.BadgeStyle(
                                badgeColor: Colors.green
                            ),
                            child:  IconButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute
                                (builder: (context) => NotificationPage(),));
                            }, icon: Icon(Icons.notifications, color: Colors
                                .green,)),
                          ),
                        );

                      }

                      else if(snapshot.hasError){
                        return Text('${snapshot.error}');
                      }
                      else{

                        return CircularProgressIndicator(color: Colors.black,);
                      }

                    },)
                ],
              ),
            ),
          ),

          Container(
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(left: 8,top: 80,right: 8),
              child: StreamBuilder(
                stream: eventController.allevent(),
                builder: (context, snapshot) {

                  if(snapshot.hasError){

                    return Text('${snapshot.error}', style: TextStyle(
                        color: Colors.orange
                    ),);

                  }
                  else if(snapshot.hasData){

                    final events = snapshot.data ?? [];

                    return ListView.builder(
                      itemCount: events.length,
                      itemBuilder: (BuildContext context, int index) {

                      final event = events[index];
                        return InkWell(
                          child: Container(
                            margin: EdgeInsets.only(left: 8,right: 8,top: 8),
                            height: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.green.withOpacity(0.5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(

                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(0.5),
                                      child: Image.network(event.image, fit: BoxFit
                                          .cover,)),
                                  width: 130,
                                  height: MediaQuery.of(context).size.height,
                                ),
                                SizedBox(width: 10,),

                                Expanded(
                                  child: Text(event.title, style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      overflow: TextOverflow.ellipsis

                                  ),),
                                ),

                                TimerCountdown(
                                  colonsTextStyle: TextStyle(
                                      overflow: TextOverflow.ellipsis
                                  ),
                                  spacerWidth: 0.5,
                                  daysDescription: "days left",
                                  descriptionTextStyle: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                      overflow: TextOverflow.ellipsis
                                  ),

                                  timeTextStyle: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                      overflow: TextOverflow.ellipsis
                                  ),
                                  format: CountDownTimerFormat.daysOnly,
                                  endTime: event.event_date.toDate(),
                                  onEnd: () {
                                    print("Timer finished");
                                  },
                                ),


                                SizedBox(width: 35,)
                              ],
                            )
                          ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Eventdetail(post: event),));
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
