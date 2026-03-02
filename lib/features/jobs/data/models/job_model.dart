import 'package:pt_best/core/common/entities/job.dart';

class JobModel extends Job {
  JobModel({
    required super.id,
    required super.createdAt,
    required super.title,
    required super.description,
    required super.payout,
    required super.jobType,
    required super.postedBy,
    super.assignedTo,
    required super.companyName,
    super.pickupLocation,
    super.dropoffLocation,
    required super.status,
    required super.completeBy,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'title': title,
      'description': description,
      'payout': payout,
      'job_type': jobType,
      'posted_by': postedBy,
      'assigned_to': assignedTo,
      'company_name': companyName,
      'pickup_location': pickupLocation,
      'dropoff_location': dropoffLocation,
      'status': status,
      'complete_by': completeBy.toIso8601String(),
    };
  }

  factory JobModel.fromJson(Map<String, dynamic> map) {
    return JobModel(
      id: map['id'] as String,
      createdAt: DateTime.parse(map['created_at']),
      title: map['title'] as String,
      description: map['description'] as String,
      payout: map['payout'] as int,
      jobType: map['job_type'] as String,
      postedBy: map['posted_by'] as String,
      assignedTo: map['assigned_to'] as String?,
      companyName: map['company_name'] as String,
      pickupLocation: map['pickup_location'] as String?,
      dropoffLocation: map['dropoff_location'] as String?,
      status: map['status'] as String,
      completeBy: DateTime.parse(map['complete_by']),
    );
  }

  JobModel copyWith({
    String? id,
    DateTime? createdAt,
    String? title,
    String? description,
    int? payout,
    String? jobType,
    String? postedBy,
    Object? assignedTo = const _Unset(),
    String? companyName,
    Object? pickupLocation = const _Unset(),
    Object? dropoffLocation = const _Unset(),
    String? status,
    DateTime? completeBy,
  }) {
    return JobModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      title: title ?? this.title,
      description: description ?? this.description,
      payout: payout ?? this.payout,
      jobType: jobType ?? this.jobType,
      postedBy: postedBy ?? this.postedBy,
      assignedTo: assignedTo is _Unset
          ? this.assignedTo
          : assignedTo as String?,
      companyName: companyName ?? this.companyName,
      pickupLocation: pickupLocation is _Unset
          ? this.pickupLocation
          : pickupLocation as String?,
      dropoffLocation: dropoffLocation is _Unset
          ? this.dropoffLocation
          : dropoffLocation as String?,
      status: status ?? this.status,
      completeBy: completeBy ?? this.completeBy,
    );
  }
}

class _Unset {
  const _Unset();
}
