import 'package:dartz/dartz.dart';
import 'package:spotify/core/configs/usecase/usecase.dart';
import 'package:spotify/data/models/auth/create_user_request.dart';
import 'package:spotify/domain/repositorys/auth/auth.dart';
import 'package:spotify/service_locator.dart';

class SignupUseCase implements Usecase<Either, CereateUserRequest> {
  @override
  Future<Either> call({CereateUserRequest? params}) async {
    return sl<AuthRepository>().signup(params!);
  }
}
