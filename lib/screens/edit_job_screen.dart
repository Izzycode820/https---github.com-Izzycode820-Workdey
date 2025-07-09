import 'package:flutter/material.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';
import 'package:workdey_frontend/screens/postjob_form.dart';

// ============================================================================
// CLEAN EDIT JOB SCREEN - No more primitive extensions or manual conversions
// ============================================================================

class CleanEditJobScreen extends StatelessWidget {
  final Job job;
  
  const CleanEditJobScreen({
    super.key,
    required this.job,
  });

  @override
  Widget build(BuildContext context) {
    // Clean and simple - just pass the job directly to the form
    // No more primitive job.toPostJob() extensions!
    return CleanJobForm(existingJob: job);
  }
}