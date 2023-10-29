import 'package:charitypal/model/eventmodel.dart';
import 'package:charitypal/model/org.dart';
import 'package:charitypal/model/transaction.dart';
import 'package:charitypal/model/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AlluserFetch extends GetxController{

    Stream<List<UserModel>> fetchuser(String userid){
      return FirebaseFirestore.instance.collection("users").where("user_id", isEqualTo: userid).snapshots().map((snapshot) {

        return snapshot.docs.map((doc) => UserModel(
            fullname: doc['fullname'],
            email: doc['email']
        )
        ).toList();

      });


    }


    Stream<List<TransactionModel>> fetchpayment(String userid){
      return FirebaseFirestore.instance.collection("transaction").where("user_id", isEqualTo: userid).snapshots().map((snapshot) {

        return snapshot.docs.map((doc) => TransactionModel(
            user_id: doc['user_id'],
            amount: doc['amount'],
            transaction_id: doc['transaction_id'],
            event_id: doc['event_id'],
            createdAt: doc['createdAt'])
        ).toList();

      });


    }


    Stream<List<UserModel>> fetchallorg(){
      return FirebaseFirestore.instance.collection("users").where("role", isEqualTo: "org").snapshots().map((snapshot) {

        return snapshot.docs.map((doc) => UserModel(
            fullname: doc['fullname'],
            email: doc['email']
        )
        ).toList();

      });


    }




    Stream<List<OrgModel>> fetchorgdetails(String org_name){
      return FirebaseFirestore.instance.collection("organization").where("orgname", isEqualTo: org_name).snapshots().map((snapshot) {

        return snapshot.docs.map((doc) => OrgModel(
            orgname: doc['orgname'],
            description: doc['description'],
            email: doc['email'],
            phonenumber: doc['phonenumber'],
            website: doc['website'])
        ).toList();

      });


    }


    Stream<List<eventmodel>>? umenisumbua (String event_id) {

      try {
        return FirebaseFirestore.instance.collection("events").where("event_id", isEqualTo: event_id).snapshots()
            .map((snapshot) {
          return snapshot.docs.map((doc) =>
              eventmodel(
                  event_id: doc['event_id'],
                  title: doc['title'],
                  location: doc['location'],
                  event_date: doc['event_date'],
                  description: doc['description'],
                  image: doc['image'],
                  status: doc['status'],
                  view: doc['view'] ?? [],
                  createdAt: doc['createdAt'], orgname: doc['orgname'])).toList();
        });
      }
      catch (e) {
        print("Error fetching events: $e");
        return null; // Handle the error appropriately in your app
      }

    }






    Stream<List<eventmodel>>? fetchorgevents (String orgname) {

      try {
        return FirebaseFirestore.instance.collection("events").where("orgname", isEqualTo: orgname).snapshots()
            .map((snapshot) {
          return snapshot.docs.map((doc) =>
              eventmodel(
                  event_id: doc['event_id'],
                  title: doc['title'],
                  location: doc['location'],
                  event_date: doc['event_date'],
                  description: doc['description'],
                  image: doc['image'],
                  status: doc['status'],
                  view: doc['view'] ?? [],
                  createdAt: doc['createdAt'],
                  orgname: doc['orgname'])).toList();
        });
      }
      catch (e) {
        print("Error fetching events: $e");
        return null; // Handle the error appropriately in your app
      }

    }


}