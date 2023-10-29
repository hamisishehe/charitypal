import 'package:charitypal/admin/vieworganization.dart';
import 'package:charitypal/model/organization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class Singleorganization extends StatefulWidget {
  final organization single;
  const Singleorganization({super.key, required this.single});

  @override
  State<Singleorganization> createState() => _SingleorganizationState();
}

class _SingleorganizationState extends State<Singleorganization> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  var color = "0AF886";
  bool isloading = false;
  bool ishiden = true;



  createaccount() async{

     var orguser ;
    try{
     UserCredential userCredential =await  FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text.trim(),
          password: password.text.trim(),

      );
     try {
       FirebaseFirestore.instance.collection("users").doc(userCredential.user!.uid).set(
           {
             'user_id':userCredential.user!.uid,
             'fullname': widget.single.orgname,
             'email': email.text.trim(),
             'createdAt': FieldValue.serverTimestamp(),
             'role':"org"
           }
       );

       FirebaseFirestore.instance.collection("organization").doc(widget.single.orgid).update(
           {
             'status':"Approved",
           }
       );

       QuickAlert.show(
         context: context,
         backgroundColor: Color(0xff2B4E74),
         type: QuickAlertType.success,
         title: 'Done...',
         textColor: Colors.white,
         onCancelBtnTap: (){
           Navigator.push(context, MaterialPageRoute(builder: (context) => Vieworganization(),));
         },
         confirmBtnColor: Colors.white,
         confirmBtnTextStyle: TextStyle(
             color: Colors.black
         ),
         text: 'Event Submitted',
       );

       setState(() {
         email.clear();
         password.clear();
         isloading = false;


       });


     }
     catch(e){
       print(e.toString());


     }

     return userCredential;



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
      backgroundColor: Color(0xff323232),

      body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
        children: [

            Container(
              margin: EdgeInsets.only(left: 8,top: 20,right: 8),
              height: 50,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      child: Image.asset("images/back.png", color: Color(0xff0AF886).withOpacity(0.5), width: 30,height: 30,),
                    ),

                  ),
                  Spacer(),

                  Text(widget.single.orgname, style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),),
                  Spacer()

                ],
              ),
            ),
            SizedBox(height: 10,),

            Container(
              margin: EdgeInsets.only(top: 70,right: 10,left: 10),
              height: 150,
              color: Colors.white,
              child: ListView(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.group),
                    ),
                     title: Text(widget.single.orgname),
                  ),
                   Container(
                     padding: EdgeInsets.only(left: 20),
                     child: Column(
                       children: [
                         Row(
                           children: [
                             Text("Phone Number:", style: TextStyle(
                               fontWeight: FontWeight.bold,
                               fontSize: 15
                             ),),
                             SizedBox(width: 5,),
                             Text("+255 "+ widget.single.phonenumber,
                               style: TextStyle(
                                 fontSize: 15,
                                 fontWeight: FontWeight.w300
                             ),),
                           ],
                         ),
                         SizedBox(height: 5,),

                         Row(
                           children: [
                             Text("Email:", style: TextStyle(
                                 fontWeight: FontWeight.bold,
                                 fontSize: 15
                             ),),
                             SizedBox(width: 5,),
                             Text(widget.single.email,
                               style: TextStyle(
                                   fontSize: 15,
                                   fontWeight: FontWeight.w300
                               ),),
                           ],
                         ),
                         SizedBox(height: 5,),

                         Row(
                           children: [
                             Text("Description:", style: TextStyle(
                                 fontWeight: FontWeight.bold,
                                 fontSize: 15
                             ),),
                             SizedBox(width: 5,),
                             Text(widget.single.description,
                               style: TextStyle(
                                   fontSize: 15,
                                   fontWeight: FontWeight.w300
                               ),),
                           ],
                         ),

                         SizedBox(height: 10,),

                         Row(
                           children: [
                             Text("Registration Status:", style: TextStyle(
                                 fontWeight: FontWeight.bold,
                                 fontSize: 15
                             ),),
                             SizedBox(width: 5,),
                             Text(widget.single.status,
                               style: TextStyle(
                                   fontSize: 15,
                                   color: widget.single.status == "approved" ? Colors.red : Colors.green,
                                   fontWeight: FontWeight.bold
                               ),),
                           ],
                         ),
                       ],
                     ),
                   ),


                  
                ],
              ),

            ),





          Container(
            margin: EdgeInsets.only(top: 250, left: 10, right: 10),
            height: 400,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: widget.single.status =="Approved" ? Text("") :Text("Create Organization Account",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),),
                ),

                widget.single.status =="Approved" ? Container() : Container(
                  margin: EdgeInsets.all(10),
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
                            style: TextStyle(
                                color: Colors.white
                            ),

                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xff0AF886).withOpacity(0.2),
                                label: Text("Email"),
                                labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),
                                prefixIcon: Icon(Icons.email, color: Colors.white,),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Color(0xff0AF886).withOpacity(0.2))
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Color(0xff0AF886).withOpacity(0.2))
                                )
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
                                color: Colors.white
                            ),

                            cursorColor: Colors.white,
                            obscureText: ishiden,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xff0AF886).withOpacity(0.2),
                                label: Text("Password"),
                                labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),
                                prefixIcon: Icon(Icons.password, color: Colors.white,),
                                suffixIcon: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      ishiden =!ishiden;
                                    });
                                  },
                                  child: ishiden? Icon(Icons.visibility_off, color: Colors.white,) : Icon(Icons.visibility, color: Colors.white,),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Color(0xff0AF886).withOpacity(0.2))
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(color: Color(0xff0AF886).withOpacity(0.2))
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

                                    createaccount();
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
                                    backgroundColor: Color(0xff0AF886).withOpacity(0.5)
                                ),
                                child: isloading?  Center(child: CircularProgressIndicator(color: Colors.white,),) :Text("Create Account", style: TextStyle(
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
          )







        ],
      ),
          )),
    );
  }
}
