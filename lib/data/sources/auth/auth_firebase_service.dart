import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/data/models/auth/create_user_request.dart';
import 'package:spotify/data/models/auth/signin_user_request.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(CereateUserRequest createUserRequest);
  Future<Either> signin(SigninUserRequest signinUserRequest);
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either> signin(SigninUserRequest signinUserRequest) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signinUserRequest.email,
        password: signinUserRequest.password,
      );

      return Right("Sign In was Successful!!");
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.code == 'invalid-email') {
        message = "The email address is not valid";
      } else if (e.code == 'user-not-found') {
        message = "No user found for that email";
      } else if (e.code == 'wrong-password') {
        message = "Wrong password provided for that user";
      } else if (e.code == 'invalid-credential') {
        // This now covers both wrong email & wrong password in newer SDKs
        message = "Invalid email or password";
      } else {
        message = "An unexpected error occurred: ${e.message}";
      }
      return Left(message);
    }
  }

  @override
  Future<Either> signup(CereateUserRequest createUserRequest) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserRequest.email,
        password: createUserRequest.password,
      );

      FirebaseFirestore.instance.collection('Users').doc(data.user?.uid).set({
        'name': createUserRequest.fullName,
        'email': data.user?.email,
      });

      return Right("Sign UP was Successful!!");
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.code == 'weak-paassword') {
        message = "The Password Provided is To weak";
      } else if (e.code == "email-already-in-use") {
        message = "An account already exists with that email.";
      } else {
        message = "Try Again with strong password";
      }
      return Left(message);
    }
  }
}
