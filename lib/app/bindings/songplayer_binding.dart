import 'package:flutfirebase/app/controllers/upload_controller.dart';
import 'package:get/get.dart';
import '../controllers/songplayer_controller.dart';

class SongplayerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SongplayerController>(() => SongplayerController());
    Get.lazyPut<UploadController>(() => UploadController());
  }
}
