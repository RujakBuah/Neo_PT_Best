import 'package:pt_best/core/error/exceptions.dart';
import 'package:pt_best/features/jobs/data/models/job_model.dart';
import 'package:supabase/supabase.dart';

abstract interface class JobRemoteDataSource {
  Session? get currentUserSession;
  Future<JobModel> uploadJob(JobModel job);
  Future<List<JobModel>> getJobs();
}

class JobRemoteDataSourceImpl implements JobRemoteDataSource {
  final SupabaseClient supabaseClient;
  JobRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<List<JobModel>> getJobs() async {
    try {
      final jobs = await supabaseClient.from('jobs').select();
      return jobs.map((job) => JobModel.fromJson(job)).toList();
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
  Session? get currentUserSession => supabaseClient.auth.currentSession;
}
