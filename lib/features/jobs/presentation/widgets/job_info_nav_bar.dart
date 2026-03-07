import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pt_best/core/common/entities/job.dart';
import 'package:pt_best/core/theme/app_palete.dart';
import 'package:pt_best/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pt_best/features/jobs/presentation/bloc/job_bloc.dart';
import 'package:pt_best/features/jobs/presentation/widgets/job_info_apply_button.dart';

class JobInfoNavBar extends StatelessWidget {
  final Job job;
  const JobInfoNavBar({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    void jobApply() {
      final authState = context.read<AuthBloc>().state;
      if (authState is! AuthSuccess) return;

      context.read<JobBloc>().add(
        JobApply(jobId: job.id, userId: authState.user.id),
      );
    }

    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(color: AppPalette.surface),
      child: SafeArea(
        child: JobInfoApplyButton(
          buttonText: 'Apply for this Job →',
          onPressed: jobApply,
        ),
      ),
    );
  }
}
