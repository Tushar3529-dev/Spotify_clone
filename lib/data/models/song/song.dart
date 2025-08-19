import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify/domain/enitites/song/song.dart';

class SongModel {
  final String title;
  final String artist;
  final num duration;
  final Timestamp releasedDate;
  /*   final bool   isFavorite; */
  final String imageUrl;
  final String songUrl;

  SongModel({
    required this.title,
    required this.artist,
    required this.duration,
    required this.releasedDate,
    required this.imageUrl,
    required this.songUrl,

    /*    required  this.isFavorite */
  });

  factory SongModel.fromJson(Map<String, dynamic> data) {
    print("Firestore Song Data: $data"); // Debug log

    return SongModel(
      title: data['title'] ?? 'title',
      artist: data['artist'] ?? 'name',
      duration: (data['duration'] is num) ? data['duration'] : 0,
      releasedDate: data['releasedDate'] is Timestamp
          ? data['releasedDate']
          : Timestamp.now(),
      imageUrl:
          data['imageUrl'] ??
          'https://img.lovepik.com/free-png/20211215/lovepik-song-of-love-png-image_401669880_wh1200.png',
      songUrl: data['songUrl'] ?? "",

      /*    isFavorite: data['fav']??false, */
    );
  }
}

extension SongModelX on SongModel {
  SongEntity toEntity() {
    return SongEntity(
      title: title,
      artist: artist,
      duration: duration,
      releasedDate: releasedDate,
      imageUrl: imageUrl,
      songUrl: songUrl,
      /*       isFavorite: isFavorite, */
    );
  }
}
