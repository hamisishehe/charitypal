import 'package:charitypal/auth/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController fullname = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  var color = "0AF886";
  bool isloading = false;
  bool ishiden = true;

  _register() async{



    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text.trim(),
          password: password.text.trim());

      final userid = FirebaseAuth.instance.currentUser!.uid;

      try {
        FirebaseFirestore.instance.collection("users").doc(userid).set(
            {
              'user_id':userid,
              'fullname': fullname.text.trim(),
              'email': email.text.trim(),
              'createdAt': FieldValue.serverTimestamp(),
              'role':"user"
            }
        );
      }
      catch(e){
        print(e.toString());


      }


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
        text: 'Registration Successfully',
      );

      setState(() {
        isloading = false;
      });

    }
    catch(e ){
      if(e is FirebaseException){

        if(e.code =="weak-password"){
          QuickAlert.show(
            onCancelBtnTap: () {
              Navigator.pop(context);
            },
            context: context,
            type: QuickAlertType.warning,
            text: 'Weak Password',
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
        else if(e.code == "email-already-in-use"){
          QuickAlert.show(
            onCancelBtnTap: () {
              Navigator.pop(context);
            },
            context: context,
            type: QuickAlertType.warning,
            text: 'Email Aready used',
            confirmBtnText: 'Try Again',
            confirmBtnColor: Colors.black,
            backgroundColor: Colors.black,
            confirmBtnTextStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            barrierColor: Colors.white,
            titleColor: Colors.white,
            textColor: Colors.white,
          );

        }
        else if(e.code == "invalid-email"){
          QuickAlert.show(
            onCancelBtnTap: () {
              Navigator.pop(context);
            },
            context: context,
            type: QuickAlertType.warning,
            text: 'Enter valid email',
            confirmBtnText: 'Try Again',
            confirmBtnColor: Colors.white,
            backgroundColor: Colors.black,
            confirmBtnTextStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            barrierColor: Colors.white,
            titleColor: Colors.white,
            textColor: Colors.white,
          );

        }



        setState(() {
          isloading=false;
        });
      }


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

                  SizedBox(height: 10,),
                  Text("Welcome To CharityPal", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black
                  ),),
                  SizedBox(height: 20,),
                  Container(
                    margin: EdgeInsets.only(left: 30,right: 30),
                    child: Form(
                        key: formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: fullname,
                              validator: (value) {
                                if(value!.isEmpty){
                                  return "Fullname Required";
                                }
                              },
                              style: TextStyle(
                                  color: Colors.black
                              ),

                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  label: Text("Full name"),
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                  ),
                                prefixIcon: Container(
                                  child: Icon(Icons.person_2, color: Colors
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
                              controller: password,
                              validator: (value) {
                                if(value!.isEmpty){
                                  return "Password Required";
                                }
                              },
                              style: TextStyle(
                                  color: Colors.black
                              ),

                              cursorColor: Colors.black,
                              obscureText: ishiden,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  label: Text("Password"),
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        ishiden =!ishiden;
                                      });
                                    },
                                    child: ishiden? Icon(Icons
                                        .visibility_off, color: Colors.green,) :
                                    Icon(Icons.visibility, color: Colors
                                        .green,),
                                  ),
                                prefixIcon: Container(
                                  child: Icon(Icons.password, color: Colors
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

                                      _register();
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
                                  child:isloading? Center(child: CircularProgressIndicator(color: Colors.white,),) : Text("Register", style: TextStyle(
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
