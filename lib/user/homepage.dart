import 'package:carousel_slider/carousel_slider.dart';
import 'package:charitypal/controller/EventM.dart';
import 'package:charitypal/model/transaction.dart';
import 'package:charitypal/user/eventdetail.dart';
import 'package:charitypal/user/notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  EventController eventController = Get.put(EventController());


  var hours = DateTime.now().hour;

  String greeting = "";

  @override
  void initState() {
    // TODO: implement initState

    if(hours>=1 && hours<=12){
      greeting = "Good Morning";
    } else if(hours>=12 && hours<=16){
      greeting = "Good Afternoon";
    } else if(hours>=16 && hours<=21){
      greeting = "Good Evening";
    } else if(hours>=21 && hours<=24){
      greeting = "Good Night";
    }

    print("your message:-"+greeting);

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
          children: [
            Material(
              elevation: 5,
              child: Container(
                margin: EdgeInsets.only(left: 8,top: 10,right: 8),
                height: 50,
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Image.asset("images/lv2.png", scale: 2.8,),
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

              margin: EdgeInsets.only(top: 70,left: 8,right: 8),
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text(greeting, style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25
                ),),
              ),
            ),

            Container(
              height: 120,
              margin: EdgeInsets.only(top: 110,left: 8,right: 8),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(

              ),

              child: CarouselSlider(
                  items: [

                    Container(
                      padding: EdgeInsets.only(left: 5, top: 20),
                      height: 100,
                      width: 350,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green.withOpacity(0.5)

                      ),
                      child: Stack(
                        children: [
                          Container(
                            child: Text("Empower, Engage ", style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 20
                            ),),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 25),
                            child: Text("Join a community of giving with our app.Empower nonprofits, engage in meaningful events.", style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14
                            ),),
                          )
                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(left: 5, top: 20),
                      height: 100,
                      width: 350,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green.withOpacity(0.5)

                      ),
                      child: Stack(
                        children: [
                          Container(
                            child: Text("Seamless Giving Global impacts ", style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 20
                            ),),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 25),
                            child: Text("Exprience, seamles giving with our app.Your small donations have a global impact.", style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14
                            ),),
                          )
                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(left: 5, top: 20),
                      height: 100,
                      width: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green.withOpacity(0.5)

                      ),
                      child: Stack(
                        children: [
                          Container(
                            child: Text("Change Lives with every click ", style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 20
                            ),),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 25),
                            child: Text("Our charity donation app makes it easy to support causes you care about Browse Events", style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14
                            ),),
                          )
                        ],
                      ),
                    ),



                  ],
                  options: CarouselOptions(
                    height: 100,
                    aspectRatio: 16/9,
                    viewportFraction: 0.9,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 10),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 1.5,
                    scrollDirection: Axis.horizontal,
                  )
              ),

            ),

            Container(
              margin: EdgeInsets.only(top: 245,left: 8,right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Text("Featured  Events ", style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                    ),),
                  ),



                ],
              ),


            ),

            Container(
              height: 200,
              margin: EdgeInsets.only(top: 275,left: 25,right: 20),
              child: StreamBuilder(
                stream: eventController.alltopevents(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    final event = snapshot.data ?? [];

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: event.length,
                      itemBuilder: (BuildContext context, int index) {
                        final events = event[index];
                        return InkWell(
                          child: Card(
                            elevation: 2.9,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Container(
                              width: 220,
                              child: Column(
                                children: [
                                  Stack(
                                    children: [

                                      Container(
                                          height: 130,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          width: MediaQuery.of(context).size.width,
                                          child: Image.network(events.image, fit: BoxFit.cover,)),

                                      Container(
                                        margin: EdgeInsets.only(top: 150),
                                        height: 30,
                                        width: MediaQuery.of(context).size.width,
                                        color: Colors.black.withOpacity(0.7),
                                        child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(events.title, style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                overflow: TextOverflow.ellipsis
                                            ),)
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(8),
                                        width: 70,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius
                                              .circular(10),
                                          color: Colors.green.withOpacity(0.5),
                                        ),
                                        child:  Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TimerCountdown(
                                            colonsTextStyle: const TextStyle(
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
                                            endTime: events.event_date.toDate(),
                                            onEnd: () {
                                              print("Timer finished");
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),



                                ],
                              ),
                            ),
                          ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Eventdetail(post: event[index]),));
                          },
                        );
                      },
                    );

                  }
                  else{
                    return Center(child: CircularProgressIndicator(),);
                  }
                },)
                ),

            Container(
              margin: EdgeInsets.only(top: 490,left: 8,right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Text("Trending Events ", style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25
                    ),),
                  ),








                ],
              ),


            ),

            Container(
                height: 220,
                margin: EdgeInsets.only(top: 530,left: 20,right: 20),
                child: StreamBuilder(
                  stream: eventController.alleventsort(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      final event = snapshot.data ?? [];

                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: event.length,
                        itemBuilder: (BuildContext context, int index) {
                          final events = event[index];
                          return InkWell(
                            child: Card(
                              elevation: 2.9,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Container(
                                width: 220,
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [

                                        Container(
                                            height: 130,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            width: MediaQuery.of(context).size.width,
                                            child: Image.network(events.image, fit: BoxFit.cover,)),

                                        Container(
                                          margin: EdgeInsets.only(top: 150),
                                          height: 30,
                                          width: MediaQuery.of(context).size.width,
                                          color: Colors.black.withOpacity(0.7),
                                          child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(events.title, style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  overflow: TextOverflow.ellipsis
                                              ),)
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(8),
                                          width: 70,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius
                                                .circular(10),
                                            color: Colors.green.withOpacity(0.5),
                                          ),
                                          child:  Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TimerCountdown(
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
                                              endTime: events.event_date.toDate(),
                                              onEnd: () {
                                                print("Timer finished");
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    ),



                                  ],
                                ),
                              ),
                            ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Eventdetail(post: event[index]),));
                            },
                          );
                        },
                      );

                    }
                    else{
                      return Center(child: CircularProgressIndicator(),);
                    }
                  },)
            ),



          ],
      ),
        ),)
    );
  }
}
