import 'package:charitypal/model/newsmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class Singlenews extends StatefulWidget {
  final NewsModel post;
  const Singlenews({super.key, required this.post});

  @override
  State<Singlenews> createState() => _SinglenewsState();
}

class _SinglenewsState extends State<Singlenews> {

  @override
  void initState() {
    // TODO: implement initState

    FirebaseFirestore.instance.collection("events").doc(widget.post.news_id).update({
      "view":widget.post.view ++
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,

      body: SafeArea(
          child: CustomScrollView(
            slivers: [


              SliverAppBar(
                leadingWidth: MediaQuery.of(context).size.width,
                automaticallyImplyLeading: false,
                title: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10,),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(

                          child: Image.asset("images/back.png", color: Colors
                              .green,
                            width:
                            30,height: 30,),
                        ),

                      ),
                      SizedBox(width: 5,),
                      Spacer(),


                      Text(widget.post.title.toString(),style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          overflow: TextOverflow.ellipsis
                      ),),

                      Spacer(),


                    ],
                  ),
                ),
                pinned: true,
                backgroundColor: Colors.white,
                expandedHeight: 350,
                flexibleSpace: FlexibleSpaceBar(

                  titlePadding: EdgeInsets.all(8),

                  background: Container(
                      margin: EdgeInsets.only(left: 15,right: 15,top: 60,
                          bottom: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child:   ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child : Image.network(widget.post.image, fit: BoxFit
                              .cover, width: MediaQuery.of(context).size
                              .width))),
                ),

              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [


                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(timeago.format(widget.post.createdAt.toDate()), style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 20
                          ),),

                          Row(
                            children: [

                              Container(
                                  color: Colors.green,

                                  child: Icon(Icons.visibility, color: Colors
                                      .black, size: 15,)),
                              SizedBox(width: 5,),
                              Text(widget.post.view.toString(),style: const TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                              ),),

                            ],
                          ),


                        ],
                      ),

                      SizedBox(height: 20,),

                      Text(widget.post.description, style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 20
                      ),),

                      SizedBox(height: 20,),


                    ],
                  ),
                ),
              )


            ],
          )


      ),


    );



  }

}
