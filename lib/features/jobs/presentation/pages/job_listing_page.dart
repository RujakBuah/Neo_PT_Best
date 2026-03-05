import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pt_best/core/common/widgets/loader.dart';
import 'package:pt_best/core/utils/show_snackbar.dart';
import 'package:pt_best/features/jobs/presentation/widgets/job_app_bar.dart';
import 'package:pt_best/features/jobs/presentation/bloc/job_bloc.dart';
import 'package:pt_best/features/jobs/presentation/widgets/job_card.dart';

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
      body: BlocConsumer<JobBloc, JobState>(
        listener: (context, state) {
          if (state is JobFailure) {
            showSnackBar(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is JobLoading) {
            return const Loader();
          }
          if (state is JobDisplaySuccess) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ).copyWith(top: 10),
                    child: RichText(
                      text: TextSpan(
                        text: 'Available Jobs (${state.job.length})',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.job.length,
                    itemBuilder: (context, index) {
                      final job = state.job[index];
                      return JobCard(job: job);
                    },
                  ),
                  SizedBox(height: 20),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
