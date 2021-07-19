import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? uid;
  String title;
  bool checked;
  // final DocumentReference? reference; //areferencia

  TodoModel({this.uid, required this.title, required this.checked});

  TodoModel.fromJson(Map<String, dynamic> firestore_docus)
      : this(
          checked: firestore_docus['checked'],
          title: firestore_docus['title'],
        );

  Map<String, dynamic> toJson() => {'title': title, 'checked': checked};
}
