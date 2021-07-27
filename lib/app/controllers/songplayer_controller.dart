import 'dart:io';

import 'package:flutfirebase/app/data/models/song_model.dart';
import 'package:flutfirebase/app/data/repositories/player_repository.dart';
import 'package:flutfirebase/app/ui/pages/songplayer_page/contents/p_home.dart';
import 'package:flutfirebase/app/ui/pages/songplayer_page/contents/p_upload.dart';
import 'package:flutfirebase/app/ui/utils/shared.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import '../data/repositories/player_repository.dart';

class SongplayerController extends GetxController {
  final repository = PlayerRepository();
  final player = AudioPlayer().obs;
  final playing = false.obs;
  final current_tab = 0.obs;
  final is_active = false;
  final tabs = [PlayerHome(), PlayerUpload()].obs;
  final Rx<Song>? current_song = null;
  Future<Song> get_song() async {
    List<Song> output = await repository.getSongs().single;
    return output.first;
  }

  void to(int tab) {
    current_tab.value = tab;
  }

  void play_song(Song song) {
    // current_song!.value = song;
    print('SONG URL   ====${song.songUrl}');
    player.value.setUrl(song.songUrl!);
    player.value.play();
    playing.value = true;
  }

  void play_pause() {
    if (player.value.playing) {
      player.value.pause();
      playing.value = false;
    } else {
      try {
        player.value.play();
      } on Exception catch (e) {
        player.value.setAsset('assets/audios/drake.mp3');
        player.value.play();
        playing.value = true;
      } on Exception catch (e) {}
    }
    playing.value = !playing.value;

    if (playing.value == false) {}
  }

  Stream<List<Song>> getSongz() {
    return repository.getSongs();
  }
  // Color get active_tab_color =>Colors
}
