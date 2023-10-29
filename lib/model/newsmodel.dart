import 'package:cloud_firestore/cloud_firestore.dart';

class NewsModel{

  String news_id;
  String title;
  String description;
  String image;
  Timestamp createdAt;
  int view;
  Map  likes;
  final List<String> comment;
  int likecount;
  String organization_name;
  String organization_id;
  String status;



  NewsModel({
    required this.news_id,
    required this.title,
    required this.description,
    required this.image,
    required this.createdAt,
    required this.view,
    required this.comment,
    required this.likes,
    required this.likecount,
    required this.organization_name,
    required this.organization_id,
    required this.status
  });
}