import 'package:charitypal/controller/EventM.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

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
            margin: EdgeInsets.only(left: 8,top: 70,right: 8),
            child:  StreamBuilder(stream: eventController.fetchnot(
                FirebaseAuth.instance.currentUser!.uid),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  final usernot = snapshot.data ?? [];

                  if(usernot.isEmpty){

                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("images/noti1.png", scale: 2,),
                          Text("No Data", style: TextStyle(
                              color: Colors.white,
                              fontSize: 17
                          ),),
                        ],
                      ),
                    );


                  }
                  else {
                    return ListView.builder(itemCount: usernot.length,
                      itemBuilder: (BuildContext context, int index) {
                        final usern = usernot[index];


                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.green,
                            child: Icon(Icons.message, color: Colors.white,),
                          ),
                          title: Text("Payment Info", style: TextStyle(
                              color: Colors.black,
                              fontSize: 17
                          ),),
                          subtitle: Text(usern.amount.toString() + "  Tsh",
                            style: TextStyle(
                                color: Colors.black
                            ),),
                          trailing: Text(timeago.format(usern.createdAt.toDate
                            ()),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 20
                            ),),

                        );
                      },);
                  }
                

                }

                else if(snapshot.hasError){
                  return Text('${snapshot.error}');
                }
                else{

                  return CircularProgressIndicator(color: Colors.black,);
                }

              },)
          )
          
          
          
        ],
      ),),
      
    );
  }
}
