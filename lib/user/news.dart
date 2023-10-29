import 'package:charitypal/controller/EventM.dart';
import 'package:charitypal/controller/allusersController.dart';
import 'package:charitypal/user/notification.dart';
import 'package:charitypal/user/orgdetails.dart';
import 'package:charitypal/user/singlenews.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import 'package:timeago/timeago.dart' as timeago;


class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {

  EventController eventController = Get.put(EventController());
  AlluserFetch alluserFetch = Get.put(AlluserFetch());
  late int likecount;

  TextEditingController _comment = TextEditingController();
  TextEditingController username = TextEditingController();


  Future getorgname () async{
    try {
      QuerySnapshot orgname = await FirebaseFirestore.instance.collection(
          "users").where(
          "user_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();

      for (var doc in orgname.docs) {
        setState(() {
          username.text = doc["fullname"];
        });
      }

    }
    catch(e){
      print(e);
    }

  }


  late bool ishidden ;

  @override
  void initState() {
    // TODO: implement initState

    setState(() {
      ishidden = true;
    });

    getorgname();
    super.initState();
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
                    child: Image.asset("images/lv2.png", scale: 3.2,),
                  ),
                  StreamBuilder(stream: eventController.fetchnot(
                      FirebaseAuth.instance.currentUser!.uid),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        final usernot = snapshot.data ?? [];

                        return  GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute
                              (builder: (context) => NotificationPage(),));
                          },
                          child: badges.Badge(
                            position: badges.BadgePosition.topEnd(top: -2, end: 5),
                            badgeContent: Text(usernot.length.toString()),
                            badgeStyle: badges.BadgeStyle(
                                badgeColor: Colors.green
                            ),
                            child:  IconButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute
                                (builder: (context) => NotificationPage(),));
                            }, icon: Icon(Icons.notifications, color: Colors
                                .green,)),
                          ),
                        );

                      }

                      else if(snapshot.hasError){
                        return Text('${snapshot.error}');
                      }
                      else{

                        return CircularProgressIndicator(color: Colors.black,);
                      }

                    },)
                ],
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 80,left: 15,right: 15),
            child: Container(
              height: 60,
              child: StreamBuilder(
                  stream: alluserFetch.fetchallorg(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final allorg = snapshot.data ?? [];

                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: allorg.length,
                        itemBuilder: (BuildContext context, int index) {
                          final allo = allorg[index];
                          return InkWell(
                            child: Container(
                              width: MediaQuery.of(context).size.width/2,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.green.withOpacity(0.5)
                              ),
                              margin: EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  ProfilePicture(
                                    name: allo.fullname,
                                    radius: 20,
                                    fontsize: 15,
                                  ),
                                  SizedBox(width: 15,),

                                  Text(allo.fullname,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight
                                            .w600,
                                        fontSize: 20,
                                        overflow: TextOverflow.ellipsis
                                    ),),
                                ],
                              ),
                            ),
                            onTap: (){
                              Get.to(OrgDetails(fullname: allo.fullname));
                            },
                          );
                        },);

                    } else if (snapshot.hasError) {
                      return Icon(Icons.error_outline);
                    } else {
                      return Center(child: CircularProgressIndicator(color: Colors.white,));
                    }
                  })

            )
          ),




          Container(
            margin: EdgeInsets.only(top: 160,left: 15,right: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20)
            ),
            child: StreamBuilder(
                stream: eventController.fetchallnews(),
                builder: (context, snapshot) {
                  if(snapshot.hasError){
                    return Center(child: Text('${snapshot.error}'),);
                  }
                  else if(snapshot.hasData){
                    final news = snapshot.data ?? [];

                    if(news.isEmpty){
                      return Center(child: Image.asset("images/news.png", scale: 4,),);
                    }
                    else {
                      return ListView.builder(
                        itemCount: news.length,
                        itemBuilder: (BuildContext context, int index) {
                          final newslist = news[index];

                         bool isliked = (newslist.likes[FirebaseAuth.instance.currentUser!.uid] == true);

                          return Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: InkWell(
                              child: Container(

                                margin: EdgeInsets.all(10),
                                child: Column(
                                  children: [

                                    InkWell(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                      ProfilePicture(
                                 name: newslist.organization_name,
                                  radius: 20,
                                  fontsize: 15,
                                  ),
                                          SizedBox(width: 10,),
                                          Text(newslist.organization_name,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight
                                                    .w600,
                                                fontSize: 15
                                            ),),



                                        ],
                                      ),
                                      onTap: (){
                                        Get.to(OrgDetails(fullname: newslist.organization_name), fullscreenDialog: true);
                                      },
                                    ),
                                    SizedBox(height: 10,),

                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius
                                                .circular(10),
                                            topRight: Radius.circular(10)),

                                      ),
                                      height: 180,
                                      child: Image.network(
                                        newslist.image, fit: BoxFit
                                          .cover,),
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                    ),

                                    Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      height: 130,
                                      color: Colors.white.withOpacity(0.1),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [

                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [

                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.all(
                                                        8.0),
                                                    child: Text(newslist.title,
                                                      style:
                                                      TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          overflow: TextOverflow
                                                              .ellipsis
                                                      ),),

                                                  ),
                                                  Spacer(),

                                                  Text(timeago.format(
                                                      newslist.createdAt
                                                          .toDate()),
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight
                                                            .w600,
                                                        fontSize: 12
                                                    ),),
                                                  SizedBox(width: 10,),

                                                ],
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                              ),

                                              Row(
                                                children: [
                                                  SizedBox(width: 8,),
                                                  InkWell(
                                                  onTap: (){


                                                    if(isliked){
                                                      FirebaseFirestore.instance.collection("news").doc(newslist.news_id).update({
                                                        'likes.${FirebaseAuth.instance.currentUser!.uid}': false,
                                                        'likecount':newslist.likecount -1
                                                      });

                                                      setState(() {
                                                        isliked = false;
                                                        newslist.likes[FirebaseAuth.instance.currentUser!.uid] = false;

                                                      });


                                                    }
                                                    else if(!isliked){

                                                      FirebaseFirestore.instance.collection("news").doc(newslist.news_id).update({
                                                        'likes.${FirebaseAuth.instance.currentUser!.uid}': true,
                                                        'likecount':newslist.likecount +1
                                                      });

                                                      setState(() {
                                                        isliked = true;
                                                        newslist.likes[FirebaseAuth.instance.currentUser!.uid] = true;

                                                      });


                                                    }


                                                      },
                                                      child:isliked ? Image.asset("images/likef.png", width: 20,height: 20, color: Colors.green,) : Image.asset("images/liken.png", width: 20,height: 20,color: Colors.green) ,

                                                  ),
                                                  SizedBox(width: 10,),
                                                  Text
                                                    (newslist.likecount.toString(),
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w500,
                                                      overflow: TextOverflow
                                                          .ellipsis,

                                                    ),),
                                                  SizedBox(width: 25,),

                                                  StreamBuilder(
                                                      stream: eventController.comment(newslist.news_id),
                                                      builder:
                                                          (BuildContext context,
                                                              AsyncSnapshot
                                                                  snapshot) {
                                                        if (snapshot.hasData) {

                                                          final co_count = snapshot.data ?? [];

                                                          return Row(
                                                            children: [
                                                              InkWell(
                                                                onTap: (){
                                                                  Get.bottomSheet(
                                                                      Container(
                                                                        height: 500,
                                                                        color: Colors.white,
                                                                        child: Column(
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: [
                                                                            Material(
                                                                              elevation: 3,
                                                                              child: Row(
                                                                                children: [
                                                                                  Spacer(),
                                                                                  Text(co_count.length.toString() + "  Comments",
                                                                                    style: const TextStyle(
                                                                                        color: Colors.black,
                                                                                        fontWeight: FontWeight
                                                                                            .bold,
                                                                                        fontSize: 15
                                                                                    ),),
                                                                                  Spacer(),

                                                                                  IconButton(onPressed: (){
                                                                                    setState(() {
                                                                                      _comment.clear();
                                                                                    });
                                                                                    Get.back();
                                                                                  }, icon: Icon(Icons.close, color: Colors.green, size: 30,)),
                                                                                ],
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              ),
                                                                            ),

                                                                            Expanded(
                                                                                flex: 9,
                                                                                child: SingleChildScrollView(
                                                                                  child: StreamBuilder(
                                                                                    stream: eventController.comment(newslist.news_id),
                                                                                    builder: (context, snapshot) {
                                                                                      if(snapshot.hasData){
                                                                                        final co = snapshot.data ?? [];
                                                                                        return Column(
                                                                                          children: co.map((com){
                                                                                            return Container(
                                                                                                margin: EdgeInsets.only(top: 5),
                                                                                                child: ListTile(
                                                                                                  leading:  ProfilePicture(
                                                                                                    name: com.fullname,
                                                                                                    radius: 15,
                                                                                                    fontsize: 15,
                                                                                                  ),
                                                                                                  title: Text(com.fullname,
                                                                                                    style: const TextStyle(
                                                                                                        color: Colors.black,
                                                                                                        fontWeight: FontWeight
                                                                                                            .bold,
                                                                                                        fontSize: 15
                                                                                                    ),),
                                                                                                  subtitle: Text(com.comment,
                                                                                                    style: const TextStyle(
                                                                                                        color: Colors.black,
                                                                                                        fontWeight: FontWeight
                                                                                                            .w400,
                                                                                                        fontSize: 15
                                                                                                    ),),



                                                                                                )
                                                                                            );

                                                                                          }).toList(),
                                                                                        );

                                                                                      }
                                                                                      else if(snapshot.hasError){
                                                                                        return Text('${snapshot.error}');
                                                                                      }
                                                                                      else{
                                                                                        return Center(child: CircularProgressIndicator(color: Colors.white,));
                                                                                      }
                                                                                    },
                                                                                  ),
                                                                                ) ),

                                                                            Expanded(
                                                                                flex: 2,
                                                                                child: Container(
                                                                                  height: 100,
                                                                                  color: Colors.transparent,
                                                                                  margin: EdgeInsets.only(left: 20),
                                                                                  child:

                                                                                  Row(
                                                                                    children: [

                                                                                      Expanded(
                                                                                        flex:8,
                                                                                        child: TextFormField(
                                                                                          controller: _comment,
                                                                                          keyboardType: TextInputType.multiline,
                                                                                          maxLines: null,

                                                                                          style: TextStyle(
                                                                                              fontSize: 17,
                                                                                              fontWeight: FontWeight.bold
                                                                                          ),

                                                                                          decoration: InputDecoration(
                                                                                            filled: true,
                                                                                            fillColor: Colors.white.withOpacity(0.2)


                                                                                          ),

                                                                                        )
                                                                                      ),

                                                                                      Expanded(
                                                                                          flex: 1,
                                                                                          child:InkWell(
                                                                                              onTap: (){
                                                                                                if(_comment.text.isNotEmpty){
                                                                                                  FirebaseFirestore.instance.collection("news").doc(newslist.news_id).collection("comment").add({
                                                                                                    'fullname': username.text,
                                                                                                    'comment': _comment.text,
                                                                                                    'createdAt':FieldValue.serverTimestamp()

                                                                                                  });

                                                                                                  setState(() {
                                                                                                    _comment.clear();
                                                                                                  });

                                                                                                }
                                                                                              },

                                                                                              child: Icon(Icons.send, color: Colors.green,size: 25,)) ),

                                                                                    ],
                                                                                  ),

                                                                                ))


                                                                          ],
                                                                        ),
                                                                      )


                                                                  );
                                                                },
                                                                child: Image.asset("images/comment2.png" , width: 20,height: 20, color: Colors.green,),

                                                              ),

                                                              SizedBox(width: 10,),
                                                              Text(co_count.length.toString(),
                                                                style: TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors.black,
                                                                  fontWeight: FontWeight.w500,
                                                                  overflow: TextOverflow
                                                                      .ellipsis,

                                                                ),),
                                                            ],
                                                          );
                                                        } else if (snapshot
                                                            .hasError) {
                                                          return Icon(Icons
                                                              .error_outline);
                                                        } else {
                                                          return Center(child: CircularProgressIndicator(color: Colors.white,));
                                                        }
                                                      })
                                                ],

                                              ),

                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text
                                                  (newslist.description,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    overflow: TextOverflow
                                                        .ellipsis,

                                                  ),),
                                              ),
                                            ],
                                          ),

                                        ],
                                      ),
                                    )


                                  ],
                                ),


                              ),
                              onTap: () {
                                Get.to(Singlenews(post: newslist));
                              },
                            ),
                          );
                        },);
                    }

                  }
                  else{
                    return Center(child: CircularProgressIndicator(color: Colors.white,));
                  }
                },)
          )










        ],
      )),
    );
  }
}
