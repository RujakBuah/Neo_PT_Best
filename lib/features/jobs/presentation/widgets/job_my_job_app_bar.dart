import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pt_best/core/common/entities/job.dart';
import 'package:pt_best/core/theme/app_palete.dart';

class MyJobAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Job> jobs;
  const MyJobAppBar({super.key, required this.jobs});

  @override
  Size get preferredSize => const Size.fromHeight(250);

  @override
  Widget build(BuildContext context) {
    final pendingCount = jobs.where((j) => j.status == 'pending').length;
    final acceptedCount = jobs.where((j) => j.status == 'accepted').length;
    final completedCount = jobs.where((j) => j.status == 'completed').length;

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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Icon(
                        CupertinoIcons.person_crop_circle_fill,
                        color: AppPalette.iconDefault,
                        size: 50,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Icon(
                        CupertinoIcons.bell_circle_fill,
                        color: AppPalette.iconDefault,
                        size: 50,
                      ),
                    ),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    text: 'My ',
                    style: Theme.of(context).textTheme.displayLarge,
                    children: [
                      TextSpan(
                        text: 'Jobs.\n',
                        style: Theme.of(context).textTheme.displayLarge!
                            .copyWith(color: AppPalette.primary),
                        children: [
                          TextSpan(
                            text: 'Track your applications here',
                            style: Theme.of(context).textTheme.headlineSmall!
                                .copyWith(color: AppPalette.iconDefault),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    _StatChip(label: 'Pending', value: pendingCount),
                    _StatChip(label: 'Accepted', value: acceptedCount),
                    _StatChip(label: 'Completed', value: completedCount),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final int value;
  const _StatChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2C),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value.toString(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppPalette.primary,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w500,
                color: AppPalette.textSecondaryOnDark,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
