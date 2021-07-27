import 'dart:io';
import 'package:flutfirebase/app/data/repositories/firebase_api.dart';
import 'package:flutfirebase/app/data/repositories/player_repository.dart';
import 'package:path/path.dart' as os_path;
import 'package:file_picker/file_picker.dart';
import 'package:flutfirebase/app/ui/utils/shared.dart';

class UploadController extends GetxController {
  final repository = PlayerRepository();
  final form_key = GlobalKey<FormState>();

  GlobalKey<FormState> get form_state => form_key;
  final song_uri_contrl = TextEditingController();
  final song_title_contrl = TextEditingController();
  final song_artist_contrl = TextEditingController();

  late Rx<File> song_uri;
  late Rx<File> cover_uri;
  final is_solo = true.obs;

  final has_cover = false.obs;

  Future upload_file_to_storage() async {
    print('upload...');
    var image = cover_uri.value;
    var imagepath = os_path.basename(image.path);

    var audio_data = song_uri.value;
    var audio_path = os_path.basename(audio_data.path);

    var title = song_title_contrl.text.toLowerCase();
    var artist = song_artist_contrl.text.toLowerCase();

    await repository.upload_image_e_audio_file(
        image_data: image.readAsBytesSync(),
        image_path: imagepath,
        audio_data: audio_data.readAsBytesSync(),
        audio_path: audio_path,
        title: title,
        artist: artist,
        is_solo: is_solo.value);
  }

  void change_is_solo(value) {
    is_solo.value = !is_solo.value;
  }

  bool is_all_datagot() {
    var isValid_form = form_state.currentState!.validate();
    if (isValid_form && has_cover.value) {
      form_state.currentState!.save();
      return true;
    }

    return false;
  }

  void save_to() {
    var isvalid = is_all_datagot();
    if (isvalid) {
      print('saving data...');
      upload_file_to_storage().then((value) {
        Get.snackbar('Save $isvalid', 'Save sucess',
            backgroundColor: Colors.blueAccent,
            icon: Icon(Icons.done_all, color: Colors.white),
            shouldIconPulse: true,
            showProgressIndicator: true);
      }).catchError((err) {
        Get.snackbar('Save $isvalid', '$err!',
            backgroundColor: Colors.blueAccent,
            icon: Icon(Icons.sms_failed, color: Colors.redAccent),
            shouldIconPulse: true,
            showProgressIndicator: true);
      });
    } else {
      Get.snackbar('Save $isvalid', 'preeche os campos todos sao necessarios',
          backgroundColor: Colors.amberAccent,
          icon: Icon(Icons.error_outline, color: Colors.redAccent));
    }
  }

  Future get_audio() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowedExtensions: ['.mp3', '.wav'], allowMultiple: false);

    if (result != null) {
      // PlatformFile file = result.files.single.path!;
      var path = result.files.single.path!;
      // var path = file.path;
      if (path != null) {
        song_uri = File(path).obs;
        song_uri_contrl.text = os_path.basename(path); //os_path.basename(path);
      }
      Get.snackbar('Music', 'Sound catch sucessfully');
    }
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
        print('COVER PATH IS =====>$cover_uri');
        // image.value = cover_uri.value as Null;
      }
    }
  }

  Future upload_simple() async {
    var isvalid = is_all_datagot();
    if (isvalid) {
      print('saving data...');
      var audio_data = song_uri.value;
      var audio_path = os_path.basename(audio_data.path);
      if (!audio_path.endsWith(".mp3")) {
        audio_path = audio_path + '.mp3';
      }
      // Get.defaultDialog(title: 'File content type $audio_path');
      // var task = MyFirebaseApi.uploadTask('testes/$audio_path', audio_data);
/*  PODE TAMBEM FAZER-SE O SEGUINTE
      MyFirebaseApi.uploadBytes(
          'data/$audio_path', audio_data.readAsBytesSync());
      **/
      // Baixar o link do file
      // if (task != null) {
      //   final snapshot = await task.whenComplete(() {});
      //   final urlDownload = await snapshot.ref.getDownloadURL();
      // }
      Get.snackbar('Save $isvalid', 'Save sucess ',
          backgroundColor: Colors.blueAccent,
          icon: Icon(Icons.done_all, color: Colors.white),
          shouldIconPulse: true,
          showProgressIndicator: true);
    } else {
      Get.snackbar('Save $isvalid', 'preeche os campos todos sao necessarios',
          backgroundColor: Colors.amberAccent,
          icon: Icon(Icons.error_outline, color: Colors.redAccent));
    }
  }
}
