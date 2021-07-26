import 'package:flutfirebase/app/bindings/app_binding.dart';
import 'package:flutfirebase/app/bindings/songplayer_binding.dart';
import 'package:flutfirebase/app/bindings/todo_binding.dart';
import 'package:flutfirebase/app/ui/pages/auth_page/auth_page.dart';
import 'package:flutfirebase/app/ui/pages/home_page/home_page.dart';
import 'package:flutfirebase/app/ui/pages/login_page/login_page.dart';
import 'package:flutfirebase/app/ui/pages/register_page/register_page.dart';
import 'package:flutfirebase/app/ui/pages/songplayer_page/songplayer_page.dart';
import 'package:flutfirebase/app/ui/pages/todo_page/todo_page.dart';
import 'package:flutfirebase/app/ui/utils/shared.dart';

class AppRoutes {
  static final String HOME = '/';
  static final String REGISTER = '/register';
  static final String LOGIN = '/login';
  static final String TODO = '/todo';
  static final String AUTH = '/auth';
  static final String PLAYER = '/player';
}

class AppPages {
  static final List<GetPage> app_pages = [
    GetPage(name: AppRoutes.AUTH, page: () => AuthPage(), bindings: [
      AppBinding(),
      HomeBinding(),
    ]),
    GetPage(name: AppRoutes.HOME, page: () => HomePage(), bindings: [
      AppBinding(),
      HomeBinding(),
    ]),
    GetPage(name: AppRoutes.PLAYER, page: () => SongplayerPage(), bindings: [
      AppBinding(),
      SongplayerBinding(),
    ]),
    GetPage(name: AppRoutes.TODO, page: () => TodoPage(), bindings: [
      AppBinding(),
      TodoBinding(),
    ]),
    GetPage(name: AppRoutes.LOGIN, page: () => LoginPage(), bindings: [
      AppBinding(),
      HomeBinding(),
    ]),
    GetPage(name: AppRoutes.REGISTER, page: () => RegisterPage(), bindings: [
      AppBinding(),
      HomeBinding(),
    ]),
  ];
}
