import 'package:cloud_firestore/cloud_firestore.dart';

class SongEntity {
  final String title;
  final String artist;
  final num duration;
  final Timestamp releasedDate;
  /*   final bool isFavorite; */
  final String imageUrl;
  final String songUrl;

  const SongEntity({
    required this.title,
    required this.artist,
    required this.duration,
    required this.releasedDate,
    required this.imageUrl,
    required this.songUrl,
    /*   required this.isFavorite */
  });

  SongEntity copyWith({
    String? title,
    String? artist,
    num? duration,
    Timestamp? releasedDate,
    bool? isFavorite,
    String? imageUrl,
    String? songUrl,
  }) {
    return SongEntity(
      title: title ?? this.title,
      artist: artist ?? this.artist,
      duration: duration ?? this.duration,
      releasedDate: releasedDate ?? this.releasedDate,
      /*   isFavorite: isFavorite??this.isFavorite, */
      imageUrl: imageUrl ?? this.imageUrl,
      songUrl: songUrl ?? this.songUrl,
    );
  }

  @override
  String toString() {
    return 'SongEntity(title: $title, artist: $artist, duration: $duration, releasedDate: $releasedDate, imageUrl: $imageUrl,songUrl:$songUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SongEntity &&
        other.title == title &&
        other.artist == artist &&
        other.duration == duration &&
        other.releasedDate == releasedDate &&
        other.imageUrl == imageUrl &&
        other.songUrl == songUrl;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        artist.hashCode ^
        duration.hashCode ^
        releasedDate.hashCode ^
        imageUrl.hashCode ^
        songUrl.hashCode;
  }
}
