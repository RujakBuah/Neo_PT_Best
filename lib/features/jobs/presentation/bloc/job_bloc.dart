import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pt_best/core/common/entities/job.dart';
import 'package:pt_best/core/usecase/usecase.dart';
import 'package:pt_best/features/jobs/domain/usecases/add_job.dart';
import 'package:pt_best/features/jobs/domain/usecases/get_job.dart';

part 'job_event.dart';
part 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  final AddJob _addJob;
  final GetJob _getJob;
  JobBloc({required AddJob addJob, required GetJob getJob})
    : _addJob = addJob,
      _getJob = getJob,
      super(JobInitial()) {
    on<JobEvent>((event, emit) => emit(JobLoading()));
    on<JobUpload>(_onAddJob);
    on<JobFetchAllJobs>(_onFetchAllJobs);
  }

  void _onAddJob(JobUpload event, Emitter<JobState> emit) async {
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
    final res = await _getJob(NoParams());

    res.fold(
      (l) => emit(JobFailure(l.message)),
      (r) => emit(JobDisplaySuccess(r)),
    );
  }
}
