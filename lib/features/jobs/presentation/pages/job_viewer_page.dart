import 'package:flutter/material.dart';
import 'package:pt_best/core/theme/app_palete.dart';

class JobViewerPage extends StatefulWidget {
  // ignore: strict_top_level_inference
  static route() =>
      MaterialPageRoute(builder: (context) => const JobViewerPage());
  const JobViewerPage({super.key});

  @override
  State<JobViewerPage> createState() => _JobViewerPageState();
}

class _JobViewerPageState extends State<JobViewerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(color: AppPalette.surfaceDark),
    );
  }
}
