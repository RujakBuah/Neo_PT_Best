import 'package:fpdart/fpdart.dart';
import 'package:pt_best/core/common/entities/job.dart';
import 'package:pt_best/core/error/failures.dart';
import 'package:pt_best/core/usecase/usecase.dart';
import 'package:pt_best/features/jobs/domain/repository/job_repository.dart';

class GetMyJobs implements UseCase<List<Job>, GetMyJobParams> {
  final JobRepository jobRepository;
  GetMyJobs(this.jobRepository);

  @override
  Future<Either<Failure, List<Job>>> call(GetMyJobParams params) async {
    return await jobRepository.getMyJobs(userId: params.userId);
  }
}

class GetMyJobParams {
  final String userId;
  GetMyJobParams({required this.userId});
}
