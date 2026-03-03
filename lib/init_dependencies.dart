import 'package:get_it/get_it.dart';
import 'package:pt_best/core/common/cubit/app_user_cubit.dart';
import 'package:pt_best/core/secrets/app_secrets.dart';
import 'package:pt_best/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:pt_best/features/auth/data/repository/auth_repository_impl.dart';
import 'package:pt_best/features/auth/domain/repository/auth_repository.dart';
import 'package:pt_best/features/auth/domain/usecases/current_user.dart';
import 'package:pt_best/features/auth/domain/usecases/user_login.dart';
import 'package:pt_best/features/auth/domain/usecases/user_sign_up.dart';
import 'package:pt_best/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pt_best/features/jobs/data/datasources/job_remote_data_source.dart';
import 'package:pt_best/features/jobs/data/repository/job_repository_impl.dart';
import 'package:pt_best/features/jobs/domain/repository/job_repository.dart';
import 'package:pt_best/features/jobs/domain/usecases/add_job.dart';
import 'package:pt_best/features/jobs/domain/usecases/get_job.dart';
import 'package:pt_best/features/jobs/presentation/bloc/job_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);

  serviceLocator.registerLazySingleton(() => AppUserCubit());

  _initAuth();
  _initJobs();
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(serviceLocator()),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator()),
    )
    ..registerFactory(() => UserSignUp(serviceLocator()))
    ..registerFactory(() => UserLogin(serviceLocator()))
    ..registerFactory(() => CurrentUser(serviceLocator()))
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        currentUser: serviceLocator(),
        userLogin: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

void _initJobs() {
  serviceLocator
    ..registerFactory<JobRemoteDataSource>(
      () => JobRemoteDataSourceImpl(serviceLocator()),
    )
    ..registerFactory<JobRepository>(() => JobRepositoryImpl(serviceLocator()))
    ..registerFactory(() => AddJob(serviceLocator()))
    ..registerFactory(() => GetJob(serviceLocator()))
    ..registerLazySingleton(
      () => JobBloc(addJob: serviceLocator(), getJob: serviceLocator()),
    );
}
