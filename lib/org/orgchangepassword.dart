import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class Orgchangepassword extends StatefulWidget {
  const Orgchangepassword({super.key});

  @override
  State<Orgchangepassword> createState() => _OrgchangepasswordState();
}

class _OrgchangepasswordState extends State<Orgchangepassword> {
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool isloading = false;
  bool ishiden = true;


  forgot() async {
    try{
      await FirebaseAuth.instance.currentUser?.updatePassword(password.text.trim());

      QuickAlert.show(
        onCancelBtnTap: () {
          Navigator.pop(context);
        },
        context: context,
        type: QuickAlertType.success,
        text: 'Done',
        confirmBtnText: 'Password Changed',
        confirmBtnColor: Colors.white,
        backgroundColor:Colors.white,
        confirmBtnTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        barrierColor: Colors.white,
        titleColor: Colors.black,
        textColor: Colors.black,

      );

      setState(() {

        password.clear();
      });

    }
    catch(e){
      if(e is FirebaseException){
        QuickAlert.show(
          confirmBtnColor: Colors.black,
          context: context,
          type: QuickAlertType.error,
          text: e.toString(),
          backgroundColor: Colors.white.withOpacity(0.2),
          titleColor: Colors.white,
          textColor: Colors.white,
        );
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

      body: SafeArea(child: Stack(
        children: [

          Container(
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

          Container(
            margin: EdgeInsets.only(left: 15,top: 90,right: 8),
            child: Text("Change password", style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25,
                overflow: TextOverflow.ellipsis
            ),),
          ),

          Container(
            margin: EdgeInsets.only(left: 15,top: 150,right: 8),
            child:   Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  height: 200,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child:   Form(
                      key: formkey,
                      child: Column(
                        children: [

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
                                fillColor: Colors.green.withOpacity(0.8),
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
                                child: Text("Change Password", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 25
                                ),)),
                          ),


                        ],
                      )),

                )




              ],
            ),
          ),



        ],
      )),
    );
  }
}
