import 'package:charitypal/controller/EventM.dart';
import 'package:charitypal/org/addevent.dart';
import 'package:charitypal/org/singleorgevent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class Orgevents extends StatefulWidget {
  const Orgevents({super.key});

  @override
  State<Orgevents> createState() => _OrgeventsState();
}

class _OrgeventsState extends State<Orgevents> {
  
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
                    child: Image.asset("images/lv2.png", scale: 3.2,fit: BoxFit.cover,),
                  ),
                  IconButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Addevent(),));
                  }, icon: Icon(Icons.add, color: Colors.black,))
                ],
              ),
            ),
          ),

          Container(
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(left: 8,top: 80,right: 8),
            child: StreamBuilder(
                stream: eventController.getevent(FirebaseAuth.instance.currentUser!.uid),
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
                              height: 70,
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


                                  SizedBox(width: 15,)
                                ],
                              )
                          ),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute
                              (builder: (context) => Singleorgevent(post: event),));
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
