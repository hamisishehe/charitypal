import 'package:charitypal/model/eventmodel.dart';
import 'package:charitypal/user/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:draggable_menu/draggable_menu.dart';

class Eventdetail extends StatefulWidget {
  final eventmodel post;
  const Eventdetail({super.key, required this.post});

  @override
  State<Eventdetail> createState() => _EventdetailState();
}

class _EventdetailState extends State<Eventdetail> {

  TextEditingController email = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController amount = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool isloading = false;
  bool ishiden = true;




  // Future<void> checkAndAddToFavorites() async {
  //   final favoritesCollection = FirebaseFirestore.instance.collection('favorite');
  //   final snapshot = await favoritesCollection
  //       .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid).where("event_id", isEqualTo: widget.post.event_id)
  //       .get();
  //
  //   if (snapshot.docs.isEmpty) {
  //     // Post is not in favorites for this user, add it
  //     favoritesCollection.add({
  //       'event_id': widget.post.event_id,
  //       'userId': FirebaseAuth.instance.currentUser!.uid,
  //     });
  //   } else {
  //     // Post is already in favorites for this user
  //     for (var doc in snapshot.docs) {
  //       await favoritesCollection.doc(doc.id).delete();
  //     }
  //   }
  //
  //   setState(() {
  //     isloading = false;
  //   });
  // }


  @override
  void initState() {
    // TODO: implement initState

    FirebaseFirestore.instance.collection("events").doc(widget.post.event_id).update({
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

                    child: Image.asset("images/back.png", color: Colors.green,
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


              FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance.collection('favorite').where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid).where("event_id", isEqualTo: widget.post.event_id)
                      .get(),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.hasData) {
                      final favo = userSnapshot.data!.docs;

                      bool favor = favo.isEmpty == true;

                        return InkWell(
                        onTap: () async{
                          if(favor){
                            FirebaseFirestore.instance.collection('favorite').add({
                              'event_id': widget.post.event_id,
                              'userId': FirebaseAuth.instance.currentUser!.uid,
                            });

                            setState(() {
                              favor = true;
                            });

                          }
                          else{
                            QuerySnapshot f= await FirebaseFirestore.instance.collection("favorite")
                            .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid).where("event_id", isEqualTo: widget.post.event_id)
                            .get();

                            f.docs.forEach((doc) {
                              doc.reference.delete();
                            });

                            setState(() {
                              favor = false;
                            });

                          }

                        },
                        child: Icon(favor ? Icons.bookmark_border : Icons.bookmark, color: Colors.green, size: 25, ),

                      );



                    } else {

                      return Center(child: CircularProgressIndicator(color:
                      Colors.white,),);
                    }
                  },
              ),
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
                                      .white, size: 15,)),
                              SizedBox(width: 5,),
                              Text(widget.post.view.toString(),style: const TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                              ),),

                            ],
                          ),


                          Row(
                            children: [
                              Icon(Icons.location_on, color: Colors.green,),
                              Text(widget.post.location, style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15
                              ),),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 20,),

                      Text(widget.post.description, style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
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

      bottomNavigationBar: Container(
        margin: EdgeInsets.all(8),
        height: 50,
        child: ElevatedButton(
            onPressed: (){

              Get.bottomSheet(

                  Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.only(left: 20,right: 20, ),
                        height: 500,
                        child: SingleChildScrollView(
                          child: Form(
                            key: formkey,

                            child: Column(
                              children: [

                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("", style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15
                                      ),),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: IconButton(onPressed: (){
                                          Navigator.pop(context);
                                        }, icon: Icon
                                          (Icons.close, color: Colors.black,
                                          size: 25,)),
                                      )


                                    ],
                                  ),
                                ),

                                TextFormField(
                                  controller: fullname,
                                  validator: (value) {
                                    if(value!.isEmpty){
                                      return "Full name Required";
                                    }
                                  },
                                  style: TextStyle(
                                      color: Colors.white
                                  ),

                                  cursorColor: Colors.white,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.green,
                                      label: Text("Full name"),
                                      labelStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold
                                      ),
                                      prefixIcon: Icon(Icons.person_2, color: Colors.white,),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide(color:
                                          Colors.green.withOpacity(0.2))
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide(color:
                                          Colors.green.withOpacity(0.2))
                                      )
                                  ),

                                ),
                                SizedBox(height: 20,),

                                TextFormField(
                                  controller: email,
                                  validator: (value) {
                                    if(value!.isEmpty){
                                      return "Email Required";
                                    }
                                  },
                                  style: TextStyle(
                                      color: Colors.white
                                  ),

                                  keyboardType: TextInputType.emailAddress,
                                  cursorColor: Colors.white,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.green,
                                      label: Text("Email"),
                                      labelStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold
                                      ),
                                      prefixIcon: Icon(Icons.email, color:
                                      Colors.white,),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide(color:
                                          Colors.green.withOpacity(0.2))
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide(color:
                                          Colors.green.withOpacity(0.2))
                                      )
                                  ),

                                ),

                                SizedBox(height: 20,),

                                TextFormField(
                                  controller: phonenumber,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if(value!.isEmpty){
                                      return "Phonenumber Required";
                                    }
                                  },
                                  style: TextStyle(
                                      color: Colors.white
                                  ),

                                  cursorColor: Colors.white,
                                  maxLength: 9,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.green,
                                      label: Text("Phone number"),
                                      prefix: Text("+255  "),
                                      helperStyle: TextStyle(
                                          color: Colors.black
                                      ),
                                      hintStyle: TextStyle(
                                          color: Colors.white
                                      ),

                                      labelStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold
                                      ),
                                      prefixIcon: Icon(Icons.phone, color: Colors.white,),

                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide(color:
                                          Colors.green)
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide(color:
                                          Colors.green)
                                      )
                                  ),

                                ),
                                SizedBox(height: 5,),

                                TextFormField(
                                  controller: amount,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if(value!.isEmpty){
                                      return "Amount required";
                                    }
                                  },

                                  style: TextStyle(
                                      color: Colors.white
                                  ),

                                  cursorColor: Colors.white,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.green,
                                      label: Text("Amount"),
                                      labelStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold
                                      ),
                                      prefixIcon: Icon(Icons.money, color: Colors.white,),

                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide(color:
                                          Colors.green)
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide(color:
                                          Colors.green)
                                      )
                                  ),

                                ),
                                SizedBox(height: 20,),

                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 55,
                                  child: ElevatedButton(
                                      onPressed: (){
                                        if(formkey.currentState!.validate()){
                                          setState(() {
                                            isloading= true;
                                          });

                                          _handlePaymentInitialization();

                                        }
                                        else{
                                          setState(() {
                                            isloading = false;
                                          });
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20)
                                          ),
                                          backgroundColor: Color(0xff152238)
                                      ),
                                      child: isloading? Center(child:
                                      CircularProgressIndicator(color: Colors.white,),) :Text("Donate", style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 25
                                      ),)),
                                ),


                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
              );


            },
            style: ElevatedButton.styleFrom(

                backgroundColor: Colors.green
            ),
            child:Text("Donate", style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 25
            ),)),
      ),

    );



  }

  _handlePaymentInitialization() async {
    final Customer customer = Customer(
        name: fullname.text.trim(),
        phoneNumber: "+255"+phonenumber.text.trim(),
        email: email.text.trim());

    final Flutterwave flutterwave = Flutterwave(
        context: context,
        publicKey: "FLWPUBK_TEST-7affb0702186b09609cae8180f26c628-X",
        currency: "TZs",
        redirectUrl: 'https://facebook.com',
        txRef: DateTime.now().millisecondsSinceEpoch.toString(),
        amount: amount.text.trim(),
        customer: customer,
        paymentOptions: "card, payattitude, barter, bank transfer, ussd",
        customization: Customization(title: "Donate for "+ widget.post.title),
        isTestMode: true);

    final ChargeResponse response = await flutterwave.charge();


    int totalamount = int.parse(amount.text);


    if(response.success == true){
      FirebaseFirestore.instance.collection("transaction").add({
        "transaction_id":response.transactionId,
        "event_id":widget.post.event_id,
        "user_id":FirebaseAuth.instance.currentUser!.uid,
        "amount":totalamount,
        "createdAt": FieldValue.serverTimestamp(),
      });
      Get.back();


    }
    print(response.toString());
    print(response.success);
    print(response.status);
    print(response.transactionId);
    print(response.txRef);
    print(response.toJson());
    print("${response.toJson()}");

    setState(() {
      isloading = false;
    });

  }
}
