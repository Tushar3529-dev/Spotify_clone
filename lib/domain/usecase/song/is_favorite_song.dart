import 'package:spotify/core/configs/usecase/usecase.dart';

import 'package:spotify/domain/repositorys/song/song.dart';
import 'package:spotify/service_locator.dart';

class IsFavoriteSongUseCase implements Usecase<bool, String> {
  @override
  Future<bool> call({String? params}) async {
    return await sl<SongsRepository>().isFavoriteSong(params!);
  }
}
