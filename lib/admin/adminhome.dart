import 'package:charitypal/admin/admindashboard.dart';
import 'package:charitypal/admin/adminviewevents.dart';
import 'package:charitypal/admin/profie.dart';
import 'package:charitypal/admin/vieworganization.dart';
import 'package:charitypal/admin/viewusers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int currentindex =0;

  changepage(int index){
    setState(() {
      currentindex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar:CupertinoTabBar(
          backgroundColor: Color(0xff323232),
          currentIndex: currentindex,
          inactiveColor: Colors.white,
          activeColor: Color(0xff0AF886).withOpacity(0.5),
          onTap: changepage,
          height: 60,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: currentindex == 0 ? Image.asset("images/appsfilled.png" , width: 25,height: 25,color: Color(0xff0AF886).withOpacity(0.5),) : Image.asset("images/apps.png" , width: 25,height: 25,color: Colors.white,), label: 'Dashboard',),
            BottomNavigationBarItem(icon: currentindex == 1 ? Image.asset("images/eventfilled.png" , width: 25,height: 25,color: Color(0xff0AF886).withOpacity(0.5),) : Image.asset("images/event.png" , width: 25,height: 25,color: Colors.white,), label: 'Events',),
            BottomNavigationBarItem(icon: currentindex == 2 ? Image.asset("images/donationfilled.png" , width: 25,height: 25,color: Color(0xff0AF886).withOpacity(0.5),) : Image.asset("images/donation.png" , width: 25,height: 25,color: Colors.white,), label: 'Org',),
            BottomNavigationBarItem(icon: currentindex == 3 ? Image.asset("images/userfilled.png" , width: 25,height: 25,color: Color(0xff0AF886).withOpacity(0.5),) : Image.asset("images/user.png" , width: 25,height: 25,color: Colors.white,), label: 'users',),
            BottomNavigationBarItem(icon: currentindex == 4 ? Image.asset("images/settingsfilled.png" , width: 25,height: 25,color: Color(0xff0AF886).withOpacity(0.5),) : Image.asset("images/settings.png", width: 25,height: 25,color: Colors.white,), label: 'Settings'),

          ]),
        tabBuilder: (context, index) {
          switch(index){
            case 0:
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(child: Admindashboard());
                },

              );

            case 1:
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(child: Adminviewevents());
                },
              );

            case 2:
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(child: Vieworganization());
                },
              );

            case 3:
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(child: Viewusers());
                },
              );

            case 4:
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(child: AdminProfile());
                },
              );
          }
          return Container();
        },);
  }
}
