import 'package:charitypal/controller/allusersController.dart';
import 'package:charitypal/model/usermodel.dart';
import 'package:charitypal/user/changepassword.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

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

          Container(
            margin: EdgeInsets.only(left: 15,top: 90,right: 8),
            child: Text("My Profile", style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25,
                overflow: TextOverflow.ellipsis
            ),),
          ),

          Container(
            margin: EdgeInsets.only(left: 15,top: 140,right: 8),
            child:   Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  height: 95,
                  decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Full Name", style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                overflow: TextOverflow.ellipsis
                            ),),
                            Spacer(),

                            StreamBuilder<List<UserModel>>(
                              stream: alluserFetch.fetchuser(FirebaseAuth.instance
                                  .currentUser!.uid),
                              builder: (context, snapshot) {
                                if(snapshot.hasError){
                                  return Text('${snapshot.error}');
                                }
                                else{
                                  if (snapshot.hasData ) {
                                    final userdata = snapshot.data ?? [];

                                    if(userdata.isNotEmpty){
                                      return Padding(padding: EdgeInsets.all(2),
                                        child: Column(
                                          children: userdata.map((usedetails) {

                                            return Text(usedetails.fullname, style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.black,
                                                overflow: TextOverflow.ellipsis
                                            ),);

                                          }).toList(),
                                        ),);
                                    }
                                    else{
                                      return Text("");
                                    }
                                  }

                                  else{
                                    return CircularProgressIndicator();
                                  }
                                }


                              },),

                            SizedBox(width: 5,)
                          ],
                        ),
                      ),

                      SizedBox(height: 5,),
                      GestureDetector(
                        onTap: (){
                          Get.to(ChangePassword(), fullscreenDialog: true);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Change Password  ", style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  overflow: TextOverflow.ellipsis
                              ),),
                              Spacer(),

                              Icon(Icons.arrow_forward_ios_outlined, color:
                              Colors.black,),
                              SizedBox(width: 5,)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )




              ],
            ),
          ),



        ],
      )),
    );
  }
}
