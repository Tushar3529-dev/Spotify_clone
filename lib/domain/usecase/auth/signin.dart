import 'package:dartz/dartz.dart';
import 'package:spotify/core/configs/usecase/usecase.dart';
import 'package:spotify/data/models/auth/signin_user_request.dart';
import 'package:spotify/domain/repositorys/auth/auth.dart';
import 'package:spotify/service_locator.dart';

class SigninUsecase implements Usecase<Either, SigninUserRequest> {
  @override
  Future<Either> call({SigninUserRequest? params}) async {
    return await sl<AuthRepository>().signin(params!);
  }
}
