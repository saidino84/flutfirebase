import 'package:flutfirebase/app/data/models/todo_model.dart';
import 'package:flutfirebase/app/data/repositories/todo_repository.dart';
import 'package:flutfirebase/app/ui/utils/shared.dart';
import 'package:get/get.dart';

class TodoController extends GetxController with StateMixin {
  final title_edit = TextEditingController().obs;
  TodoRepository todo_repository = TodoRepository();
  void saveTodo() {
    if (title_edit.value.text.isNotEmpty) {
      todo_repository.create_new_todo(title_edit.value.text).then((value) {
        Get.snackbar(
          'Saved Sucess full',
          '${title_edit.value.text}',
          backgroundColor: Colors.blueAccent,
        );
      }).catchError((err) {
        Get.snackbar(
          'Save Fail',
          'Erro ao salvar os seus dados devido :${err.toString()}',
          backgroundColor: Colors.red,
        );
      });
    }
    title_edit.value.clear();
  }

  Stream<List<TodoModel>> showData() {
    return todo_repository.getTodos();
  }

  void todo_done(TodoModel todo) {
    todo_repository.complete__task(todo);
  }

  void delete_todo(TodoModel model) async {
    todo_repository.remove_todo_by_id(model).then((value) {
      Get.snackbar('Delete', "Delete was purshace sucessfully !",
          backgroundColor: Colors.blueAccent);
    }).catchError((err) {
      Get.snackbar("Delete", "Fail to Delete that todo err: ${err}",
          backgroundColor: Colors.redAccent);
    });
  }
}
