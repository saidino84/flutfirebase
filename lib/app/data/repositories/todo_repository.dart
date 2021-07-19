import 'package:firebase_core/firebase_core.dart';
import 'package:flutfirebase/app/data/models/todo_model.dart';

import 'todo_repository_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoRepository implements IFirestoreTodoRepository {
  final CollectionReference todosCollection =
      FirebaseFirestore.instance.collection('todo');

  // final todosRef = FirebaseFirestore.instance
  //     .collection('todo')
  //     .withConverter<TodoModel>(
  //         fromFirestore: (snapshot, _) => TodoModel.fromDocumets(snapshot),
  //         toFirestore: (todo, _) => todo.toJson());

  List<TodoModel> todoFromFirestore(QuerySnapshot snapshot) {
    if (snapshot != null) {
      return snapshot.docs.map((element) {
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;
        return TodoModel(
          title: data['title'],
          checked: data['checked'] as bool,
          uid: element.id,
        );
      }).toList();
    } else {
      return <TodoModel>[];
    }
  }

  @override
  Stream<List<TodoModel>> getTodos() {
    return todosCollection.snapshots().map(todoFromFirestore);
  }

  Future create_new_todo(String title) async {
    /** Cria um novo Todo*/
    return await todosCollection.add({'title': title, 'checked': false});
  }

  Future complete__task(uid) async {
    /** Actualiza um novo Todo ao fazer checked */
    return await todosCollection.doc(uid).update({'checked': true});
  }
}
