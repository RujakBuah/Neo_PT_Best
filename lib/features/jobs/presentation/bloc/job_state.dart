part of 'job_bloc.dart';

@immutable
sealed class JobState {
  const JobState();
}

final class JobInitial extends JobState {}

final class JobLoading extends JobState {}

final class JobFailure extends JobState {
  final String error;
  const JobFailure(this.error);
}

final class JobUploadSuccess extends JobState {}

final class JobDisplaySuccess extends JobState {
  final List<Job> job;
  const JobDisplaySuccess(this.job);
}

final class JobApplySuccess extends JobState {}

final class JobSeeInfoSuccess extends JobState {}

final class JobDisplayMyJobSuccess extends JobState {
  final List<Job> jobs;
  const JobDisplayMyJobSuccess(this.jobs);
}
