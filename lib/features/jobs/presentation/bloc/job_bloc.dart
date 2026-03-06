import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pt_best/core/common/entities/job.dart';
import 'package:pt_best/core/usecase/usecase.dart';
import 'package:pt_best/features/jobs/domain/usecases/add_job.dart';
import 'package:pt_best/features/jobs/domain/usecases/apply_for_job.dart';
import 'package:pt_best/features/jobs/domain/usecases/get_job.dart';

part 'job_event.dart';
part 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  final AddJob _addJob;
  final GetJob _getJob;
  final ApplyForJob _applyForJob;
  JobBloc({
    required AddJob addJob,
    required GetJob getJob,
    required ApplyForJob applyForJob,
  }) : _addJob = addJob,
       _getJob = getJob,
       _applyForJob = applyForJob,
       super(JobInitial()) {
    on<JobUpload>(_onAddJob);
    on<JobFetchAllJobs>(_onFetchAllJobs);
    on<JobApply>(_onJobApply);
  }

  void _onAddJob(JobUpload event, Emitter<JobState> emit) async {
    emit(JobLoading());
    final res = await _addJob(
      AddJobParams(
        title: event.title,
        description: event.description,
        payout: event.payout,
        jobType: event.jobType,
        companyName: event.companyName,
        pickupLocation: event.pickupLocation,
        dropoffLocation: event.dropoffLocation,
        completeBy: event.completeBy,
      ),
    );

    res.fold(
      (l) => emit(JobFailure(l.message)),
      (r) => emit(JobUploadSuccess()),
    );
  }

  void _onFetchAllJobs(JobFetchAllJobs event, Emitter<JobState> emit) async {
    emit(JobLoading());
    final res = await _getJob(NoParams());

    res.fold(
      (l) => emit(JobFailure(l.message)),
      (r) => emit(JobDisplaySuccess(r)),
    );
  }

  void _onJobApply(JobApply event, Emitter<JobState> emit) async {
    emit(JobLoading());
    final res = await _applyForJob(
      ApplyForJobParams(jobId: event.jobId, userId: event.userId),
    );
    res.fold(
      (failure) => emit(JobFailure(failure.message)),
      (_) => emit(JobApplySuccess()),
    );
  }
}
