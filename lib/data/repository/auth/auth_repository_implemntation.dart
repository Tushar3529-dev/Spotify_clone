import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/auth/create_user_request.dart';
import 'package:spotify/data/models/auth/signin_user_request.dart';
import 'package:spotify/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify/domain/repositorys/auth/auth.dart';
import 'package:spotify/service_locator.dart';

class AuthRepositoryImplemntation extends AuthRepository {
  @override
  Future<Either> signin(SigninUserRequest signinUserReq) async {
    return await sl<AuthFirebaseService>().signin(signinUserReq);
  }

  @override
  Future<Either> signup(CereateUserRequest createUserReq) async {
    return await sl<AuthFirebaseService>().signup(createUserReq);
  }
}
