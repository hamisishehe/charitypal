
import 'package:charitypal/controller/EventM.dart';
import 'package:charitypal/org/addnews.dart';
import 'package:charitypal/org/orgsinglenews.dart';
import 'package:charitypal/user/singlenews.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Orgnews extends StatefulWidget {
  const Orgnews({super.key});

  @override
  State<Orgnews> createState() => _OrgnewsState();
}

class _OrgnewsState extends State<Orgnews> {

  EventController eventController = Get.put(EventController());

  late String fullname;

  @override
  void initState() {


    Future getusername () async{

      DocumentSnapshot f =  await FirebaseFirestore.instance.collection
        ("users").doc(FirebaseAuth.instance.currentUser!.uid).get();

      if(f.exists){
        Map<String, dynamic> userdata = f.data() as Map<String, dynamic>;
        String full_name = f['fullname'];
        setState(() {
          fullname = userdata['fullname'];
        });
      }


    super.initState();
  }


  }

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
                    Navigator.push(context, MaterialPageRoute(builder:
                        (context) => AddNews(),));
                  }, icon: Icon(Icons.add, color: Colors.black,))
                ],
              ),
            ),
          ),

          Container(
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(left: 8,top: 80,right: 8),
              child: StreamBuilder(
                stream: eventController.fetchnews(FirebaseAuth.instance.currentUser!.uid),
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
                              (builder: (context) => Orgsinglenews(post: event),));
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
