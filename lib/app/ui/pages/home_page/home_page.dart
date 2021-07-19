import 'package:flutfirebase/app/routes/routes.dart';
import 'package:flutfirebase/app/ui/utils/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: controller.titleEditctl,
        ),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(AppRoutes.TODO),
            icon: Icon(Icons.file_present),
          ),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder(
            // stream: FirebaseFirestore.instance.collection('todo').snapshots(),
            // como ja criei refencia d todo no homeController entao posso usalo
            stream: controller.todoReference.orderBy('title').snapshots(),
            builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator.adaptive());
              return ListView(
                children: snapshot.data!.docs.map((todo) {
                  return Dismissible(
                    background: Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(color: primaryColor),
                      child: Icon(
                        Icons.delete,
                        color: Colors.grey[800],
                      ),
                    ),
                    key: Key("${todo['title']}"),
                    onDismissed: (direction) {
                      controller.todoReference.doc(todo.id).delete();
                      Get.snackbar('Delecao', 'Deletado com sucesso',
                          backgroundColor: Colors.white);
                    },
                    child: ListTile(
                      title: Text(
                        "${todo['title']} + ${todo['checked']}",
                        style: TextStyle(color: Colors.white30),
                      ),
                      leading: Checkbox(
                        value:
                            todo['checked'].toString().trim().toLowerCase() ==
                                    'true'
                                ? true
                                : false,
                        // == 'false'? true : false,
                        //parse(todo['checked']),
                        onChanged: (v) {
                          bool todo_checked =
                              todo['checked'].toString().trim().toLowerCase() ==
                                      'true'
                                  ? true
                                  : false;
                          controller.todoReference
                              .doc(todo.id)
                              .update({'checked': !todo_checked})
                              .then(
                                (value) => Get.snackbar(
                                  'Updating',
                                  'check updated sucessfull',
                                  backgroundColor: Colors.blueAccent,
                                ),
                              )
                              .catchError((error) {
                                Get.snackbar('Update',
                                    'Erro ao fazer update por favor verifique o database',
                                    backgroundColor: primaryColor);
                              });
                        },
                      ),
                      onLongPress: () {
                        // Apage ao precionar com alta preesao
                      },
                    ),
                  );
                }).toList(),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (controller.titleEditctl.text.isNotEmpty) {
            controller.todoReference.add({
              'title': controller.titleEditctl.text,
              'checked': false,
            });
          }
          controller.titleEditctl.clear();
        },
        child: Text('Add'),
      ),
    );
  }
}
