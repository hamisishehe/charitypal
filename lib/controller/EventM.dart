import 'package:charitypal/model/Eventwithtrans.dart';
import 'package:charitypal/model/commen.dart';
import 'package:charitypal/model/eventmodel.dart';
import 'package:charitypal/model/favorite.dart';
import 'package:charitypal/model/newsmodel.dart';
import 'package:charitypal/model/organization.dart';
import 'package:charitypal/model/transaction.dart';
import 'package:charitypal/model/transnot.dart';
import 'package:charitypal/model/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/state_manager.dart';

class EventController extends GetxController{

  Stream<List<eventmodel>>? getevent (String userid) {

    final data = userid;

    try {
      return FirebaseFirestore.instance.collection("events").where("organization_id ", isEqualTo: data).snapshots().map((snapshot) {
        return snapshot.docs.map((doc) =>
            eventmodel(
                event_id: doc['event_id'],
                title: doc['title'],
                location: doc['location'],
                description: doc['description'],
                image: doc['image'],
                createdAt: doc['createdAt'],
                orgname: doc['orgname'],
                status: doc['status'],
                view: doc['view'],
                event_date: doc['event_date'])).toList();
      });
    }
    catch (e) {
      print("Error fetching events: $e");
      return null; // Handle the error appropriately in your app
    }

  }

  Stream<List<eventmodel>>? alleventsort () {


    try {
      return FirebaseFirestore.instance.collection("events").orderBy("createdAt", descending: true).snapshots().map((snapshot) {
        return snapshot.docs.map((doc) =>
            eventmodel(
                event_id: doc['event_id'],
                title: doc['title'],
                orgname: doc['orgname'],
                location: doc['location'],
                event_date: doc['event_date'],
                description: doc['description'],
                image: doc['image'],
                status: doc['status'],
                view: doc['view'] ?? [],
                createdAt: doc['createdAt'])).toList();
      });
    }
    catch (e) {
      print("Error fetching events: $e");
      return null; // Handle the error appropriately in your app
    }

  }



  Stream<List<eventmodel>>? allevent () {


    try {
      return FirebaseFirestore.instance.collection("events").orderBy("createdAt", descending: true).snapshots().map((snapshot) {
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
                orgname: doc['orgname'],
                createdAt: doc['createdAt'])).toList();
      });
    }
    catch (e) {
      print("Error fetching events: $e");
      return null; // Handle the error appropriately in your app
    }

  }


  Stream<List<UserModel>>? allusers () {
    try {
      return FirebaseFirestore.instance.collection("users").orderBy("createdAt", descending: true).snapshots().map((snapshot) {
        return snapshot.docs.map((doc) =>
            UserModel(
                fullname: doc['fullname'],
                email: doc['email'])).toList();
      });
    }
    catch (e) {
      print("Error fetching events: $e");
      return null; // Handle the error appropriately in your app
    }

  }


  Stream<List<organization>>? allrequest () {
    try {
      return FirebaseFirestore.instance.collection("organization").orderBy("createdAt", descending: true).snapshots().map((snapshot) {
        return snapshot.docs.map((doc) =>
            organization(
                email: doc['email'],
                phonenumber: doc['phonenumber'],
                orgname: doc['orgname'],
                website: doc['website'],
                description: doc['description'],
                status: doc['status'],
                orgid: doc['organization_id'])).toList();
      });
    }
    catch (e) {
      print("Error fetching events: $e");
      return null; // Handle the error appropriately in your app
    }

  }







  Future<Stream<List<eventmodel>>?> fetchfavorite (String userid) async {

    final data = userid;

    final snapshot = await FirebaseFirestore.instance.collection("favorite").where('userId', isEqualTo: data).get();

    if(snapshot.docs.isNotEmpty){
      try {
        return FirebaseFirestore.instance.collection("events").where("organization_id ", isEqualTo: data).snapshots().map((snapshot) {
          return snapshot.docs.map((doc) =>
              eventmodel(
                  event_id: doc['event_id'],
                  view: doc['view'] ?? [],
                  title: doc['title'],
                  location: doc['location'],
                  event_date: doc['event_date'],
                  description: doc['description'],
                  image: doc['image'],
                  createdAt: doc['createdAt'],
                  orgname: doc['orgname'],
                  status: doc['status'])).toList();
        });
      }
      catch (e) {
        print("Error fetching events: $e");
        return null; // Handle the error appropriately in your app
      }

    }



  }


  Stream<List<eventmodel>>? demofetch (String event_id, String uid) {


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
                orgname: doc['orgname'],
                status: doc['status'],
                view: doc['view'] ?? [],
                createdAt: doc['createdAt'])).toList();
      });
    }
    catch (e) {
      print("Error fetching events: $e");
      return null; // Handle the error appropriately in your app
    }

  }



  Stream<List<FavoriteModel>> fetchfavori (String user_id){
    return FirebaseFirestore.instance.collection("favorite").where("userId",
        isEqualTo: user_id).snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => FavoriteModel(
          event_id: doc['event_id'],
          user_id: doc['userId'])).toList();
    });
  }


  Stream<List<TransNotModel>> fetchnot (String user_id){
    return FirebaseFirestore.instance.collection("transaction").where("user_id",
        isEqualTo: user_id).snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => TransNotModel(
          createdAt: doc['createdAt'],
          transactionid: doc['transaction_id'],
          user_id: doc['user_id'],
          amount: doc['amount'])).toList();

    });
  }



  Stream<List<NewsModel>> fetchnews (String user_id){
    return FirebaseFirestore.instance.collection("news").where
      ("organization_id",
        isEqualTo: user_id).snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) =>
          NewsModel(
            createdAt: doc['createdAt'],
            description: doc['description'],
            image: doc['image'],
            likecount: doc['likecount'],
            likes: doc['likes'],
            news_id: doc['news_id'],
            organization_id: doc['organization_id'],
            organization_name: doc['organization_name'],
            status: doc['status'],
            title: doc['title'],
            comment: List<String>.from(doc['comment']),
            view: doc['view'],



            )).toList();

    });
  }


  Stream<List<NewsModel>>? fetchallnews (){
    try {
      return FirebaseFirestore.instance.collection("news").orderBy("createdAt",descending: true).snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) =>
            NewsModel(
                news_id: doc['news_id'],
                title: doc['title'],
                description: doc['description'],
                image: doc['image'],
                createdAt: doc['createdAt'],
                comment: List<String>.from(doc['comment']),
                view: doc['view'],
                likes: doc['likes'],
                likecount: doc['likecount'],
                status: doc['status'],
                 organization_id: doc['organization_id'],
                organization_name: doc['organization_name'],)).toList();
      });
    }
    catch(e){
      print(e.toString());
    }
  }


  Stream<List<TransactionModel>> topevents (String user_id){
    return FirebaseFirestore.instance.collection("transaction").where("user_id", isEqualTo: user_id).snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => TransactionModel(
          createdAt: doc['createdAt'],
          user_id: doc['user_id'],
          amount: doc['amount'],
          transaction_id: doc['transaction_id'],
          event_id: doc['event_id'])).toList();

    });
  }

  Stream<List<CommentModel>> comment (String news_id){
    return FirebaseFirestore.instance.collection("news").doc(news_id).collection("comment").orderBy('createdAt', descending: true).snapshots().map((snapshot) {

      return snapshot.docs.map((doc) => CommentModel(
          fullname: doc['fullname'],
          comment: doc['comment'],
         ) ).toList();
    });
  }


  Stream<List<eventmodel>>? alltopevents () {


    try {
      return FirebaseFirestore.instance.collection("events").orderBy("view", descending: true).snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) =>
            eventmodel(
                event_id: doc['event_id'],
                title: doc['title'],
                location: doc['location'],
                event_date: doc['event_date'],
                orgname: doc['orgname'],
                description: doc['description'],
                image: doc['image'],
                status: doc['status'],
                view: doc['view'] ?? [],
                createdAt: doc['createdAt'])).toList();
      });
    }
    catch (e) {
      print("Error fetching events: $e");
      return null; // Handle the error appropriately in your app
    }

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


  Stream<List<TransactionModel>> topeventsamount (String event_id, user_id){
    return FirebaseFirestore.instance.collection("transaction").where("event_id", isEqualTo: event_id).where("user_id", isEqualTo: user_id).orderBy("createdAt", descending: true).snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => TransactionModel(
          createdAt: doc['createdAt'],
          user_id: doc['user_id'],
          amount: doc['amount'],
          transaction_id: doc['transaction_id'],
          event_id: doc['event_id'])).toList();

    });
  }


  Stream<List<TransactionModel>> totalorgamount (user_id){
    return FirebaseFirestore.instance.collection("transaction").where("user_id", isEqualTo: user_id).snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => TransactionModel(
          createdAt: doc['createdAt'],
          user_id: doc['user_id'],
          amount: doc['amount'],
          transaction_id: doc['transaction_id'],
          event_id: doc['event_id'])).toList();

    });
  }


}