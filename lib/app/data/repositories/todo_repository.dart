import 'package:firebase_core/firebase_core.dart';
import 'package:flutfirebase/app/data/models/todo_model.dart';

import 'todo_repository_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoRepository implements IFirestoreTodoRepository {
  final CollectionReference todosCollection =
      FirebaseFirestore.instance.collection('todo');

  final CollectionReference todoReference =
      FirebaseFirestore.instance.collection('todo');

  // final todosRef = FirebaseFirestore.instance
  //     .collection('todo')
  //     .withConverter<TodoModel>(
  //         fromFirestore: (snapshot, _) => TodoModel.fromDocumets(snapshot),
  //         toFirestore: (todo, _) => todo.toJson());

  List<TodoModel> todoFromFirestore(QuerySnapshot snapshot) {
    if (snapshot != null) {
      return snapshot.docs.map((element) {
        print("##################### THIS IS AN ID =>${element.id}");
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;
        return TodoModel.fromJson(data).copyWith(id: element.id);
      }).toList();
    } else {
      return <TodoModel>[];
    }
  }

  @override
  Stream<List<TodoModel>> getTodos() {
    return todosCollection.snapshots().map(todoFromFirestore);
  }

  /***
   * TODO  OUTROS IMPLEMENTAM:
   * final Firestore firestore=Firestore.instance;
   * Stream<List<TodoModel> getTodos(){
   * 
   *  return firestore.collection('todo').snapshots().map( (query){
   *    return query.documents.map( (doc){return TodoModel.fromJson(doc);})
   * 
   * })
   * }
   */

  Future create_new_todo(String title) async {
    /** Cria um novo Todo*/
    return await todosCollection.add({'title': title, 'checked': false});
  }

  Future<void> remove_todo_by_id(TodoModel todo) async {
    await todosCollection.doc(todo.id).delete().then((value) {
      print('deletado um item');
    }).catchError((error) {
      throw Exception(" Erro ao apager Item ${error}");
    });
  }

  Future complete__task(TodoModel todo) async {
    /** Actualiza um novo Todo ao fazer checked */
    // TodoModel model = TodoModel.copyWith(id:);
    bool chec = !todo.checked!;
    return await todosCollection
        .doc(todo.id)
        .update({'checked': chec, 'title': todo.title});
  }
}
