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
    try{

    final params = <String, dynamic>{
      if (query != null) 'search': query,
      if (category != null) 'category': category.displayName.toUpperCase(),
      if (jobType != null) 'job_type': jobType.displayName,
      if (location != null) 'location': location,
      if (jobNature != null) 'job_nature': jobNature.name,
      if (postedWithin != null) 'posted_within': postedWithin,
      'page': page,
    };

// Handle skills array
  if (skills != null && skills.isNotEmpty) {
    for (final skill in skills) {
      params['skills[]'] = skill;
    }
  }

  // Handle working days array - THIS IS THE KEY FIX
  if (workingDays != null && workingDays.isNotEmpty) {
    for (final day in workingDays) {
      params['working_days[]'] = day.paramValue; // Use the string value
    }
  }
  
    final response = await _dio.get('/api/v1/job-search/', queryParameters: 
    params,);

    // Handle 404 for pagination
    if (response.statusCode == 404 && page > 1) {
      return [];
    }
  
   final data = response.data as Map<String, dynamic>;
    if (data['results'] == null) return [];
    
    return (data['results'] as List).map((json) => Job.fromJson(json)).toList();
  } on DioException catch (e) {
    if (e.response?.statusCode == 404 && page > 1) {
      return []; // No more pages available
    }
    rethrow;
  }
  }}