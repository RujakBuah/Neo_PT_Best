import 'package:fpdart/fpdart.dart';
import 'package:pt_best/core/common/entities/user.dart';
import 'package:pt_best/core/error/failures.dart';
import 'package:pt_best/core/usecase/usecase.dart';
import 'package:pt_best/features/auth/domain/repository/auth_repository.dart';

class UserSignUp implements UseCase<User, UserSignUpParams> {
  final AuthRepository authRepository;
  const UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) {
    return authRepository.signUpWithEmailAndPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;

  UserSignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
