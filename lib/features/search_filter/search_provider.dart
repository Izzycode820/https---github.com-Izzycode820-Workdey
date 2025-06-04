/*// features/search_filter/search_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/job_model.dart';
import 'package:workdey_frontend/core/providers/get_job_provider.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

// Changed to return AsyncValue<List<Job>>
final filteredJobsProvider = Provider<AsyncValue<List<Job>>>((ref) {
  final jobsAsync = ref.watch(jobsProvider); // This should be a FutureProvider
  final query = ref.watch(searchQueryProvider);

  return jobsAsync.whenData((jobs) => 
    jobs.where((job) =>
      job.title.toLowerCase().contains(query.toLowerCase()) ||
      job.location.toLowerCase().contains(query.toLowerCase())
    ).toList()
  );
});
*/