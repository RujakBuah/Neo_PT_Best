import 'package:flutter/material.dart';
import 'package:pt_best/core/common/entities/job.dart';
import 'package:pt_best/core/theme/app_palete.dart';
import 'package:pt_best/core/utils/format_number.dart';
import 'package:pt_best/features/jobs/presentation/widgets/job_info_app_bar.dart';
import 'package:pt_best/features/jobs/presentation/widgets/job_info_nav_bar.dart';

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
      bottomNavigationBar: JobInfoNavBar(job: widget.job),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppPalette.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppPalette.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'JOB DETAILS',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppPalette.iconDefault,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Divider(),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'POSTED ON\n',
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(color: AppPalette.textSecondaryOnDark),
                          children: [
                            TextSpan(
                              text: formatAsDate(widget.job.createdAt),
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(
                                    color: AppPalette.textPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'COMPLETE BY\n',
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(color: AppPalette.textSecondaryOnDark),
                          children: [
                            TextSpan(
                              text: formatAsDate(widget.job.completeBy),
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(
                                    color: AppPalette.textPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'JOB TYPE\n',
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(color: AppPalette.textSecondaryOnDark),
                          children: [
                            TextSpan(
                              text: widget.job.jobType,
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(
                                    color: AppPalette.textPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  RichText(
                    text: TextSpan(
                      text: 'PAYOUT\n',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppPalette.textSecondaryOnDark,
                      ),
                      children: [
                        TextSpan(
                          text: formatAsCurrency(widget.job.payout),
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(
                                color: AppPalette.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppPalette.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppPalette.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'LOCATIONS',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppPalette.iconDefault,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Divider(),
                  SizedBox(height: 8),
                  if (widget.job.jobType == 'Delivery') ...[
                    RichText(
                      text: TextSpan(
                        text: 'PICKUP\n',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppPalette.textSecondaryOnDark,
                        ),
                        children: [
                          TextSpan(
                            text: widget.job.pickupLocation,
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(
                                  color: AppPalette.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                        text: 'DROPOFF\n',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppPalette.textSecondaryOnDark,
                        ),
                        children: [
                          TextSpan(
                            text: widget.job.dropoffLocation,
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(
                                  color: AppPalette.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  if (widget.job.jobType != 'Delivery') ...[
                    RichText(
                      text: TextSpan(
                        text: 'JOB LOCATION\n',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppPalette.textSecondaryOnDark,
                        ),
                        children: [
                          TextSpan(
                            text: widget.job.jobLocation,
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(
                                  color: AppPalette.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppPalette.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppPalette.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'DESCRIPTION',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppPalette.iconDefault,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Divider(),
                  SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      text: widget.job.description,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppPalette.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
