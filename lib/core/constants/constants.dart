import 'package:flutter/cupertino.dart';
import 'package:pt_best/core/theme/app_palete.dart';

class Constants {
  static const List<String> jobType = ['Delivery', 'Cleaning', 'Repair'];
  static const Map<String, IconData> jobTypeIcons = {
    'Delivery': CupertinoIcons.car_fill,
    'Cleaning': CupertinoIcons.house_fill,
    'Repair': CupertinoIcons.wrench_fill,
  };

  static const Map<String, Color> jobTypeIconColors = {
    'Delivery': AppPalette.deliveryIcon,
    'Cleaning': AppPalette.cleaningIcon,
    'Repair': AppPalette.repairIcon,
  };

  static const Map<String, Color> jobTypeBgColors = {
    'Delivery': AppPalette.deliveryBg,
    'Cleaning': AppPalette.cleaningBg,
    'Repair': AppPalette.repairBg,
  };

  static const Map<String, Color> jobStatusBgColors = {
    'pending': AppPalette.pending,
    'accepted': AppPalette.accepted,
    'completed': AppPalette.completed,
  };
}
