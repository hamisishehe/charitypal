import 'package:charitypal/controller/EventM.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Viewusers extends StatefulWidget {
  const Viewusers({super.key});

  @override
  State<Viewusers> createState() => _ViewusersState();
}

class _ViewusersState extends State<Viewusers> {

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
                stream: eventController.allusers(),
                builder: (context, snapshot) {

                  if(snapshot.hasError){

                    return Text('${snapshot.error}', style: TextStyle(
                        color: Colors.orange
                    ),);

                  }
                  else if(snapshot.hasData){

                    final events = snapshot.data ?? [];

                    return ListView.builder(itemCount: events.length,
                      itemBuilder: (BuildContext context, int index) {
                      final event = events[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.white,
                            child: Icon(Icons.person_2, color: Colors.black,),
                          ),
                          title: Text(event.fullname, style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                          ),) ,
                          
                          trailing: IconButton(onPressed: (){}, icon: Icon(Icons.edit, color: Colors.white,)),
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
