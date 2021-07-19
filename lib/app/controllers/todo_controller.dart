import 'package:flutfirebase/app/data/repositories/todo_repository.dart';
import 'package:flutfirebase/app/ui/utils/shared.dart';
import 'package:get/get.dart';

class TodoController extends GetxController {
  final title_edit = TextEditingController().obs;
  TodoRepository repository = TodoRepository();
  void saveTodo() {
    if (title_edit.value.text.isNotEmpty) {
      Get.snackbar(
        'Edited',
        '${title_edit.value.text}',
        backgroundColor: Colors.grey[800],
      );
    }
  }

  Future<void> showData() async {
    var data = repository.getTodos();
  }
}
