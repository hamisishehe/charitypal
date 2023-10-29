import 'package:cloud_firestore/cloud_firestore.dart';

class TransNotModel {

  String user_id;
  String transactionid;
  Timestamp createdAt;
  int amount;

  TransNotModel({
    required this.createdAt,
    required this.transactionid,
    required this.user_id,
    required this.amount
  });


}