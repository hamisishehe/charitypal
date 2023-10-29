import 'package:charitypal/controller/EventM.dart';
import 'package:charitypal/model/eventmodel.dart';
import 'package:charitypal/model/favorite.dart';
import 'package:charitypal/user/eventdetail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;


class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {

  EventController eventController = Get.put(EventController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  child: Image.asset("images/lv2.png", scale: 3.2,),
                ),
                IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: Icon(Icons.close, color: Colors.black, size: 30,))
              ],
            ),
          ),

          Container(
              margin: EdgeInsets.only(left: 15,top: 90,right: 8),
            child: const Text("Favorites", style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25,
                overflow: TextOverflow.ellipsis
            ),),
          ),

          Container(
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(left: 8,top: 120,right: 8),
              child: StreamBuilder<List<FavoriteModel>>(
                stream: eventController.fetchfavori(FirebaseAuth.instance
                    .currentUser!.uid),
                builder: (context, snapshot) {

                  if(snapshot.hasError){

                    return Text('${snapshot.error}', style: TextStyle(
                        color: Colors.orange
                    ),);

                  }
                  else if(snapshot.hasData){

                    List<FavoriteModel> fav = snapshot.data! ?? [];

                    return ListView.builder(
                      itemCount: fav.length,
                      itemBuilder: (BuildContext context, int index) {
                        final listfav = fav[index];
                        
                        return StreamBuilder(
                            stream: eventController.demofetch(listfav
                                .event_id, FirebaseAuth.instance
                                .currentUser!.uid),
                            builder: (context, snapshot) {

                          final event = snapshot.data ?? [];

                          if(snapshot.hasError){
                            return Text('${snapshot.error}', style: TextStyle(
                                color: Colors.orange
                            ),);

                          }
                          else{

                             return Container(
                               margin: EdgeInsets.all(0.8),
                               child: Column(
                                 children: event.map((evets) => InkWell(
                                   child: Container(

                                       margin: EdgeInsets.only(left: 8,right:
                                       8,top: 8),
                                       height: 100,

                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(15),
                                         color: Colors.green.withOpacity(0.5),
                                       ),
                                       child: Row(
                                         crossAxisAlignment:
                                         CrossAxisAlignment.center,
                                         mainAxisAlignment: MainAxisAlignment.start,
                                         children: [
                                           Container(
                                             child: ClipRRect(
                                                 borderRadius: BorderRadius.circular(0.5),
                                                 child: Image.network(evets.image,
                                                   fit: BoxFit
                                                     .cover,)),
                                             width: 120,
                                             height: MediaQuery.of(context)
                                                 .size.height,
                                           ),
                                           SizedBox(width: 5,),

                                           Text(evets.title, style: TextStyle(
                                               color: Colors.black,
                                               fontWeight: FontWeight.bold,
                                               fontSize: 14,
                                               overflow: TextOverflow.ellipsis
                                           ),),


                                         ],
                                       )
                                   ),
                                   onTap: (){
                                     Navigator.push(context,
                                         MaterialPageRoute(builder: (context) => Eventdetail(post: evets),));
                                   },
                                 )).toList()
                               ),

                             );

                          }



                            },);

                        
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
