import 'package:flutfirebase/app/data/repositories/player_repository.dart';
import 'package:flutfirebase/app/ui/pages/songplayer_page/contents/p_home.dart';
import 'package:flutfirebase/app/ui/pages/songplayer_page/contents/p_upload.dart';
import 'package:flutfirebase/app/ui/utils/shared.dart';
import 'package:get/get.dart';

import '../data/repositories/player_repository.dart';

class SongplayerController extends GetxController {
  final repository = PlayerRepository();
  final form_key = GlobalKey<FormState>();
  final song_uri_contrl = TextEditingController();
  final song_title_contrl = TextEditingController();
  final song_artist_contrl = TextEditingController();
  final current_tab = 0.obs;
  final is_active = false;
  final tabs = [PlayerHome(), PlayerUpload()].obs;
  void to(int tab) {
    current_tab.value = tab;
  }

  // Color get active_tab_color =>Colors
}
