import 'package:flutfirebase/app/data/models/todo_model.dart';

import 'todo_repository_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoRepository implements IFirestoreTodoRepository {
  final FirebaseFirestore firestore_db;

  TodoRepository({required this.firestore_db});

  final todosRef = FirebaseFirestore.instance
      .collection('todo')
      .withConverter<TodoModel>(
          fromFirestore: (snapshot, _) => TodoModel.fromDocumets(snapshot),
          toFirestore: (todo, _) => todo.toJson());
  @override
  Stream<QuerySnapshot<TodoModel>> getTodos() {
    return todosRef.snapshots();
  }
}
