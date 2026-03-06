// lib/core/utils/time_ago.dart

String timeAgo(DateTime dateTime) {
  final utc = dateTime.isUtc
      ? dateTime
      : DateTime.utc(
          dateTime.year,
          dateTime.month,
          dateTime.day,
          dateTime.hour,
          dateTime.minute,
          dateTime.second,
          dateTime.millisecond,
          dateTime.microsecond,
        );

  final difference = DateTime.now().toUtc().difference(utc);

  if (difference.inSeconds < 60) {
    return 'Just now';
  } else if (difference.inMinutes < 60) {
    final m = difference.inMinutes;
    return '$m ${m == 1 ? 'minute' : 'minutes'} ago';
  } else if (difference.inHours < 24) {
    final h = difference.inHours;
    return '$h ${h == 1 ? 'hour' : 'hours'} ago';
  } else if (difference.inDays < 30) {
    final d = difference.inDays;
    return '$d ${d == 1 ? 'day' : 'days'} ago';
  } else if (difference.inDays < 365) {
    final m = (difference.inDays / 30).floor();
    return '$m ${m == 1 ? 'month' : 'months'} ago';
  } else {
    final y = (difference.inDays / 365).floor();
    return '$y ${y == 1 ? 'year' : 'years'} ago';
  }
}
