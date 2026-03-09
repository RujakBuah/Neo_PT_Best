import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pt_best/core/common/widgets/loader.dart';
import 'package:pt_best/core/constants/constants.dart';
import 'package:pt_best/core/theme/app_palete.dart';
import 'package:pt_best/core/utils/show_snackbar.dart';
import 'package:pt_best/features/jobs/presentation/bloc/job_bloc.dart';
import 'package:pt_best/features/jobs/presentation/widgets/add_job_app_bar.dart';
import 'package:pt_best/features/jobs/presentation/widgets/job_editor.dart';
import 'package:pt_best/features/jobs/presentation/widgets/job_gradient_button.dart';

class AddJobPage extends StatefulWidget {
  const AddJobPage({super.key});

  @override
  State<AddJobPage> createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  String jobType = 'Delivery';
  final titleController = TextEditingController();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final payoutController = TextEditingController();
  DateTime? selectedDate;
  final pickupLocationController = TextEditingController();
  final dropOffLocationController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final jobLocationController = TextEditingController();

  void uploadDeliveryJob() {
    if (formKey.currentState!.validate() && selectedDate != null) {
      context.read<JobBloc>().add(
        JobUpload(
          title: titleController.text.trim(),
          description: descriptionController.text.trim(),
          payout: int.parse(payoutController.text.trim()),
          jobType: jobType,
          companyName: nameController.text.trim(),
          pickupLocation: pickupLocationController.text.trim(),
          dropoffLocation: dropOffLocationController.text.trim(),
          completeBy: selectedDate!,
        ),
      );
    }
  }

  void uploadOtherJob() {
    if (formKey.currentState!.validate() && selectedDate != null) {
      context.read<JobBloc>().add(
        JobUpload(
          title: titleController.text.trim(),
          description: descriptionController.text.trim(),
          payout: int.parse(payoutController.text.trim()),
          jobType: jobType,
          companyName: nameController.text.trim(),
          completeBy: selectedDate!,
          jobLocation: jobLocationController.text.trim(),
        ),
      );
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    nameController.dispose();
    pickupLocationController.dispose();
    dropOffLocationController.dispose();
    jobLocationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AddJobAppBar(),
      body: BlocConsumer<JobBloc, JobState>(
        listener: (context, state) {
          if (state is JobFailure) {
            showSnackBar(context, state.error);
          } else if (state is JobUploadSuccess) {
            context.go('/');
          }
        },
        builder: (context, state) {
          if (state is JobLoading) {
            return const Loader();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    jobSelectType(),
                    const SizedBox(height: 10),
                    Text(
                      'JOB TITLE',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppPalette.iconDefault,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    JobEditor(
                      controller: titleController,
                      hintText: 'e.g. Delivery to Asep Tambal Ban',
                      input: 'Job Title',
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'COMPANY / YOUR NAME',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppPalette.iconDefault,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    JobEditor(
                      controller: nameController,
                      hintText: 'PT Worst',
                      input: 'Company Name',
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'JOB DESCRIPTION',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppPalette.iconDefault,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    JobEditor(
                      controller: descriptionController,
                      hintText:
                          'Describe the task, item details, weight, dimensions, etc.',
                      input: 'Description',
                    ),
                    const SizedBox(height: 10),
                    jobPayoutDate(context),
                    const SizedBox(height: 10),
                    if (jobType == 'Delivery') ...[
                      Text(
                        'PICKUP LOCATION',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppPalette.iconDefault,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      JobEditor(
                        controller: pickupLocationController,
                        hintText: 'Kos Agriya Living, Gamping, Sleman',
                        input: 'Pickup Location',
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'DROPOFF LOCATION',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppPalette.iconDefault,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      JobEditor(
                        controller: dropOffLocationController,
                        hintText: 'Kec. Pogung, Sleman',
                        input: 'Dropoff Location',
                      ),
                    ],
                    if (jobType != 'Delivery') ...[
                      Text(
                        'JOB LOCATION',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppPalette.iconDefault,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      JobEditor(
                        controller: jobLocationController,
                        hintText: 'Kos Agriya Living, Gamping, Sleman',
                        input: 'Job Location',
                      ),
                    ],
                    SizedBox(height: 15),
                    JobGradientButton(
                      buttonText: 'Post Job →',
                      onPressed: () {
                        if (jobType == 'Delivery') {
                          uploadDeliveryJob();
                        } else {
                          uploadOtherJob();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Row jobPayoutDate(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PAYOUT (RP)',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppPalette.iconDefault,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              JobEditor(
                controller: payoutController,
                hintText: '100000',
                input: 'Payout',
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'COMPLETE BY',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppPalette.iconDefault,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: _pickDate,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: AppPalette.surface,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppPalette.border, width: 1.5),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          CupertinoIcons.calendar,
                          color: AppPalette.iconDefault,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          selectedDate != null
                              ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                              : 'Select a date',
                          style: TextStyle(
                            color: selectedDate == null
                                ? AppPalette.textHint
                                : Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row jobSelectType() {
    return Row(
      children: Constants.jobType
          .map(
            (e) => Padding(
              padding: const EdgeInsets.all(5.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    jobType = e;
                  });
                },
                child: Container(
                  height: 80,
                  width: 115,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: jobType == e
                          ? AppPalette.primary
                          : AppPalette.border,
                      width: 1.5,
                    ),
                    color: AppPalette.surface,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Constants.jobTypeIcons[e],
                        size: 25,
                        color: jobType == e
                            ? AppPalette.primary
                            : AppPalette.textSecondary,
                      ),
                      Text(
                        e,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: jobType == e
                              ? AppPalette.primary
                              : AppPalette.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
