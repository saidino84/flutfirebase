import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? id;
  String? title;
  bool? checked;

  TodoModel({this.id, this.title, this.checked});

  TodoModel.fromJson(Map<String, dynamic> firestore_docus)
      : this(
          checked: firestore_docus['checked'] as bool?,
          title: firestore_docus['title'] as String?,
        );

  Map<String, dynamic> toJson() => {
        'title': title,
        'checked': checked,
      };

  TodoModel copyWith({
    String? id,
    String? title,
    bool? checked,
  }) {
    return TodoModel(
      checked: checked ?? this.checked,
      title: title ?? this.title,
      id: id ?? this.id,
    );
  }
}
