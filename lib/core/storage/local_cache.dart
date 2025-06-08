import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';

abstract class LocalCache {
  Future<List<Job>?> getJobs({
    String? searchQuery,
    Map<String, dynamic>? filters,
    int? page,
  });
  
  Future<void> saveJobs(
    List<Job> jobs, {
    String? searchQuery,
    Map<String, dynamic>? filters,
    int? page,
  });
  
  Future<Job?> getJobDetails(String jobId);
  Future<void> saveJobDetails(Job job);
  Future<void> invalidateJobApplications();
  Future<void> invalidateSavedJobs();
  
  // New methods
  Future<List<Job>?> getCachedJobs();
  Future<void> clearJobsCache();
  Future<DateTime?> getLastUpdatedTime();
}