import 'package:flutfirebase/app/ui/utils/shared.dart';

class AppWidget {
  static Future<dynamic> create_new_todo(BuildContext context, Size size) {
    final controller = Get.find<TodoController>();
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => SimpleDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        backgroundColor: Colors.grey[800],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        titlePadding: EdgeInsets.all(8),
        title: Container(
          padding: EdgeInsets.only(left: 5),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Text(
                'Nova Nota',
                style: TextStyle(
                  color: Colors.white54,
                ),
              ),
              Spacer(),
              IconButton(
                  icon:
                      Icon(Icons.cancel, color: Theme.of(context).primaryColor),
                  onPressed: () {
                    Get.back();
                  }),
            ],
          ),
        ),
        children: [
          // Divider(),
          TextField(
            controller: controller.title_edit.value,
            autofocus: true,
            maxLines: 5,
            autofillHints: ['saidino', 'hacker', 'claudia', 'Mariamo'],
            style: TextStyle(color: Colors.white, height: 1.5, fontSize: 18),
            decoration: InputDecoration(
              hintText: 'ex: Programar django ',
              hintStyle: TextStyle(
                color: Colors.white30,
              ),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 30,
            width: size.width,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Salvar',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onPressed: () {
                controller.saveTodo();
              },
            ),
          ),
        ],
      ),
    );
  }
}
