import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pt_best/core/common/entities/job.dart';
import 'package:pt_best/core/constants/constants.dart';
import 'package:pt_best/core/theme/app_palete.dart';
import 'package:pt_best/core/utils/capitilize_first_letter.dart';
import 'package:pt_best/core/utils/format_number.dart';

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
        return Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppPalette.surface,
            border: Border.all(color: AppPalette.border),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          text: '\n${job.title}',
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                color: AppPalette.textSecondary,
                                fontWeight: FontWeight.normal,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Constants.jobStatusBgColors[job.status],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          text: capitilize(job.status),
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(
                                color: AppPalette.textPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              RichText(
                text: TextSpan(
                  text: formatAsCurrency(job.payout),
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: AppPalette.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
