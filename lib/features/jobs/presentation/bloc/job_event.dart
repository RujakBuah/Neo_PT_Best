part of 'job_bloc.dart';

@immutable
sealed class JobEvent {}

final class JobUpload extends JobEvent {
  final String title;
  final String description;
  final int payout;
  final String jobType;
  final String companyName;
  final String? pickupLocation;
  final String? dropoffLocation;
  final DateTime completeBy;
  final String? jobLocation;

  JobUpload({
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

final class JobFetchAllJobs extends JobEvent {}

final class JobApply extends JobEvent {
  final String jobId;
  final String userId;

  JobApply({required this.jobId, required this.userId});
}
