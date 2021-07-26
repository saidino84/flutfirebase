
import 'package:get/get.dart';
import '../controllers/songplayer_controller.dart';


class SongplayerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SongplayerController>(() => SongplayerController());
  }
}