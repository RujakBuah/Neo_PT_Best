import 'package:fpdart/fpdart.dart';
import 'package:pt_best/core/common/entities/job.dart';
import 'package:pt_best/core/error/exceptions.dart';
import 'package:pt_best/core/error/failures.dart';
import 'package:pt_best/features/jobs/data/datasources/job_remote_data_source.dart';
import 'package:pt_best/features/jobs/data/models/job_model.dart';
import 'package:pt_best/features/jobs/domain/repository/job_repository.dart';
import 'package:uuid/uuid.dart';

class JobRepositoryImpl implements JobRepository {
  final JobRemoteDataSource jobRemoteDataSource;
  JobRepositoryImpl(this.jobRemoteDataSource);

  @override
  Future<Either<Failure, Job>> addJob({
    required String title,
    required String description,
    required int payout,
    required String jobType,
    required String companyName,
    String? pickupLocation,
    String? dropoffLocation,
    required DateTime completeBy,
  }) async {
    try {
      JobModel jobModel = JobModel(
        id: const Uuid().v1(),
        createdAt: DateTime.now(),
        title: title,
        description: description,
        payout: payout,
        jobType: jobType,
        postedBy: jobRemoteDataSource.currentUserSession!.user.id,
        companyName: companyName,
        status: 'pending',
        completeBy: completeBy,
      );
      final res = await jobRemoteDataSource.uploadJob(jobModel);
      return right(res);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Job>>> getJobs() async {
    try {
      final job = await jobRemoteDataSource.getJobs();
      return right(job);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
