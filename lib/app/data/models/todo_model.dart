import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? uid;
  String title;
  bool checked;
  final DocumentReference? reference; //areferencia

  TodoModel(
      {this.reference, this.uid, required this.title, required this.checked});

  factory TodoModel.fromDocumets(
      DocumentSnapshot<Map<String, dynamic>> firestore_docus) {
    // este firestore_docus aparecera em formato json
    // dai que eu acessarei com map
    return new TodoModel(
        checked: firestore_docus['checked'],
        title: firestore_docus['title'],
        reference: firestore_docus['reference']!);
  }

  Map<String, dynamic> toJson() =>
      {'title': title, 'reference': reference!, 'checked': checked};
}
