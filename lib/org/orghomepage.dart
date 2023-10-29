import 'package:charitypal/org/orgdashboard.dart';
import 'package:charitypal/org/orgevents.dart';
import 'package:charitypal/org/orgnews.dart';
import 'package:charitypal/org/orgprofile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Orghomepage extends StatefulWidget {
  const Orghomepage({super.key});

  @override
  State<Orghomepage> createState() => _OrghomepageState();
}

class _OrghomepageState extends State<Orghomepage> {

  List pages =[
    Orgdashboard(),
    Orgevents(),
    Orgnews(),
    Orgprofile()

  ];

  int currentindex =0;

  changepage(int index){
    setState(() {
      currentindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.2),


      body: pages.elementAt(currentindex),




      bottomNavigationBar: BottomNavigationBar(

          backgroundColor: Colors.white,
          onTap: changepage,
          elevation: 30,
          currentIndex: currentindex,
          type: BottomNavigationBarType.fixed,


          items: [
            BottomNavigationBarItem(icon: currentindex == 0 ? Image.asset
              ("images/appsfilled.png" , width: 25,height: 25,color: Colors.green.withOpacity(0.9),) : Image.asset("images/apps.png" ,
              width: 25,height: 25,color: Colors.green.withOpacity(0.5),), label:
            '', backgroundColor: Color(0xff323232),),
            BottomNavigationBarItem(icon: currentindex == 1 ? Image.asset
              ("images/eventfilled.png" , width: 25,height: 25,color: Colors.green.withOpacity(0.9),) : Image.asset("images/event.png",
              width: 25,height: 25,color: Colors.green.withOpacity(0.5),), label: ''),

            BottomNavigationBarItem(icon: currentindex == 2 ? Image.asset
              ("images/megafilled.png" , width: 25,height: 25,color: Colors.green.withOpacity(0.9),) : Image.asset("images/mega.png",
              width: 25,height: 25,color: Colors.green.withOpacity(0.5),), label: ''),


            BottomNavigationBarItem(icon: currentindex == 3 ? Image.asset
              ("images/userfilled.png" , width: 25,height: 25,color:Colors.green.withOpacity(0.9),) :  Image.asset("images/user.png",
              width: 25,height: 25,color: Colors.green.withOpacity(0.5),), label: ''),


          ]),



    );
  }
}
