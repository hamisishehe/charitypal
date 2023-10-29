import 'package:charitypal/model/newsmodel.dart';
import 'package:charitypal/org/orgnews.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class Orgsinglenews extends StatefulWidget {
  final NewsModel post;
  const Orgsinglenews({super.key, required this.post, });

  @override
  State<Orgsinglenews> createState() => _OrgsinglenewsState();
}

class _OrgsinglenewsState extends State<Orgsinglenews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(  backgroundColor: Colors.white,

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
                        child: Image.asset("images/back.png", color: Colors.green.withOpacity(0.9), width: 30,height: 30,),
                      ),

                    ),
                    Text(widget.post.title, style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                    ),),

                    IconButton(onPressed: () async {
                      QuerySnapshot f = await FirebaseFirestore.instance
                          .collection("news").where("news_id", isEqualTo:
                      widget.post.news_id).get();

                      f.docs.forEach((element) {
                        element.reference.delete();
                      });

                      Navigator.pop(context, MaterialPageRoute(builder:
                          (context) => Orgnews(),));



                    }, icon: Icon(Icons.delete_outline_outlined, color: Colors.green,))

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
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25
                    ),),
                    SizedBox(height: 10,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(timeago.format(widget.post.createdAt.toDate()), style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 20
                        ),),
                      ],
                    ),

                    SizedBox(height: 10,),
                    SingleChildScrollView(
                      child: Text(widget.post.description, style: TextStyle(
                          color: Colors.black,
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
