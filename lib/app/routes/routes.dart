import 'package:flutfirebase/app/bindings/app_binding.dart';
import 'package:flutfirebase/app/bindings/todo_binding.dart';
import 'package:flutfirebase/app/ui/pages/home_page/home_page.dart';
import 'package:flutfirebase/app/ui/pages/todo_page/todo_page.dart';
import 'package:flutfirebase/app/ui/utils/shared.dart';

class AppRoutes {
  static final String HOME = '/';
  static final String TODO = '/todo';
}

class AppPages {
  static final List<GetPage> app_pages = [
    GetPage(name: AppRoutes.HOME, page: () => HomePage(), bindings: [
      AppBinding(),
      HomeBinding(),
    ]),
    GetPage(name: AppRoutes.TODO, page: () => TodoPage(), bindings: [
      AppBinding(),
      TodoBinding(),
    ]),
  ];
}
