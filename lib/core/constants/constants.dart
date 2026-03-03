import 'package:flutter/cupertino.dart';

class Constants {
  static const List<String> jobType = ['Delivery', 'Cleaning', 'Repair'];
  static const Map<String, IconData> jobTypeIcons = {
    'Delivery': CupertinoIcons.car_fill,
    'Cleaning': CupertinoIcons.house_fill,
    'Repair': CupertinoIcons.wrench_fill,
  };
}
