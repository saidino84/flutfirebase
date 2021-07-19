import 'package:flutfirebase/app/routes/routes.dart';
import 'package:flutfirebase/app/ui/utils/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
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
              return ListView(
                children: snapshot.data!.docs.map((todo) {
                  return Center(
                    child: ListTile(
                      title: Text(todo['title']),
                    ),
                  );
                }).toList(),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (controller.titleEditctl.text != null) {
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
