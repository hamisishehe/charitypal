import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {

  String user_id;
  String transaction_id;
  String event_id;
  int amount;
  Timestamp createdAt;

  TransactionModel({
    required this.user_id,
    required this.amount,
    required this.transaction_id,
    required this.event_id,
    required this.createdAt,
});


}