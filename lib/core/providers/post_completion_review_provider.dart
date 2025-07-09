import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';
import 'package:workdey_frontend/core/providers/providers.dart';
import 'package:workdey_frontend/core/services/job_completion_service.dart';

// ========== SERVICE PROVIDER ==========
final jobCompletionServiceProvider = Provider<JobCompletionService>((ref) {
  return JobCompletionService(ref.read(dioProvider));
});

// ========== POST-COMPLETION REVIEW PROVIDER ==========

/// Provider for tracking completed jobs that need reviews
final postCompletionReviewProvider = StateNotifierProvider<PostCompletionReviewNotifier, AsyncValue<List<Map<String, dynamic>>>>((ref) {
  return PostCompletionReviewNotifier(ref.read(jobCompletionServiceProvider));
});

class PostCompletionReviewNotifier extends StateNotifier<AsyncValue<List<Map<String, dynamic>>>> {
  final JobCompletionService _jobCompletionService;
  
  PostCompletionReviewNotifier(this._jobCompletionService) : super(const AsyncValue.data([])) {
    _loadPendingReviews();
  }

  /// Load jobs that have been completed but haven't been reviewed yet
  Future<void> _loadPendingReviews() async {
    try {
      state = const AsyncValue.loading();
      
      // Fetch completed jobs that need reviews from backend
      final pendingReviews = await _jobCompletionService.getJobsNeedingReview();
      
      // Transform the data to match our expected format
      final transformedReviews = pendingReviews.map((item) => {
        'job': Job.fromJson(item['job']),
        'application_id': item['application_id'],
        'completion_id': item['completion_id'],
        'user_role': item['user_role'],
        'completed_at': item['completed_at'],
        'review_deadline': DateTime.parse(item['completed_at'])
            .add(const Duration(days: 7))
            .toIso8601String(),
      }).toList();
      
      state = AsyncValue.data(transformedReviews);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Add a completed job that needs review
  void addPendingReview({
    required Job job,
    required int applicationId,
    required String userRole, // 'employer' or 'worker'
    DateTime? completedAt,
  }) {
    final currentReviews = state.value ?? [];
    
    // Check if this job+role combination already exists
    final exists = currentReviews.any((review) => 
      review['job'].id == job.id && 
      review['user_role'] == userRole
    );
    
    if (!exists) {
      final newReview = {
        'job': job,
        'application_id': applicationId,
        'user_role': userRole,
        'completed_at': (completedAt ?? DateTime.now()).toIso8601String(),
        'review_deadline': DateTime.now().add(const Duration(days: 7)).toIso8601String(),
      };
      
      state = AsyncValue.data([...currentReviews, newReview]);
    }
  }

  /// Remove a pending review (after user submits review or dismisses)
  void removePendingReview({
    required int jobId,
    required String userRole,
  }) {
    final currentReviews = state.value ?? [];
    final updatedReviews = currentReviews.where((review) => 
      !(review['job'].id == jobId && review['user_role'] == userRole)
    ).toList();
    
    state = AsyncValue.data(updatedReviews);
  }

  /// Mark a review as completed
  void markReviewCompleted({
    required int jobId,
    required String userRole,
  }) {
    removePendingReview(jobId: jobId, userRole: userRole);
  }

  /// Get pending reviews for a specific user role
  List<Map<String, dynamic>> getPendingReviewsForRole(String userRole) {
    final currentReviews = state.value ?? [];
    return currentReviews.where((review) => review['user_role'] == userRole).toList();
  }

  /// Get pending reviews count
  int getPendingReviewsCount() {
    return state.value?.length ?? 0;
  }

  /// Check if a specific job needs review
  bool needsReview({required int jobId, required String userRole}) {
    final currentReviews = state.value ?? [];
    return currentReviews.any((review) => 
      review['job'].id == jobId && review['user_role'] == userRole
    );
  }

  /// Refresh pending reviews from backend
  Future<void> refresh() async {
    await _loadPendingReviews();
  }

  /// Clear all pending reviews (for testing or logout)
  void clearAll() {
    state = const AsyncValue.data([]);
  }
}

// ========== HELPER PROVIDERS ==========

/// Get total pending reviews count
final pendingReviewsCountProvider = Provider<int>((ref) {
  final pendingReviews = ref.watch(postCompletionReviewProvider);
  return pendingReviews.value?.length ?? 0;
});

/// Get pending reviews for employers only
final employerPendingReviewsProvider = Provider<List<Map<String, dynamic>>>((ref) {
  final pendingReviews = ref.watch(postCompletionReviewProvider);
  return pendingReviews.value?.where((review) => review['user_role'] == 'employer').toList() ?? [];
});

/// Get pending reviews for workers only
final workerPendingReviewsProvider = Provider<List<Map<String, dynamic>>>((ref) {
  final pendingReviews = ref.watch(postCompletionReviewProvider);
  return pendingReviews.value?.where((review) => review['user_role'] == 'worker').toList() ?? [];
});

/// Check if there are any urgent pending reviews (close to deadline)
final urgentPendingReviewsProvider = Provider<List<Map<String, dynamic>>>((ref) {
  final pendingReviews = ref.watch(postCompletionReviewProvider);
  final now = DateTime.now();
  
  return pendingReviews.value?.where((review) {
    final deadline = DateTime.parse(review['review_deadline']);
    final daysUntilDeadline = deadline.difference(now).inDays;
    return daysUntilDeadline <= 2; // Urgent if deadline is within 2 days
  }).toList() ?? [];
});

/// Get the next review deadline
final nextReviewDeadlineProvider = Provider<DateTime?>((ref) {
  final pendingReviews = ref.watch(postCompletionReviewProvider);
  if (pendingReviews.value?.isEmpty ?? true) return null;
  
  final deadlines = pendingReviews.value!
      .map((review) => DateTime.parse(review['review_deadline']))
      .toList();
  
  deadlines.sort();
  return deadlines.first;
});

/// Check if user has pending reviews
final hasPendingReviewsProvider = Provider<bool>((ref) {
  final pendingReviews = ref.watch(postCompletionReviewProvider);
  return pendingReviews.value?.isNotEmpty ?? false;
});