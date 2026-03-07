import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pt_best/core/common/entities/job.dart';
import 'package:pt_best/core/constants/constants.dart';
import 'package:pt_best/core/theme/app_palete.dart';
import 'package:pt_best/core/utils/capitilize_first_letter.dart';
import 'package:pt_best/core/utils/count_time_ago.dart';
import 'package:pt_best/core/utils/format_number.dart';
import 'package:pt_best/core/utils/insert_new_line.dart';

class JobInfoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Job job;
  const JobInfoAppBar({super.key, required this.job});

  @override
  Size get preferredSize => const Size.fromHeight(250);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppPalette.surfaceDark),
      child: Stack(
        children: [
          Positioned(
            right: -40,
            top: 80,
            child: Container(
              width: 180,
              height: 180,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Color(0x2900BFA5), // ~16% opacity teal
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    context.go('/');
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppPalette.inputBorder,
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 20,
                      color: AppPalette.inputFillLight,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text:
                            'Posted by ${job.postedBy} ◦ ${timeAgo(job.createdAt)}\n',
                        style: Theme.of(context).textTheme.headlineSmall!
                            .copyWith(color: AppPalette.iconDefault),
                        children: [
                          TextSpan(
                            text: insertNewlines(job.title, 2),
                            style: Theme.of(context).textTheme.headlineLarge!
                                .copyWith(
                                  color: AppPalette.inputFillLight,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(
                        8.0,
                      ).copyWith(left: 16, right: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Constants.jobTypeBgColors[job.jobType],
                      ),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            text: job.jobType,
                            style: Theme.of(context).textTheme.labelLarge!
                                .copyWith(
                                  color:
                                      Constants.jobTypeIconColors[job.jobType],
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.all(
                        8.0,
                      ).copyWith(left: 16, right: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Constants.jobStatusBgColors[job.status],
                      ),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            text: capitilize(job.status),
                            style: Theme.of(context).textTheme.labelLarge!
                                .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    text: formatAsCurrency(job.payout),
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: AppPalette.primaryDark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
