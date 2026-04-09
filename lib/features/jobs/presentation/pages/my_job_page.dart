import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pt_best/core/common/cubit/app_user_cubit.dart';
import 'package:pt_best/core/common/entities/job.dart';
import 'package:pt_best/core/common/widgets/loader.dart';
import 'package:pt_best/core/theme/app_palete.dart';
import 'package:pt_best/core/utils/show_snackbar.dart';
import 'package:pt_best/features/jobs/presentation/bloc/job_bloc.dart';
import 'package:pt_best/features/jobs/presentation/widgets/job_my_accepted_tab.dart';
import 'package:pt_best/features/jobs/presentation/widgets/job_my_completed_job.dart';
import 'package:pt_best/features/jobs/presentation/widgets/job_my_job_app_bar.dart';
import 'package:pt_best/features/jobs/presentation/widgets/job_my_pending_tab.dart';

class MyJobPage extends StatefulWidget {
  const MyJobPage({super.key});

  @override
  State<MyJobPage> createState() => _MyJobPageState();
}

class _MyJobPageState extends State<MyJobPage> {
  final PageController _pageController = PageController();
  int _currentTab = 0;

  @override
  void initState() {
    super.initState();
    final userId =
        (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
    context.read<JobBloc>().add(JobFetchMyJobs(userId: userId));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(250),
        child: BlocBuilder<JobBloc, JobState>(
          builder: (context, state) {
            final jobs = state is JobDisplayMyJobSuccess ? state.jobs : <Job>[];
            return MyJobAppBar(jobs: jobs);
          },
        ),
      ),
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
          if (state is JobDisplayMyJobSuccess) {
            final pending = state.jobs
                .where((j) => j.status == 'pending')
                .toList();
            final accepted = state.jobs
                .where((j) => j.status == 'accepted')
                .toList();
            final completed = state.jobs
                .where((j) => j.status == 'completed')
                .toList();

            return Column(
              children: [
                // ── Tab bar ──────────────────────────────────
                Container(
                  color: AppPalette.surface,
                  child: Row(
                    children: ['Pending', 'Accepted', 'Completed']
                        .asMap()
                        .entries
                        .map(
                          (entry) => Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() => _currentTab = entry.key);
                                _pageController.animateToPage(
                                  entry.key,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: AppPalette.surface,
                                  border: Border(
                                    bottom: BorderSide(
                                      color: _currentTab == entry.key
                                          ? AppPalette.primary
                                          : Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  entry.value,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: _currentTab == entry.key
                                        ? AppPalette.primary
                                        : AppPalette.textHint,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const Divider(height: 1),

                // ── Page content ─────────────────────────────
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) =>
                        setState(() => _currentTab = index),
                    children: [
                      PendingJobsTab(jobs: pending),
                      AcceptedJobsTab(jobs: accepted),
                      CompletedJobsTab(jobs: completed),
                    ],
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
