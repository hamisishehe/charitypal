import 'package:charitypal/auth/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

class Charityregister extends StatefulWidget {
  const Charityregister({super.key});

  @override
  State<Charityregister> createState() => _CharityregisterState();
}

class _CharityregisterState extends State<Charityregister> {
  TextEditingController email = TextEditingController();
  TextEditingController decription = TextEditingController();
  TextEditingController orgname = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController website = TextEditingController();
  TextEditingController address = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  var color = "0AF886";
  bool isloading = false;
  bool ishiden = true;
  
  register(){
    final oid= DateTime.now().millisecondsSinceEpoch.toString();

    try{
      FirebaseFirestore.instance.collection("organization").doc(oid).set({
        "organization_id":oid,
        "createdAt":FieldValue.serverTimestamp(),
        "orgname":orgname.text.trim(),
        "phonenumber":phonenumber.text.trim(),
        "email":email.text.trim(),
        "website":website.text.trim(),
        "description":decription.text.trim(),
        "status":"pending"
      });


      QuickAlert.show(
        context: context,
        backgroundColor: Color(0xff2B4E74),
        type: QuickAlertType.success,
        title: 'Done...',
        textColor: Colors.white,
        onConfirmBtnTap: (){
          Get.to(Login());
        },
        confirmBtnColor: Colors.white,
        confirmBtnTextStyle: TextStyle(
            color: Colors.black
        ),
        text: 'Information Submitted',
      );

    }
    catch(e){

      QuickAlert.show(
        onCancelBtnTap: () {
          Navigator.pop(context);
        },
        context: context,
        type: QuickAlertType.warning,
        text: 'Failed',
        confirmBtnText: 'Try Again',
        confirmBtnColor: Colors.black,
        backgroundColor: Colors.black,
        confirmBtnTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        barrierColor: Colors.white,
        titleColor: Colors.white,
        textColor: Colors.white,
      );


    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(

                children: [
                  Container(
                    padding: EdgeInsets.only(top: 30,left: 10),
                    child: Row(
                      children: [
                        IconButton(onPressed: (){
                          Get.back();
                        }, icon: Image.asset("images/back.png", scale: 2.2,
                            color: Colors.green),)
                      ],
                    ),
                  ),

                  Container(
                    child: Image.asset("images/lv2.png", scale: 2.2,),
                  ),


                  Container(
                    child: Center(
                      child: Text("Feel free to provide more details or context"
                          ,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black
                      ),),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    margin: EdgeInsets.only(left: 30,right: 30),
                    child: Form(
                        key: formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: orgname,
                              validator: (value) {
                                if(value!.isEmpty){
                                  return "Organization Name Required";
                                }
                              },
                              style: TextStyle(
                                  color: Colors.black
                              ),

                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  label: Text("Organization Name"),
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                  ),
                                prefixIcon: Container(
                                  child: Icon(Icons.group_outlined, color: Colors
                                      .white,),
                                  margin: EdgeInsets.all(9),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.green,
                                  ),
                                ),

                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Colors
                                        .green, width: 1)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Colors
                                        .green, width: 1)
                                ),
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
                                  color: Colors.black
                              ),

                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  label: Text("Email"),
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                  ),
                                prefixIcon: Container(
                                  child: Icon(Icons.email, color: Colors
                                      .white,),
                                  margin: EdgeInsets.all(9),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.green,
                                  ),
                                ),

                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Colors
                                        .green, width: 1)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Colors
                                        .green, width: 1)
                                ),
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
                              style: const TextStyle(
                                  color: Colors.black
                              ),

                              cursorColor: Colors.black,
                              maxLength: 9,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  label: Text("Phone number"),
                                  prefix: Text("+255  "),
                                  helperStyle: const TextStyle(
                                    color: Colors.black
                                  ),
                                  hintStyle: const TextStyle(
                                      color: Colors.black
                                  ),

                                  labelStyle: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                  ),
                                prefixIcon: Container(
                                  child: Icon(Icons.phone, color: Colors
                                      .white,),
                                  margin: EdgeInsets.all(9),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.green,
                                  ),
                                ),

                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Colors
                                        .green, width: 1)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Colors
                                        .green, width: 1)
                                ),
                              ),

                            ),
                            SizedBox(height: 5,),

                            TextFormField(
                              controller: website,
                              keyboardType: TextInputType.url,

                              style: TextStyle(
                                  color: Colors.black
                              ),

                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  label: Text("Website (Option)"),
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                  ),
                                prefixIcon: Container(
                                  child: Icon(Icons.web, color: Colors
                                      .white,),
                                  margin: EdgeInsets.all(9),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.green,
                                  ),
                                ),

                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Colors
                                        .green, width: 1)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Colors
                                        .green, width: 1)
                                ),
                              ),

                            ),
                            SizedBox(height: 20,),

                            TextFormField(
                              controller: decription,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              maxLines: null,

                              validator: (value) {
                                if(value!.isEmpty){
                                  return "Description Required";
                                }
                              },
                              style: TextStyle(
                                  color: Colors.black
                              ),

                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  label: Text("Description"),
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                  ),
                                prefixIcon: Container(
                                  child: Icon(Icons.description, color: Colors
                                      .white,),
                                  margin: EdgeInsets.all(9),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.green,
                                  ),
                                ),

                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Colors
                                        .green, width: 1)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Colors
                                        .green, width: 1)
                                ),
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

                                      register();
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
                                      backgroundColor: Color(0xff152038)
                                  ),
                                  child: isloading? const Center(child: CircularProgressIndicator(color: Colors.white,),) :const Text("Submit", style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 25
                                  ),)),
                            ),


                          ],
                        )),
                  ),



                ],
              ),
            ),
          )),
    );
  }
}
