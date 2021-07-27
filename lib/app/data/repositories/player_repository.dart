import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutfirebase/app/data/models/song_model.dart';
import 'package:flutfirebase/app/ui/utils/shared.dart';

class PlayerRepository {
  final CollectionReference song_reference =
      FirebaseFirestore.instance.collection('admin');
  var reference = FirebaseStorage.instance.ref();

  var image_song_uri = <String, String>{};
  var image_uploaded = false;
  var audio_uploaded = false;

  List<Song> songsFRimFirestore(QuerySnapshot snapshot) {
    if (snapshot != null) {
      return snapshot.docs.map((element) {
        Map<String, dynamic> dada = element.data() as Map<String, dynamic>;
        return Song.fromJson(dada).copyWith(uid: element.id);
      }).toList();
    }
    return <Song>[];
  }

  Stream<List<Song>> getSongs() {
    return song_reference.snapshots().map(songsFRimFirestore);
  }

  // ignore: non_constant_identifier_names
  Future<bool> upload_image_e_audio_file({
    required Uint8List image_data,
    required String image_path,
    required Uint8List audio_data,
    required String audio_path,
    required String title,
    required String artist,
    required bool is_solo,
  }) async {
    image_uploaded = false;
    audio_uploaded = false;
    print('Stared');
    // Criando objecto som
    Song song = Song(artist: artist, songName: title, isSolo: is_solo);

    // UPLOAD DE IMAGE
    // pegando areferencia de pastas no storage
    final cover_ref =
        FirebaseStorage.instance.ref('flutfirebase/covers/$image_path');

    var cov_task = cover_ref.putData(image_data);
    var cover_uri = await get_uploaded_image_uri(cov_task);
    if (cover_uri != null) {
      song = song.copyWith(cover_url: cover_uri);
      image_uploaded = true;
    }
    // UPLOAD DE SONG
    final song_ref =
        FirebaseStorage.instance.ref('flutfirebase/songs/$audio_path');
    var song_task = song_ref.putData(audio_data);
    var song_uri = await get_uploaded_image_uri(song_task);
    // if (song_uri != null) {
    song = song.copyWith(songUrl: song_uri);
    audio_uploaded = true;
    // }

    return save_song_to_cloud_firestore(song);
  }

  Future<String?> get_uploaded_image_uri(UploadTask task) async {
    if (task != null) {
      final snapshot = await task.whenComplete(() {});
      final uri_downloaded = await snapshot.ref.getDownloadURL();
      return uri_downloaded;
    } else {
      return null;
    }
  }

  Future<bool> save_song_to_cloud_firestore(Song song) async {
    if (audio_uploaded && image_uploaded) {
      await song_reference.add(song.toJson());
      return true;
    }
    return false;
  }
}
