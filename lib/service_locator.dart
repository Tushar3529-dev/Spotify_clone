import 'package:get_it/get_it.dart';
import 'package:spotify/data/repository/auth/auth_repository_implemntation.dart';
import 'package:spotify/data/repository/song/song_repository_imple.dart';
import 'package:spotify/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify/data/sources/song/song_firebase_service.dart';
import 'package:spotify/domain/repositorys/auth/auth.dart';
import 'package:spotify/domain/repositorys/song/song.dart';
import 'package:spotify/domain/usecase/auth/signin.dart';
import 'package:spotify/domain/usecase/auth/signup.dart';
import 'package:spotify/domain/usecase/song/add_or_remove_favorite_song.dart';
import 'package:spotify/domain/usecase/song/get_news_songs.dart';
import 'package:spotify/domain/usecase/song/get_playlist_songs.dart';
import 'package:spotify/domain/usecase/song/is_favorite_song.dart';

final sl = GetIt.instance;

Future<void> initilaizeDependecies() async {
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());

  sl.registerSingleton<SongFirebaseService>(SongFirebaseServiceImpl());

  sl.registerSingleton<AuthRepository>(AuthRepositoryImplemntation());

  sl.registerSingleton<SongsRepository>(SongRepositoryImple());

  sl.registerSingleton<SignupUseCase>(SignupUseCase());

  sl.registerSingleton<SigninUsecase>(SigninUsecase());

  sl.registerSingleton<GetNewsSongsUseCase>(GetNewsSongsUseCase());

  sl.registerSingleton<GetPlaylistUsecase>(GetPlaylistUsecase());

  sl.registerSingleton<IsFavoriteSongUseCase>(IsFavoriteSongUseCase());

  sl.registerSingleton<AddOrRemoveFavoriteSongUseCase>(
    AddOrRemoveFavoriteSongUseCase(),
  );
}
