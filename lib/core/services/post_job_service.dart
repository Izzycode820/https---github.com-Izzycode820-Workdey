import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:workdey_frontend/core/models/job_model.dart';
import 'package:workdey_frontend/core/models/paginated_response.dart';
import 'package:workdey_frontend/core/models/post_job_model.dart';
import 'package:workdey_frontend/core/services/dio_exceptions.dart';

class PostJobService {
  final Dio _dio;

  PostJobService(this._dio);

   Future<Map<String, dynamic>> postJob(PostJob job) async {
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

 Future<PaginatedResponse<Job>> getPostedJobs({int page = 1}) async {
    try {
      final response = await _dio.get(
        '/api/v1/jobs/',
        queryParameters: {
          'posted_by_me': true,
          'page': page,
        },
        options: Options(
        validateStatus: (status) => status! < 500, // Accept 404 as valid
      ),
    );

    // Handle empty or invalid response structure
    if (response.statusCode == 404) {
      return PaginatedResponse<Job>(
        count: 0,
        results: [],
        next: null,
        previous: null,
      );
    } 
      return PaginatedResponse.fromJson(
        response.data as Map<String, dynamic>,
        (json) => Job.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      debugPrint('Error fetching posted jobs: ${e.message}');
      rethrow;
    }
  }

Future<void> updateJob(int jobId, PostJob job) async {
  try {
    await _dio.put(
      '/api/v1/jobs/$jobId/',
      data: job.toJson(),
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );
  } on DioException catch (e) {
    throw DioExceptions.fromDioError(e);
  }
}

  Future<void> deleteJob(int jobId) async {
    await _dio.delete('/api/v1/jobs/$jobId/');
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
