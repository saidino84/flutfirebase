import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutfirebase/app/routes/routes.dart';
import 'package:flutfirebase/app/ui/pages/home_page/components/componets.dart';
import 'package:flutfirebase/app/ui/utils/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/home_controller.dart';
import 'components/home_top_custom_painter.dart';

class HomePage extends GetView<HomeController> with Components {
  var app_controller = Get.find<AppController>();
  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder(
        stream: app_controller.user_auth,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Houve erro ao carregar os dados'));
          } else {
            return SingleChildScrollView(
              child: Container(
                height: size.height,
                child: Stack(
                  children: [
                    build_toolbar(size, primaryColor),
                    build_body(size, primaryColor),
                    Positioned(
                      top: size.height * 0.4,
                      left: size.width * 0.3,
                      child: Container(
                        // height: 50,
                        // width: 60,
                        // color: Colors.amber,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                  app_controller.current_user!.photoURL!),
                            ),
                            Text(
                                '${app_controller.current_user!.email}\n${app_controller.current_user!.displayName}')
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  SingleChildScrollView Body(Size size, Color primaryColor) {
    return SingleChildScrollView(
      child: Container(
        height: size.height,
        child: Stack(
          children: [
            Positioned(
              right: 10,
              top: size.height * 0.4,
              width: 48.1,
              height: size.height * 0.4,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    end: Alignment.bottomLeft,
                    begin: Alignment.topRight,
                    colors: [
                      Color(0xFF3383CD),
                      Color(0xFF11249F),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
