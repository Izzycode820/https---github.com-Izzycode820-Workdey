import 'package:dio/dio.dart';
import 'package:workdey_frontend/core/models/post_job_model.dart';

class PostJobService {
  final Dio _dio;

  PostJobService(this._dio);

   Future<void> postJob(PostJob job) async {
  try {
    final response = await _dio.post(
      '/api/v1/jobs/',
      data: job.toJson(),
      options: Options(
        validateStatus: (status) => status! < 500,
      ),
    );
    
    if (response.statusCode == 201) {
      return response.data;
    } else if (response.statusCode == 403) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: response.data['error'] ?? 'Verification level too low',
      );
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: response.data['error'] ?? 'Failed to post job',
      );
    }
  } on DioException catch (e) {
    rethrow;
  }
}

 Future<List<PostJob>> getPostedJobs() async {
    try {
      final response = await _dio.get('/api/v1/jobs/');
      return (response.data as List)
          .map((json) => PostJob.fromJson(json))
          .toList();
    } on DioException {
      return []; // Return empty list on error
    }
  }
}

 /* Map<String, dynamic> _formatJobData(PostJob job) {
    return {
      'job_type': job.jobType,
      'title': job.title,
      'category': job.category,
      'location': job.location,
      'description': job.description,
      'roles_description': job.rolesDescription,
      'requirements': job.requirements,
      'working_days': job.workingDays,
      'due_date': job.dueDate?.toIso8601String(),
      'job_nature': job.jobNature,
      'type_specific': job.typeSpecific,
      // verification_required is handled backend-side
    };
  }*/
