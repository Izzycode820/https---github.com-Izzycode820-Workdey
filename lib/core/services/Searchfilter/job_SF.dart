import 'package:dio/dio.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';
import 'package:workdey_frontend/features/search_filter/job_filter_enum.dart';

class JobSearchService {
  final Dio _dio;

  JobSearchService(this._dio);

  Future<List<Job>> search({
    String? query,
    JobCategory? category,
    JobType? jobType,
    String? location,
    List<String>? skills,
    List<WorkingDays>? workingDays,
    JobNature? jobNature,
    String? postedWithin,
    int page = 1,
  }) async {
    final params = {
      if (query != null) 'search': query,
      if (category != null) 'category': category.displayName.toUpperCase(),
      if (jobType != null) 'job_type': jobType.displayName,
      if (skills != null) 'skills[]': skills,
      if (location != null) 'location': location,
      if (workingDays != null) 'working_days[]': workingDays,
      if (jobNature != null) 'job_nature': jobNature.name,
      if (postedWithin != null) 'posted_within': postedWithin,
      'page': page,
    };

    final response = await _dio.get('/api/v1/job-search/', queryParameters: params);
  
   final data = response.data as Map<String, dynamic>;
  final results = data['results'] as List;
  
  return results.map((json) => Job.fromJson(json)).toList();
}
  
}