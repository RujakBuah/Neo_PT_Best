class Job {
  final String id;
  final DateTime createdAt;
  final String title;
  final String description;
  final int payout;
  final String jobType;
  final String postedBy;
  final String? assignedTo;
  final String companyName;
  final String? pickupLocation;
  final String? dropoffLocation;
  final String status;
  final DateTime completeBy;

  Job({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.description,
    required this.payout,
    required this.jobType,
    required this.postedBy,
    this.assignedTo,
    required this.companyName,
    this.pickupLocation,
    this.dropoffLocation,
    required this.status,
    required this.completeBy,
  });
}
