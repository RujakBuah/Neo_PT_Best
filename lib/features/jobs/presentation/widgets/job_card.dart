import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pt_best/core/common/entities/job.dart';
import 'package:pt_best/core/constants/constants.dart';
import 'package:pt_best/core/theme/app_palete.dart';
import 'package:pt_best/core/utils/format_number.dart';
import 'package:pt_best/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pt_best/features/jobs/presentation/bloc/job_bloc.dart';
import 'package:pt_best/features/jobs/presentation/widgets/job_apply_button.dart';

class JobCard extends StatelessWidget {
  final Job job;
  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    void jobApply() {
      final authState = context.read<AuthBloc>().state;
      if (authState is! AuthSuccess) return;

      context.read<JobBloc>().add(
        JobApply(jobId: job.id, userId: authState.user.id),
      );
    }

    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(16).copyWith(bottom: 4),
        decoration: BoxDecoration(
          color: AppPalette.surface,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Constants.jobTypeBgColors[job.jobType],
                  ),
                  child: Icon(
                    Constants.jobTypeIcons[job.jobType],
                    color: Constants.jobTypeIconColors[job.jobType],
                    size: 20,
                  ),
                ),
                SizedBox(width: 10),
                RichText(
                  text: TextSpan(
                    text: job.companyName,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppPalette.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: '\nOrder #Sample',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: AppPalette.iconDefault,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Constants.jobTypeBgColors[job.jobType],
                  ),
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        text: job.jobType,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Constants.jobTypeIconColors[job.jobType],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    text: formatAsCurrency(job.payout),
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppPalette.border,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.info_outline),
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            SizedBox(height: 8),
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    text: 'POSTED BY\n',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: AppPalette.iconDefault,
                    ),
                    children: [
                      TextSpan(
                        text: job.postedBy,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: AppPalette.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 15),
                RichText(
                  text: TextSpan(
                    text: 'COMPLETE BY\n',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: AppPalette.iconDefault,
                    ),
                    children: [
                      TextSpan(
                        text: formatAsDate(job.completeBy),
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: AppPalette.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                JobApplyButton(buttonText: 'Apply →', onPressed: jobApply),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
