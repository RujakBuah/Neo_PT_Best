import 'package:fpdart/fpdart.dart';
import 'package:pt_best/core/common/entities/job.dart';
import 'package:pt_best/core/error/failures.dart';
import 'package:pt_best/core/usecase/usecase.dart';
import 'package:pt_best/features/jobs/domain/repository/job_repository.dart';

class AddJob implements UseCase<Job, AddJobParams> {
  final JobRepository jobRepository;
  AddJob(this.jobRepository);

  @override
  Future<Either<Failure, Job>> call(AddJobParams params) async {
    return await jobRepository.addJob(
      title: params.title,
      description: params.description,
      payout: params.payout,
      jobType: params.jobType,
      companyName: params.companyName,
      completeBy: params.completeBy,
      pickupLocation: params.pickupLocation,
      dropoffLocation: params.dropoffLocation,
      jobLocation: params.jobLocation,
    );
  }
}

class AddJobParams {
  final String title;
  final String description;
  final int payout;
  final String jobType;
  final String companyName;
  final String? pickupLocation;
  final String? dropoffLocation;
  final DateTime completeBy;
  final String? jobLocation;

  AddJobParams({
    required this.title,
    required this.description,
    required this.payout,
    required this.jobType,
    required this.companyName,
    this.pickupLocation,
    this.dropoffLocation,
    required this.completeBy,
    this.jobLocation,
  });
}
