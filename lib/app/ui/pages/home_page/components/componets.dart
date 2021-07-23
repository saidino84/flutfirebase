import 'package:flutfirebase/app/ui/utils/shared.dart';

import 'home_top_custom_painter.dart';

class Components {
  var app_controller = Get.find<AppController>();
  Widget build_toolbar(Size size, Color primaryColor) {
    return Positioned(
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
    );
  }

  Widget build_body(Size size, Color primaryColor) {
    return Positioned(
        right: 0,
        left: 0,
        top: size.height * 0.25,
        child: Container(
            height: size.height,
            color: Colors.blueAccent,
            child: Column(
              children: [
                IconButton(
                  icon: Icon(Icons.logout),
                  tooltip: 'Sair do app',
                  onPressed: () => app_controller.log_out_current_user(),
                ),
                Expanded(
                  child: Text('Login WeLL Suceded'),
                ),
              ],
            )));
  }
}
