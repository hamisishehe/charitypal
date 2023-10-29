import 'package:flutter/material.dart';

class Orgterms extends StatefulWidget {
  const Orgterms({super.key});

  @override
  State<Orgterms> createState() => _OrgtermsState();
}

class _OrgtermsState extends State<Orgterms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
          child:
          SingleChildScrollView(
            child: Stack(
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
                  child: Text("Terms and Conditions:", style: TextStyle(
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

                      const Text("1. Donation Policy:", style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          overflow: TextOverflow.ellipsis
                      ),),
                      const SizedBox(height: 5,),
                      Container(
                        height: 60,
                        child: Text("Donations made through the CharityPal app are voluntary and non-refundable unless otherwise stated by the event organizer.", style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),),
                      ),
                      const Text("2. Privacy and Data Security:", style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          overflow: TextOverflow.ellipsis
                      ),),

                      const SizedBox(height: 5,),
                      Container(
                        height: 70,
                        child: const Text("We prioritize the security of your "
                            "personal information and adhere to strict data protection regulations. Please refer to our Privacy Policy for more details.", style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),),
                      ),


                      const Text("3. Tax Deductions:", style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          overflow: TextOverflow.ellipsis
                      ),),

                      const SizedBox(height: 5,),
                      Container(
                        height: 70,
                        child: const Text("Receipts for tax deductions are provided by the charity or event organizer. CharityPal is not responsible for the issuance of these receipts.", style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),),
                      ),





                      const Text("4. User Conduct:", style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          overflow: TextOverflow.ellipsis
                      ),),

                      const SizedBox(height: 5,),
                      Container(
                        height: 70,
                        child: const Text("Users are expected to conduct themselves respectfully and in accordance with all applicable laws and regulations when using the app.", style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),),
                      ),

                      const Text("5. Content Usage:", style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          overflow: TextOverflow.ellipsis
                      ),),

                      const SizedBox(height: 5,),
                      Container(
                        height: 70,
                        child: const Text("Any content shared on the app, such as images, descriptions, and user-generated content, may be used for promotional or informative purposes.", style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),),
                      ),

                      const Text("6. Termination of Account:", style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          overflow: TextOverflow.ellipsis
                      ),),

                      const SizedBox(height: 5,),
                      Container(
                        height: 70,
                        child: const Text("CharityPal reserves the right to terminate user accounts for violations of these terms or any illegal activities.", style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),),
                      ),


                    ],
                  ),
                ),



              ],
            ),
          )),
    );
  }
}
