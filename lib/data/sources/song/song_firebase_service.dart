import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:spotify/data/models/song/song.dart';
import 'package:spotify/domain/enitites/song/song.dart';

abstract class SongFirebaseService {
  Future<Either> getNewsSongs();
  Future<Either> getPlayList();
  Future<Either> addOrRemoveFavoriteSongs(String songId);
  Future<bool> isFavoriteSong(String songId);
}

class SongFirebaseServiceImpl extends SongFirebaseService {
  @override
  Future<Either> getNewsSongs() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('releasedDate', descending: true)
          .limit(3)
          .get();

      print("DEBUG: Found ${data.docs.length} songs in Firestore");

      for (var element in data.docs) {
        print("DEBUG: Raw song data: ${element.data()}");
        var songModel = SongModel.fromJson(element.data());
        songs.add(songModel.toEntity());
      }
      return Right(songs);
    } catch (e, stack) {
      print("ERROR: Failed to fetch songs: $e");
      print(stack);
      return Left('An Error occurred, Please try again');
    }
  }

  @override
  Future<Either> getPlayList() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance.collection('Songs').get();

      print("DEBUG: Found ${data.docs.length} songs in Firestore");

      for (var element in data.docs) {
        print("DEBUG: Raw song data: ${element.data()}");
        var songModel = SongModel.fromJson(element.data());
        songs.add(songModel.toEntity());
      }
      return Right(songs);
    } catch (e, stack) {
      print("ERROR: Failed to fetch songs: $e");
      print(stack);
      return Left('An Error occurred, Please try again');
    }
  }

  @override
  Future<Either> addOrRemoveFavoriteSongs(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      late bool isFavorite;

      var user = firebaseAuth.currentUser;
      String uID = user!.uid;

      QuerySnapshot favoriteSongs = await firebaseFirestore
          .collection('User')
          .doc(uID)
          .collection('Favorites')
          .where('songId', isEqualTo: songId)
          .get();

      if (favoriteSongs.docs.isNotEmpty) {
        await favoriteSongs.docs.first.reference.delete();
        isFavorite = false;
      } else {
        firebaseFirestore
            .collection('User')
            .doc(uID)
            .collection("Favorites")
            .add({'songId': songId, 'addedDate': Timestamp.now()});
        isFavorite = true;
      }
      return Right(isFavorite);
    } catch (e) {
      return Left("An Error occured");
    }
  }

  @override
  Future<bool> isFavoriteSong(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = firebaseAuth.currentUser;
      String uID = user!.uid;

      QuerySnapshot favoriteSongs = await firebaseFirestore
          .collection('User')
          .doc(uID)
          .collection('Favorites')
          .where('songId', isEqualTo: songId)
          .get();

      if (favoriteSongs.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
