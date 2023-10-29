import 'package:charitypal/auth/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {

  TextEditingController email = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  var color = "0AF886";
  bool isloading = false;

  forgot() async {
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: email.text.trim());

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
        text: 'Check your Email ',
      );

    }
    catch(e){
      if(e is FirebaseException){
        if(e.code =="user-not-found"){

          QuickAlert.show(
            confirmBtnColor: Colors.black,
            context: context,
            type: QuickAlertType.error,
            title: 'Oops...',
            text: 'There no user record corresponding to this identifier or the user may have been deleted',
            backgroundColor: Colors.green,
            titleColor: Colors.black,
            textColor: Colors.black,
          );

        }
      }


    }
    setState(() {
      isloading=false;
    });


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
                    padding: EdgeInsets.only(top: 40,left: 10),
                    child: Row(
                      children: [
                        IconButton(onPressed: (){
                          Get.back();
                        }, icon: Image.asset("images/back.png", scale: 2.2,
                            color: Colors.green),)
                      ],
                    ),
                  ),

                  SizedBox(height: 60,),
                  Container(
                    child: Image.asset("images/lv2.png", scale: 2.2,),
                  ),


                  Container(
                    margin: EdgeInsets.only(left: 30,right: 30),
                    child: Form(
                        key: formkey,
                        child: Column(
                          children: [

                            TextFormField(
                              controller: email,
                              validator: (value) {
                                if(value!.isEmpty){
                                  return "Email Required";
                                }
                              },
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
                                      borderRadius: BorderRadius.circular(9),
                                      color: Colors.green
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
                                    setState(() {
                                      isloading = true;
                                    });

                                    if (formkey.currentState!.validate()) {

                                      forgot();

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
                                  child:isloading ? CircularProgressIndicator( color: Colors.white,) : Text("Reset Password", style: TextStyle(
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
