import 'package:fpdart/fpdart.dart';
import 'package:pt_best/core/common/entities/job.dart';
import 'package:pt_best/core/error/failures.dart';
import 'package:pt_best/core/usecase/usecase.dart';
import 'package:pt_best/features/jobs/domain/repository/job_repository.dart';

class GetJob implements UseCase<List<Job>, NoParams> {
  final JobRepository jobRepository;
  GetJob(this.jobRepository);

  @override
  Future<Either<Failure, List<Job>>> call(NoParams params) async {
    return await jobRepository.getJobs();
  }
}
