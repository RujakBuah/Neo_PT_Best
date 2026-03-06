import 'package:flutter/material.dart';
import 'package:pt_best/core/common/entities/job.dart';
import 'package:pt_best/core/theme/app_palete.dart';
import 'package:pt_best/features/jobs/presentation/widgets/job_info_app_bar.dart';

class JobInfoPage extends StatefulWidget {
  final Job job;
  const JobInfoPage({super.key, required this.job});

  @override
  State<JobInfoPage> createState() => _JobInfoPageState();
}

class _JobInfoPageState extends State<JobInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JobInfoAppBar(job: widget.job),
      body: Container(
        decoration: BoxDecoration(color: AppPalette.cleaningIcon),
      ),
    );
  }
}
