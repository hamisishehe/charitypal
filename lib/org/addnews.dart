import 'dart:io';
import 'package:flutter_quill/flutter_quill.dart' as flutter_quill;
import 'package:charitypal/model/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:text_area/text_area.dart';

class AddNews extends StatefulWidget {
  const AddNews({super.key});

  @override
  State<AddNews> createState() => _AddNewsState();
}

class _AddNewsState extends State<AddNews> {

  String name ="";



  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController org = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  bool isvisible =true;

  bool isloading = false;

  var fullname ;


  File? _image;
  Future getorgname () async{
    try {
      QuerySnapshot orgname = await FirebaseFirestore.instance.collection(
          "users").where(
          "user_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();

      for (var doc in orgname.docs) {
        setState(() {
          org.text = doc["fullname"];
        });
      }

    }
    catch(e){
      print(e);
    }

  }
  @override
  void initState() {
    // TODO: implement initState

    getorgname();
    super.initState();
  }


  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }



  addpost() async {
    if (_image == null) {
      return;
    }


    var news_id = DateTime.now().microsecondsSinceEpoch.toString();

    final storage = FirebaseStorage.instance;
    final imageName = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = storage.ref().child('images/$imageName.jpg');
    await ref.putFile(_image!);
    final uploadTask = ref.putFile(_image!);
    final snapshot = await uploadTask.whenComplete(() {});

    final imageUrl = await snapshot.ref.getDownloadURL();


    try{
      await FirebaseFirestore.instance.collection("news").doc(news_id).set({
        "createdAt": FieldValue.serverTimestamp(),
        "news_id":news_id,
        "title":title.text.trim(),
        "image":imageUrl,
        "description":description.text.trim(),
        "status":"pending",
        "likecount": 0,
        "likes":{},
        "view":0,
        "comment":[],
        "organization_name": org.text,
        "organization_id": FirebaseAuth.instance.currentUser!.uid
      });

      QuickAlert.show(
        context: context,
        backgroundColor: Color(0xff2B4E74),
        type: QuickAlertType.success,
        title: 'Done...',
        textColor: Colors.white,
        onCancelBtnTap: (){
          Get.back();
        },
        confirmBtnColor: Colors.white,
        confirmBtnTextStyle: TextStyle(
            color: Colors.black
        ),
        text: 'News Added',
      );

      setState(() {
        title.clear();
        description.clear();
        isloading = false;
        _image = null;

      });



    }
    catch (e){
      print(e);
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    }, icon: Icon(Icons.close, color: Colors.black,))
                  ],
                ),
              ),
            ),


            SizedBox(height: 30,),

            Padding(padding: EdgeInsets.all(15),
              child: Text("Add News", style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              ),),),

            Container(
              margin: EdgeInsets.all(10),
              child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                      TextFormField(
                        controller: title,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Title";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            color: Colors.black
                        ),

                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            label: Text("Title"),
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),
                            prefixIcon: Icon(Icons.title, color: Colors.green,),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors
                                    .green, width: 1)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors
                                    .green, width: 1)
                            )
                        ),

                      ),
                      const SizedBox(
                        height: 20,
                      ),



                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Description", style: TextStyle(
                            fontSize: 20
                        ),),
                      ),

                      GestureDetector(
                        child: TextArea(
                          borderRadius: 10,
                          borderColor: Colors.black,
                          textEditingController: description,
                          suffixIcon: Icons.attach_file_rounded,
                          onSuffixIconPressed: () => {},
                          validation: false,
                          errorText: 'Please type a reason!',
                        ),
                      ),


                      const SizedBox(
                        height: 20,
                      ),


                      Container(
                          margin: EdgeInsets.all(3),
                          child:  GestureDetector(


                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 100,
                              color: Colors.black,
                              child:   _image != null
                                  ? Image.file(
                                _image!, fit: BoxFit.cover,
                              )
                                  :Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.image_rounded, size: 40, color: Colors.green,),
                                  Text("Add Image", style: TextStyle(
                                      color: Colors.white
                                  ),)

                                ],
                              ),
                            ),

                            onTap: (){
                              print("hellow");
                              _pickImage(ImageSource.gallery);
                            },
                          )

                      ),

                      const SizedBox(
                        height: 20,
                      ),



                      Container(
                        height: 55,
                        width: 400,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 15,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              backgroundColor: Colors.green.withOpacity(0.9),),
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                setState(() {
                                  isloading = true;
                                });

                                addpost();
                              } else {
                                setState(() {
                                  isloading = false;
                                });
                              }
                            },
                            child: isloading? CircularProgressIndicator
                              (color: Colors.white,) : Text("Add News", style:
                            TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.black
                            ),)),
                      ),

                    ],
                  )),
            )



          ],
        ),
      )),
    );
  }
}
