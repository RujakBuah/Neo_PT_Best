import 'package:fpdart/fpdart.dart';
import 'package:pt_best/core/common/entities/user.dart';
import 'package:pt_best/core/error/failures.dart';
import 'package:pt_best/core/usecase/usecase.dart';
import 'package:pt_best/features/auth/domain/repository/auth_repository.dart';

class UserLogin implements UseCase<User, UserLoginParams> {
  final AuthRepository authRepository;
  const UserLogin(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return await authRepository.loginWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({required this.email, required this.password});
}
