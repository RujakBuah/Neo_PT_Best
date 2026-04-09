import 'package:pt_best/core/error/exceptions.dart';
import 'package:pt_best/features/jobs/data/models/job_model.dart';
import 'package:supabase/supabase.dart';

abstract interface class JobRemoteDataSource {
  Session? get currentUserSession;
  Future<JobModel> uploadJob(JobModel job);
  Future<List<JobModel>> getJobs();
  Future<void> applyForJob({required String jobId, required String userId});
  Future<int> getAvailableJobCount();
  Future<List<JobModel>> getMyJobs({required String userId});
}

class JobRemoteDataSourceImpl implements JobRemoteDataSource {
  final SupabaseClient supabaseClient;
  JobRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<List<JobModel>> getJobs() async {
    try {
      final jobs = await supabaseClient
          .from('jobs')
          .select(
            '*, posted_by_profile:profiles!jobs_posted_by_fkey(name), assigned_to_profile:profiles!jobs_assigned_to_fkey(name)',
          );
      return jobs.map((job) {
        return JobModel.fromJson(job).copyWith(
          postedBy: job['posted_by_profile']?['name'] as String?,
          assignedTo: job['assigned_to_profile']?['name'] as String?,
        );
      }).toList();
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<JobModel> uploadJob(JobModel job) async {
    try {
      final jobData = await supabaseClient
          .from('jobs')
          .insert(job.toJson())
          .select();
      return JobModel.fromJson(jobData.first);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> applyForJob({
    required String jobId,
    required String userId,
  }) async {
    try {
      await supabaseClient
          .from('jobs')
          .update({'assigned_to': userId})
          .eq('id', jobId);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<int> getAvailableJobCount() async {
    try {
      final response = await supabaseClient
          .from('jobs')
          .select('*')
          .isFilter('assigned_to', null)
          .count(CountOption.exact);
      return response.count;
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<List<JobModel>> getMyJobs({required String userId}) async {
    try {
      final jobs = await supabaseClient
          .from('jobs')
          .select('*')
          .eq('assigned_to', userId);
      return jobs.map((job) => JobModel.fromJson(job)).toList();
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    }
  }
}
