import 'package:flutter/material.dart';
import 'package:pt_best/core/common/entities/job.dart';

class AcceptedJobsTab extends StatelessWidget {
  final List<Job> jobs;
  const AcceptedJobsTab({super.key, required this.jobs});

  @override
  Widget build(BuildContext context) {
    if (jobs.isEmpty) {
      return const Center(child: Text('No accepted jobs'));
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
