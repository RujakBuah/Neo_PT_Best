import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pt_best/features/jobs/presentation/widgets/job_app_bar.dart';
import 'package:pt_best/core/theme/app_palete.dart';
import 'package:pt_best/features/jobs/presentation/bloc/job_bloc.dart';

class JobListingPage extends StatefulWidget {
  // ignore: strict_top_level_inference
  static route() =>
      MaterialPageRoute(builder: (context) => const JobListingPage());
  const JobListingPage({super.key});

  @override
  State<JobListingPage> createState() => _JobListingPageState();
}

class _JobListingPageState extends State<JobListingPage> {
  @override
  void initState() {
    super.initState();
    context.read<JobBloc>().add(JobFetchAllJobs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JobAppBar(),
      body: Container(color: AppPalette.background),
    );
  }
}
