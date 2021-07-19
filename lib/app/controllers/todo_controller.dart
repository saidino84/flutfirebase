import 'package:flutfirebase/app/ui/utils/shared.dart';
import 'package:get/get.dart';

class TodoController extends GetxController {
  final title_edit = TextEditingController().obs;

  void saveTodo() {
    if (title_edit.value.text.isNotEmpty) {
      Get.snackbar(
        'Edited',
        '${title_edit.value.text}',
        backgroundColor: Colors.grey[800],
      );
    }
  }
}
