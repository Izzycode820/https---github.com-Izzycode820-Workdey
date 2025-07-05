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
  Future<List<Job>?> getCachedJobs();
  Future<void> clearJobsCache();
  Future<DateTime?> getLastUpdatedTime();
  Future<void> write<T>(String key, T value);
  Future<T?> read<T>(String key);
  Future<void> delete(String key);

  Future<void> set(String key, dynamic value, {Duration? duration});
  Future<dynamic> get(String key);
  Future<void> remove(String key);
}