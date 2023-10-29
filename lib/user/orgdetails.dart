import 'package:charitypal/controller/allusersController.dart';
import 'package:charitypal/user/eventdetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:get/get.dart';

class OrgDetails extends StatefulWidget {
 final String fullname;

  const OrgDetails({super.key, required this.fullname});

  @override
  State<OrgDetails> createState() => _OrgDetailsState();
}

class _OrgDetailsState extends State<OrgDetails> {

  AlluserFetch alluserFetch = Get.put(AlluserFetch());


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

          StreamBuilder(
              stream: alluserFetch.fetchorgdetails(widget.fullname),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  final useorgdetails = snapshot.data ?? [];
                  return ListView.builder(
                    itemCount: useorgdetails.length,
                    itemBuilder: (BuildContext context, int index) {

                      final userorg = useorgdetails[index];
                      return Container(
                        margin: EdgeInsets.only(left: 8,top: 80,right: 8),
                        padding: EdgeInsets.only(left: 10,top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Row(
                              children: [
                                ProfilePicture(
                                  name: userorg.orgname,
                                  radius: 40,
                                  fontsize: 15,
                                ),
                                SizedBox(width: 15,),

                                Text(userorg.orgname,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight
                                          .w600,
                                      fontSize: 20,
                                      overflow: TextOverflow.ellipsis
                                  ),),
                              ],
                            ),
                            SizedBox(height: 10,),

                            Text("+255 "+userorg.phonenumber,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight
                                      .w400,
                                  fontSize: 20,
                                  overflow: TextOverflow.ellipsis
                              ),),
                            SizedBox(height: 10,),
                            Text(userorg.email,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight
                                      .w400,
                                  fontSize: 20,
                                  overflow: TextOverflow.ellipsis
                              ),),

                            SizedBox(height: 10,),
                            Text(userorg.website,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight
                                      .w400,
                                  fontSize: 20,
                                  overflow: TextOverflow.ellipsis
                              ),),

                            SizedBox(height: 10,),
                            Text(userorg.description,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight
                                      .w300,
                                  fontSize: 15,
                                  overflow: TextOverflow.ellipsis
                              ),),
                            SizedBox(height: 10,),

                            Container(
                              child:  Center(
                                child: Text("All Events",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight
                                          .w400,
                                      fontSize: 15,
                                      overflow: TextOverflow.ellipsis
                                  ),),
                              ),
                              height: 30,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10)
                              ),
                            ),

                            SizedBox(height: 10,),

                            SingleChildScrollView(
                              child: StreamBuilder(
                                  stream: alluserFetch.fetchorgevents(userorg.orgname),
                                  builder: (BuildContext context, snapshot) {
                                    if (snapshot.hasData) {
                                      final orgevent = snapshot.data ?? [];
                                      return Column(
                                        children: orgevent.map((orgevents) {

                                          return InkWell(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: ListTile(
                                                leading: Container(
                                                  child: Image.network(orgevents.image, fit: BoxFit.cover,),
                                                ),
                                                title: Text(orgevents.title),
                                                trailing:    TimerCountdown(
                                                  colonsTextStyle: TextStyle(
                                                      overflow: TextOverflow.ellipsis
                                                  ),
                                                  spacerWidth: 0.5,
                                                  daysDescription: "days left",
                                                  descriptionTextStyle: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.black,
                                                      overflow: TextOverflow.ellipsis
                                                  ),

                                                  timeTextStyle: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.black,
                                                      overflow: TextOverflow.ellipsis
                                                  ),
                                                  format: CountDownTimerFormat.daysOnly,
                                                  endTime: orgevents.event_date.toDate(),
                                                  onEnd: () {
                                                    print("Timer finished");
                                                  },
                                                ),


                                              ),
                                            ),

                                          );
                                        }).toList()
                                      );

                                    } else if (snapshot.hasError) {
                                      return Icon(Icons.error_outline);
                                    } else {
                                      return CircularProgressIndicator();
                                    }
                                  }),
                            )
                          ],
                        ),
                      );
                    },);

                } else if (snapshot.hasError) {
                  return Icon(Icons.error_outline);
                } else {
                  return CircularProgressIndicator();
                }
              })
        ],
      )),


    );
  }
}
