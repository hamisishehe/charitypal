import 'package:cloud_firestore/cloud_firestore.dart';

class eventmodel{

  String event_id;
  String title;
  String location;
  String description;
  String image;
  String status;
  String orgname;
  Timestamp createdAt;
  Timestamp event_date;
  int view;



  eventmodel({
    required this.event_id,
    required this.title,
    required this.location,
    required this.description,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.orgname,
    required this.view,
    required this.event_date

  });
}