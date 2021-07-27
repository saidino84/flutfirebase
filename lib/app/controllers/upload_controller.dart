import 'dart:io';
import 'package:path/path.dart' as os_path;
import 'package:file_picker/file_picker.dart';
import 'package:flutfirebase/app/ui/utils/shared.dart';

class UploadController extends GetxController {
  final form_key = GlobalKey<FormState>();
  final song_uri_contrl = TextEditingController();
  final song_title_contrl = TextEditingController();
  final song_artist_contrl = TextEditingController();

  late Rx<File> song_uri;
  late Rx<File> cover_uri;
  final is_solo = true.obs;

  final has_cover = false.obs;

  void change_is_solo(value) {
    is_solo.value = !is_solo.value;
  }

  void select_music_cover() async {
    has_cover.value = false;
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      PlatformFile file = result.files.first;
      var path = file.path;
      // Get.snackbar('${os_path.basename(!file)}', message)
      Get.snackbar('Got image', '$path');
      if (path != null) {
        cover_uri = File(path).obs;
        has_cover.value = true;
        // image.value = cover_uri.value as Null;
      }
    }
  }

  Future get_audio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      var path = file.path;
      if (path != null) {
        // song_uri.value = File(path);
        song_uri_contrl.text = path; //os_path.basename(path);
      }
      Get.snackbar('Music', 'Sound catch sucessfully');
    }
  }
}
