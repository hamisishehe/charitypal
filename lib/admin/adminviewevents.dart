import 'package:charitypal/admin/admineventdetail.dart';
import 'package:charitypal/controller/EventM.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class Adminviewevents extends StatefulWidget {
  const Adminviewevents({super.key});

  @override
  State<Adminviewevents> createState() => _AdminvieweventsState();
}

class _AdminvieweventsState extends State<Adminviewevents> {

  EventController eventController = Get.put(EventController());
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
                IconButton(onPressed: (){}, icon: Icon(Icons.notifications, color: Colors.white,))
              ],
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

                    return GridView.builder(
                      itemCount: events.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                      itemBuilder: (context, index) {

                        final event = events[index];

                        return InkWell(
                          child: Container(
                            margin: EdgeInsets.all(8),
                            height: 200,
                            width: 200,
                            child: Column(
                              children: [
                                Container(
                                  height: 150,
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.network(event.image, fit: BoxFit.cover,),
                                ),
                                Expanded(child: Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(event.title, style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10
                                          ),),
                                        ),
                                        Text(timeago.format(event.createdAt.toDate()), style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10
                                        ),),


                                      ],
                                    ),
                                  ),
                                ))

                              ],
                            ),
                          ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AdminEventDetail(post: event),));
                          },
                        );
                      },);

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
