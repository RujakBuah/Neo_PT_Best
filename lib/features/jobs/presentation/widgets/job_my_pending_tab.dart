import 'package:flutter/cupertino.dart';
import 'package:pt_best/core/common/entities/job.dart';

class PendingJobsTab extends StatelessWidget {
  final List<Job> jobs;
  const PendingJobsTab({super.key, required this.jobs});

  @override
  Widget build(BuildContext context) {
    if (jobs.isEmpty) {
      return const Center(child: Text('No Pending Jobs'));
    }
    return ListView.builder(
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final job = jobs[index];
        return Text(job.title);
      },
    );
  }
}
