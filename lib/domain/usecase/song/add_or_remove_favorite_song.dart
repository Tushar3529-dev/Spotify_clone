import 'package:dartz/dartz.dart';
import 'package:spotify/core/configs/usecase/usecase.dart';

import 'package:spotify/domain/repositorys/song/song.dart';
import 'package:spotify/service_locator.dart';

class AddOrRemoveFavoriteSongUseCase implements Usecase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<SongsRepository>().addOrRemoveFavoriteSongs(params!);
  }
}
