import 'package:flutfirebase/app/ui/utils/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/auth_controller.dart';

class AuthPage extends GetView<AuthController> {
  void _pushPage(String page) {
    Get.toNamed(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Signin or login'),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              child: IconButton(
                icon: Icon(Icons.person_add),
                color: Colors.indigo,
                // text: 'Registration',
                onPressed: () => _pushPage(AppRoutes.TODO),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              child: IconButton(
                  icon: Icon(Icons.verified_user),
                  color: Colors.orange,
                  // label: 'Sign In',
                  onPressed: () => _pushPage(AppRoutes.HOME)),
            ),
          ],
        ));
  }
}
