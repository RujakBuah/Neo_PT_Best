import 'package:fpdart/fpdart.dart';
import 'package:pt_best/core/common/entities/user.dart';
import 'package:pt_best/core/error/failures.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> currentUser();
}
