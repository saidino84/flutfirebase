import 'package:flutfirebase/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(AppRoutes.TODO),
            icon: Icon(Icons.file_present),
          ),
        ],
      ),
      body: SafeArea(
        child: Text('HomeController'),
      ),
    );
  }
}
