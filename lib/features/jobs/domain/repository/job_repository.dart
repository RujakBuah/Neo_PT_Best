import 'package:fpdart/fpdart.dart';
import 'package:pt_best/core/common/entities/job.dart';
import 'package:pt_best/core/error/failures.dart';

abstract interface class JobRepository {
  Future<Either<Failure, Job>> addJob({
    required String title,
    required String description,
    required int payout,
    required String jobType,
    required String companyName,
    String? pickupLocation,
    String? dropoffLocation,
    required DateTime completeBy,
    String? jobLocation,
  });

  Future<Either<Failure, List<Job>>> getJobs();

  Future<Either<Failure, Unit>> applyForJob({
    required String jobId,
    required String userId,
  });
}
