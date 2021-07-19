import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutfirebase/app/data/models/todo_model.dart';

abstract class IFirestoreTodoRepository {
  /** Interface que tera todos os metods para se comunicar com o banco reactivo do firebase [Cloud_firestore]

  **/
  // como ele 'e um banco de daos reactivo usarei streams na hora  de pegas os dados
  Stream<QuerySnapshot<TodoModel>> getTodos();
}
