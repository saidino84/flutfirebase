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
    print('Stared');
    // Criando objecto som
    Song song = Song(artist: artist, songName: title, isSolo: is_solo);

    // pegando areferencia de pastas no storage
    reference.child('flutfirebase').child('images').child(image_path);

    // Salvando a image
    UploadTask image_uploadTask = reference.putData(image_data);
    var download_uri;
    image_uploadTask.then((e) {
      download_uri = e.ref.getDownloadURL();
      image_song_uri['cover_url'] = download_uri;
      song.compyWith(cover_url: download_uri);
      image_uploaded = true;
    }).catchError((e) {
      image_uploaded = true;
    });

// Salvando som
    reference.child('flutfirebase').child('audios').child(audio_path);
    print('image done');
    UploadTask song_uploadTask = reference.putData(audio_data);
    song_uploadTask.then((e) {
      download_uri = e.ref.getDownloadURL();
      image_song_uri['song_uri'] = download_uri;
      song.compyWith(songUrl: download_uri);
      audio_uploaded = true;
    }).catchError((ee) {
      audio_uploaded = true;
    });

    return save_song_to_cloud_firestore(song);
  }

  Future<bool> save_song_to_cloud_firestore(Song song) async {
    // song.compyWith(
    //   cover_url: image_song_uri['cover_uri'],
    //   songUrl: image_song_uri['songUrl'],
    // );
    if (audio_uploaded && image_uploaded) {
      await song_reference.add(song.toJson());
      return true;
    }
    return false;
  }
}
