import 'package:fpdart/fpdart.dart';
import 'package:pt_best/core/error/failures.dart';
import 'package:pt_best/core/usecase/usecase.dart';
import 'package:pt_best/features/jobs/domain/repository/job_repository.dart';

class ApplyForJob implements UseCase<Unit, ApplyForJobParams> {
  final JobRepository jobRepository;
  const ApplyForJob(this.jobRepository);

  @override
  Future<Either<Failure, Unit>> call(ApplyForJobParams params) async {
    return await jobRepository.applyForJob(
      jobId: params.jobId,
      userId: params.userId,
    );
  }
}

class ApplyForJobParams {
  final String jobId;
  final String userId;
  ApplyForJobParams({required this.jobId, required this.userId});
}
