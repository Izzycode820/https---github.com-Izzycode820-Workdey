import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/enums/form_mode.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';
import 'package:workdey_frontend/core/providers/post_job_provider.dart';
import 'package:workdey_frontend/screens/postjob_form.dart';




class EditJobScreen extends StatelessWidget {
  final Job job;
  const EditJobScreen({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    // final ref = ProviderScope.containerOf(context);
    // ref.read(postJobNotifierProvider.notifier).updateJob(job.toPostJob());
    return PostJobForm(
      mode: FormMode.edit,
      initialData: job.toPostJob(),
    );
  }
}