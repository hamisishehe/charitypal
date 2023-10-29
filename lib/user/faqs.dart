import 'package:flutter/material.dart';

class Faqs extends StatefulWidget {
  const Faqs({super.key});

  @override
  State<Faqs> createState() => _FaqsState();
}

class _FaqsState extends State<Faqs> {
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
            child: Text("FAQ's", style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25,
                overflow: TextOverflow.ellipsis
            ),),
          ),

          Container(
            margin: EdgeInsets.only(left: 15,top: 120,right: 8),
            child:   Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text("1. What is CharityPal?", style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    overflow: TextOverflow.ellipsis
                ),),

                Container(
                  height: 70,
                  child: const Text("CharityPal is a mobile app designed to help you easily donate to various charitable events and causes. It provides a convenient and secure way to contribute to different charity initiatives.", style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),),
                ),
                const Text("2. How can I make a donation through CharityPal?", style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    overflow: TextOverflow.ellipsis
                ),),

                const SizedBox(height: 5,),
                Container(
                  height: 70,
                  child: const Text("To make a donation, simply download the CharityPal app, create an account, browse through the available events and causes, select the one you'd like to support, and follow the guided steps to make a donation.", style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),),
                ),


                const Text("3. Is my donation secure?", style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    overflow: TextOverflow.ellipsis
                ),),

                Container(
                  height: 70,
                  child: const Text("Yes, your donation is processed securely "
                      "through our trusted payment gateway. We take data security and privacy seriously, and your payment information is encrypted to protect your personal details.", style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),),
                ),





                const Text("4. Can I get a donation receipt for tax purposes?", style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    overflow: TextOverflow.ellipsis
                ),),

                Container(
                  height: 70,
                  child: const Text("Yes, you will receive a donation receipt for tax purposes if the charity or event organizer provides them. Make sure to provide accurate information when making a donation to ensure you receive the necessary documentation.", style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),),
                ),


                const Text("5. Can I cancel or refund a donation?", style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    overflow: TextOverflow.ellipsis
                ),),

                const SizedBox(height: 5,),
                Container(
                  height: 12,
                  child: const Text("Once a donation is made, it is typically"
                      " non-refundable. If you have concerns about a specific donation, please contact the charity or event organizer directly.", style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),),
                ),

                const SizedBox(height: 5,),
                const Text("6. How do I report a problem with the app or a "
                    "specific donation?", style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    overflow: TextOverflow.ellipsis
                ),),

                const SizedBox(height: 5,),
                Container(
                  height: 70,
                  child: const Text("If you encounter any issues or have questions about a donation, please contact our support team through the Contact Us section in the app, and we'll assist you promptly.", style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),),
                ),


              ],
            ),
          ),



        ],
      )),
    );
  }
}
