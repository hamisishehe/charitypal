import 'package:flutter/material.dart';

class OrgContactus extends StatefulWidget {
  const OrgContactus({super.key});

  @override
  State<OrgContactus> createState() => _OrgContactusState();
}

class _OrgContactusState extends State<OrgContactus> {
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
            child: Text("Contact Us:", style: TextStyle(
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
                  height: 70,
                  child: const Text("For any questions, concerns, or feedback, please reach out to us at the following contact points:", style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),),
                ),

                const SizedBox(height: 5,),
                const Text("Email: support@charitypalapp.com", style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    overflow: TextOverflow.ellipsis
                ),),

                const SizedBox(height: 5,),
                const Text("Phone: +1255 744982380", style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    overflow: TextOverflow.ellipsis
                ),),

                const SizedBox(height: 5,),
                const Text("Address: CharityPal App,"
                    "Tanga, Tanzania", style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    overflow: TextOverflow.ellipsis
                ),),


              ],
            ),
          ),



        ],
      )),
    );
  }
}
