import 'package:flutfirebase/app/routes/routes.dart';
import 'package:flutfirebase/app/ui/utils/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/home_controller.dart';
import 'components/home_top_custom_painter.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: ClipPath(
              clipper: HomeTopCustomPainter(),
              child: Container(
                height: size.height * 0.3,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        end: Alignment.bottomLeft,
                        begin: Alignment.topRight,
                        colors: [
                      Color(0xFF3383CD),
                      Color(0xFF11249F),
                    ])),
                child: Column(
                  children: [
                    Container(
                      // height: kToolbarHeight,
                      child: Text('Well come'),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            width: size.width * 0.7,
                            height: 40,
                            child: TextField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white24,

                                suffixIcon: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Icon(Icons.search),
                                ),
                                // focusedBorder: InputBorder.none,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            child: IconButton(
                                icon: Icon(Icons.scatter_plot_outlined,
                                    color: primaryColor),
                                onPressed: () {
                                  Get.toNamed(AppRoutes.TODO);
                                })),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
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
    );
  }
}
