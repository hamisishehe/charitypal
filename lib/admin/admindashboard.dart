import 'package:charitypal/controller/EventM.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Admindashboard extends StatefulWidget {
  const Admindashboard({super.key});

  @override
  State<Admindashboard> createState() => _AdmindashboardState();
}

class _AdmindashboardState extends State<Admindashboard> {

  EventController eventController = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff323232),

      body: SafeArea(
        child: Stack(
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
              margin: EdgeInsets.only(top: 80,left: 8,right: 8),
              child: Column(
                children: [

                  Container(
                    height: 100,
                    padding: EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text("Total Events :", style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                fontWeight: FontWeight.bold

                              ),),
                              StreamBuilder(stream: eventController.allevent(),
                                builder: (context, snapshot) {
                                  if(snapshot.hasData){
                                    final event = snapshot.data ?? [];

                                    return  Text(event.length.toString(), style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white
                                    ),);

                                  }
                                  else{
                                    return Center(child: CircularProgressIndicator(),);
                                  }
                                },)


                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text("All Users :", style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),),
                              StreamBuilder(stream: eventController.allusers(),
                                builder: (context, snapshot) {
                                  if(snapshot.hasData){
                                    final event = snapshot.data ?? [];

                                    return  Text(event.length.toString(), style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white
                                    ),);

                                  }
                                  else{
                                    return Center(child: CircularProgressIndicator(),);
                                  }
                                },)


                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text("Requested Organization :", style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),),
                              FutureBuilder<QuerySnapshot>(
                                future: FirebaseFirestore.instance.collection("organization").get(),
                                builder: (context, snapshot) {
                                  if(snapshot.hasData){
                                    final allrequest = snapshot.data!.docs;

                                    return  Text(allrequest.length.toString(), style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white
                                    ),);

                                  }
                                  else{
                                    return Center(child: CircularProgressIndicator(),);
                                  }
                                },)


                            ],
                          ),
                        )


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
