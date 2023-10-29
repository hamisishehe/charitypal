import 'package:charitypal/user/events.dart';
import 'package:charitypal/user/homepage.dart';
import 'package:charitypal/user/news.dart';
import 'package:charitypal/user/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int currentindex =0;

  List pages =[
    Homepage(),
    Events(),
    News(),
    Profile()
  ];

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
          ("images/homefilled.png" , width: 25,height: 25,color: Colors.green.withOpacity(0.9),) :
        Image.asset("images/home.png" ,
          width: 25,height: 25,color: Colors.green.withOpacity(0.5),), label:
        '',),
        BottomNavigationBarItem(icon: currentindex == 1 ? Image.asset
          ("images/eventfilled.png" , width: 25,height: 25,color: Colors.green.withOpacity(0.9),) :
        Image.asset("images/event.png",
          width: 25,height: 25,color: Colors.green.withOpacity(0.6),), label: ''),

            BottomNavigationBarItem(icon: currentindex == 2 ? Image.asset
              ("images/megafilled.png" , width: 25,height: 25,color: Colors.green.withOpacity(0.9),) : Image.asset("images/mega.png",
              width: 25,height: 25,color: Colors.green.withOpacity(0.6),), label: ''),


        BottomNavigationBarItem(icon: currentindex == 3 ? Image.asset
          ("images/userfilled.png" , width: 25,height: 25,color: Colors.green.withOpacity(0.9),) :
        Image.asset("images/user.png",
          width: 25,height: 25,color: Colors.green.withOpacity(0.6),), label: ''),


      ]),





    );

  }
}
