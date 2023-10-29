import 'package:charitypal/admin/adminviewevents.dart';
import 'package:charitypal/model/eventmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;


class AdminEventDetail extends StatefulWidget {
  final eventmodel post;
  const AdminEventDetail({super.key, required this.post});

  @override
  State<AdminEventDetail> createState() => _AdminEventDetailState();
}

class _AdminEventDetailState extends State<AdminEventDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(  backgroundColor: Color(0xff323232),

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
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        child: Image.asset("images/back.png", color: Color(0xff0AF886).withOpacity(0.5), width: 30,height: 30,),
                      ),

                    ),
                    Text(widget.post.title, style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                    ),),

                    IconButton(onPressed: () async {
                      QuerySnapshot f = await FirebaseFirestore.instance.collection("events").where("event_id", isEqualTo: widget.post.event_id).get();

                      f.docs.forEach((element) {
                        element.reference.delete();
                      });

                      Navigator.pop(context, MaterialPageRoute(builder: (context) => Adminviewevents(),));



                    }, icon: Icon(Icons.delete_outline_outlined, color: Colors.white,))

                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(left: 8,top: 75,right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    ClipRRect(

                      child: Container(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        child: Image.network(widget.post.image, fit: BoxFit.cover,),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),

                    SizedBox(height: 20,),

                    Text(widget.post.title, style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25
                    ),),
                    SizedBox(height: 10,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(timeago.format(widget.post.createdAt.toDate()), style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 20
                        ),),

                        Text(widget.post.location, style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 20
                        ),),
                      ],
                    ),

                    SizedBox(height: 10,),
                    SingleChildScrollView(
                      child: Text(widget.post.description, style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 20
                      ),),
                    ),








                  ],
                ),
              ),



            ],

          )


      ),

    );



  }


}
