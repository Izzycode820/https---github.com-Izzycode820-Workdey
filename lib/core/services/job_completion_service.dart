// lib/core/services/job_completion/job_completion_service.dart
import 'package:dio/dio.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';

class JobCompletionService {
  final Dio _dio;
  
  JobCompletionService(this._dio);

  /// Mark job as complete
  Future<Map<String, dynamic>> markJobComplete({
    required int applicationId,
    DateTime? actualStartDate,
    DateTime? actualEndDate,
    int? finalPayment,
    String? completionNotes,
  }) async {
    try {
      final response = await _dio.post(
        '/api/v1/job-completions/mark-complete/',
        data: {
          'application_id': applicationId,
          if (actualStartDate != null) 'actual_start_date': actualStartDate.toIso8601String().split('T')[0],
          if (actualEndDate != null) 'actual_end_date': actualEndDate.toIso8601String().split('T')[0],
          if (finalPayment != null) 'final_payment': finalPayment,
          if (completionNotes != null) 'completion_notes': completionNotes,
        },
      );
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// Confirm job completion
  Future<Map<String, dynamic>> confirmJobCompletion(int completionId) async {
    try {
      final response = await _dio.post(
        '/api/v1/job-completions/$completionId/confirm/',
      );
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// Get pending job confirmations
  Future<Map<String, dynamic>> getPendingConfirmations() async {
    try {
      final response = await _dio.get('/api/v1/job-completions/pending_confirmations/');
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// Get jobs that need reviews (completed but not reviewed)
  Future<List<Map<String, dynamic>>> getJobsNeedingReview() async {
    try {
      // Get pending confirmations first
      final pendingResponse = await getPendingConfirmations();
      final completions = pendingResponse['completions'] as List<dynamic>;
      
      // Filter for mutually confirmed jobs
      final needingReview = completions
          .where((completion) => 
              completion['is_mutually_confirmed'] == true &&
              completion['can_confirm']['can_review'] == true)
          .map((completion) => {
            'completion_id': completion['id'],
            'application_id': completion['application']['id'],
            'job': completion['application']['job'],
            'user_role': _getUserRole(completion),
            'completed_at': completion['created_at'],
          })
          .toList();
      
      return needingReview.cast<Map<String, dynamic>>();
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// Record service completion
  Future<Map<String, dynamic>> recordServiceCompletion({
    required int workerProfileId,
    required String serviceDescription,
    required DateTime serviceDate,
    required double paymentAmount,
    String? serviceNotes,
  }) async {
    try {
      final response = await _dio.post(
        '/api/v1/service-completions/record/',
        data: {
          'worker_profile_id': workerProfileId,
          'service_description': serviceDescription,
          'service_date': serviceDate.toIso8601String().split('T')[0],
          'payment_amount': paymentAmount,
          if (serviceNotes != null) 'service_notes': serviceNotes,
        },
      );
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// Confirm service completion
  Future<Map<String, dynamic>> confirmServiceCompletion(int serviceId) async {
    try {
      final response = await _dio.post(
        '/api/v1/service-completions/$serviceId/confirm/',
      );
      return response.data;
    } catch (e) {
      throw _handleError(e);
    }
  }

  String _getUserRole(Map<String, dynamic> completion) {
    // This would need to be determined based on the current user
    // For now, returning a placeholder - you'll need to implement this logic
    return 'employer'; // or 'worker'
  }

  Exception _handleError(dynamic error) {
    if (error is DioException) {
      final message = error.response?.data?['error'] ?? 
                     error.response?.data?['message'] ?? 
                     'Job completion operation failed';
      return Exception(message);
    }
    return Exception('Network error occurred');
  }
}