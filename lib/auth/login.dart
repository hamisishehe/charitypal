import 'package:charitypal/admin/adminhome.dart';
import 'package:charitypal/auth/charityregister.dart';
import 'package:charitypal/auth/forgotpassword.dart';
import 'package:charitypal/auth/register.dart';
import 'package:charitypal/org/orghomepage.dart';
import 'package:charitypal/user/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  var color = "0AF886";
  bool isloading = false;
  bool ishiden = true;


  route(){
    User? user = FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance.collection("users").doc(user!.uid).get().then((DocumentSnapshot documentSnapshot) {

      if(documentSnapshot.exists){
        if(documentSnapshot.get("role") == "user"){
          Get.off(Home());
        }
        else if(documentSnapshot.get("role") == "admin"){

          Get.off(AdminHome());

        }
        else if(documentSnapshot.get("role") == "org"){

          Get.off(Orghomepage());

        }
        else{

          Get.off(Orghomepage());

        }

      }else{
        print("Not exist");
      }

    });
  }


  login () async{

    try{

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text.trim(),
          password: password.text.trim()
      );

      route();
    }

    catch (e){
      QuickAlert.show(
        confirmBtnColor: Colors.black,
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'Sorry, User Not Found',
        backgroundColor: Colors.green,
        titleColor: Colors.black,
        textColor: Colors.black,
      );
      setState(() {
        isloading = false;
      });

    }

  }

  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Stack(

            children: [

              Container(
                child: Column(
                  children: [
                    SizedBox(height: 120,),
                    Container(
                      child: Center(
                        child: Image.asset("images/lv2.png", scale: 2.2,),
                      ),
                    ),

                    Text("Welcome Back! Your journey continues.", style:
                    TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black
                    ),),

                  ],
                ),

              ),

               Container(
                  margin: EdgeInsets.only(left: 30,right: 30,top: 220),
                  child: SingleChildScrollView(
                    child: Form(
                        key: formkey,
                        child: Column(
                          children: [

                            SizedBox(height: 10,),

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
                                  label: const Text("Password"),
                                  labelStyle: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                  ),
                                  prefixIcon: Container(
                                      margin: EdgeInsets.all(9),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.green,
                                      ),
                                      child: Icon(Icons.password, color: Colors.white,)),
                                  suffixIcon: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        ishiden =!ishiden;
                                      });
                                    },
                                    child: ishiden? Icon(Icons
                                        .visibility_off, color: Colors.green,) :
                                    Icon(Icons.visibility, color: Colors.green,),
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
                            SizedBox(height: 10,),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(padding: EdgeInsets.all(3.0),
                                child: GestureDetector(
                                  onTap: (){
                                    Get.to(()=>Forgotpassword());
                                  },
                                  child: const Text("Forgot Password", style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black,
                                    decoration: TextDecoration.underline
                                  ),),
                                ),),
                            ),
                            SizedBox(height: 10,),

                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 55,
                              child: ElevatedButton(
                                  onPressed: (){
                                    if(formkey.currentState!.validate()){
                                      setState(() {
                                        isloading= true;
                                      });

                                      login();
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
                                  child: isloading?  Center(child: CircularProgressIndicator(color: Colors.white,),) :Text("Login", style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 25
                                  ),)),
                            ),
                            SizedBox(height: 20,),
                            Container(
                                child: GestureDetector(
                                  onTap: (){
                                    Get.to(()=>Register());
                                  },
                                  child: const Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Don't have an account?  ", style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          color: Colors.black
                                      ),),
                                      Text("Register here", style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          color: Colors.green,
                                          decoration: TextDecoration.underline
                                      ),)
                                    ],
                                  ),
                                )),


                          ],


                        )),
                  ),
                ),
              






            ],

          ),
      ),

      bottomNavigationBar: Container(
        height: 50,
        child:  GestureDetector(
          child: const Column(
            children: [
              Text("Have an Organization?  ", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.black
              ),),
              Text("Register here", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.green,
                  decoration: TextDecoration.underline
              ),)
            ],
          ),
          onTap: (){
            Get.to(Charityregister());

          },
        ),
      ),
    );
  }
}
