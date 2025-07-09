// lib/core/providers/activity_state_provider.dart - FIXED REVIEWS INTEGRATION
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/applicant/applicant_model.dart';
import 'package:workdey_frontend/core/providers/saved_jobs_provider.dart';
import 'package:workdey_frontend/core/providers/saved_worker_provider.dart';
import 'package:workdey_frontend/core/providers/applicantion_provider.dart';
import 'package:workdey_frontend/core/providers/post_completion_review_provider.dart';
import 'package:workdey_frontend/core/providers/review_provider.dart';

// ========== ACTIVITY CENTER MODELS ==========

class ActivityCenterState {
  final ActivityTabState savedJobs;
  final ActivityTabState applications;
  final ActivityTabState reviews;
  final ActivityTabState savedWorkers;
  final DateTime lastRefresh;

  const ActivityCenterState({
    required this.savedJobs,
    required this.applications,
    required this.reviews,
    required this.savedWorkers,
    required this.lastRefresh,
  });

  ActivityCenterState copyWith({
    ActivityTabState? savedJobs,
    ActivityTabState? applications,
    ActivityTabState? reviews,
    ActivityTabState? savedWorkers,
    DateTime? lastRefresh,
  }) {
    return ActivityCenterState(
      savedJobs: savedJobs ?? this.savedJobs,
      applications: applications ?? this.applications,
      reviews: reviews ?? this.reviews,
      savedWorkers: savedWorkers ?? this.savedWorkers,
      lastRefresh: lastRefresh ?? this.lastRefresh,
    );
  }

  // Computed properties
  int get totalSavedJobs => savedJobs.count;
  int get totalApplications => applications.count;
  int get pendingReviews => reviews.count;
  int get totalSavedWorkers => savedWorkers.count;
  
  bool get hasAnyData => totalSavedJobs > 0 || totalApplications > 0 || 
                        pendingReviews > 0 || totalSavedWorkers > 0;
  
  bool get hasActionItems => pendingReviews > 0 || 
                            _getApprovedApplicationsCount() > 0 ||
                            _getInProgressApplicationsCount() > 0;

  int _getApprovedApplicationsCount() {
    if (applications.data != null && applications.data is List<Application>) {
      return (applications.data as List<Application>)
          .where((app) => app.status == 'APPROVED')
          .length;
    }
    return 0;
  }

  int _getInProgressApplicationsCount() {
    if (applications.data != null && applications.data is List<Application>) {
      return (applications.data as List<Application>)
          .where((app) => app.completion != null && !app.completion!.isMutuallyConfirmed)
          .length;
    }
    return 0;
  }
}

class ActivityTabState {
  final ActivityTabStatus status;
  final dynamic data;
  final String? errorMessage;
  final int count;
  final DateTime? lastUpdated;

  const ActivityTabState({
    required this.status,
    this.data,
    this.errorMessage,
    this.count = 0,
    this.lastUpdated,
  });

  ActivityTabState copyWith({
    ActivityTabStatus? status,
    dynamic data,
    String? errorMessage,
    int? count,
    DateTime? lastUpdated,
  }) {
    return ActivityTabState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage,
      count: count ?? this.count,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  bool get isLoading => status == ActivityTabStatus.loading;
  bool get hasError => status == ActivityTabStatus.error;
  bool get hasData => status == ActivityTabStatus.success && data != null;
  bool get isEmpty => status == ActivityTabStatus.empty;
}

enum ActivityTabStatus {
  initial,
  loading,
  success,
  empty,
  error,
}

// ========== ACTIVITY CENTER PROVIDER ==========

final activityCenterProvider = StateNotifierProvider<ActivityCenterNotifier, ActivityCenterState>((ref) {
  return ActivityCenterNotifier(ref);
});

class ActivityCenterNotifier extends StateNotifier<ActivityCenterState> {
  final Ref _ref;

  ActivityCenterNotifier(this._ref) : super(
    ActivityCenterState(
      savedJobs: const ActivityTabState(status: ActivityTabStatus.initial),
      applications: const ActivityTabState(status: ActivityTabStatus.initial),
      reviews: const ActivityTabState(status: ActivityTabStatus.initial),
      savedWorkers: const ActivityTabState(status: ActivityTabStatus.initial),
      lastRefresh: DateTime.now(),
    ),
  ) {
    // Auto-load data when initialized
    loadAllData();
  }

  // ========== MAIN METHODS ==========

  Future<void> loadAllData() async {
    debugPrint('🔄 ActivityCenter: Loading all data');
    
    // Load all tabs in parallel with error isolation
    await Future.wait([
      _loadSavedJobs(),
      _loadApplications(),
      _loadReviews(),
      _loadSavedWorkers(),
    ]);

    _updateLastRefresh();
  }

  Future<void> refreshAllData() async {
    debugPrint('🔄 ActivityCenter: Refreshing all data');
    
    // Reset all tabs to loading
    state = state.copyWith(
      savedJobs: state.savedJobs.copyWith(status: ActivityTabStatus.loading),
      applications: state.applications.copyWith(status: ActivityTabStatus.loading),
      reviews: state.reviews.copyWith(status: ActivityTabStatus.loading),
      savedWorkers: state.savedWorkers.copyWith(status: ActivityTabStatus.loading),
    );

    await loadAllData();
  }

  Future<void> refreshSingleTab(ActivityTab tab) async {
    debugPrint('🔄 ActivityCenter: Refreshing ${tab.name}');
    
    switch (tab) {
      case ActivityTab.savedJobs:
        await _loadSavedJobs();
        break;
      case ActivityTab.applications:
        await _loadApplications();
        break;
      case ActivityTab.reviews:
        await _loadReviews();
        break;
      case ActivityTab.savedWorkers:
        await _loadSavedWorkers();
        break;
    }
    
    _updateLastRefresh();
  }

  // ========== INDIVIDUAL TAB LOADERS ==========

  Future<void> _loadSavedJobs() async {
    try {
      state = state.copyWith(
        savedJobs: state.savedJobs.copyWith(status: ActivityTabStatus.loading),
      );

      final savedJobsNotifier = _ref.read(savedJobsProvider.notifier);
      await savedJobsNotifier.loadInitialJobs(forceRefresh: true);
      
      final savedJobsAsync = _ref.read(savedJobsProvider);
      
      savedJobsAsync.when(
        data: (paginatedJobs) {
          if (paginatedJobs.results.isEmpty) {
            state = state.copyWith(
              savedJobs: const ActivityTabState(
                status: ActivityTabStatus.empty,
                count: 0,
              ).copyWith(lastUpdated: DateTime.now()),
            );
          } else {
            state = state.copyWith(
              savedJobs: ActivityTabState(
                status: ActivityTabStatus.success,
                data: paginatedJobs,
                count: paginatedJobs.results.length,
                lastUpdated: DateTime.now(),
              ),
            );
          }
          debugPrint('✅ ActivityCenter: Saved jobs loaded (${paginatedJobs.results.length} items)');
        },
        loading: () {
          // Keep loading state
        },
        error: (error, stackTrace) {
          debugPrint('❌ ActivityCenter: Saved jobs error: $error');
          state = state.copyWith(
            savedJobs: ActivityTabState(
              status: ActivityTabStatus.error,
              errorMessage: _getErrorMessage(error),
              count: 0,
              lastUpdated: DateTime.now(),
            ),
          );
        },
      );
      
    } catch (e, stackTrace) {
      debugPrint('❌ ActivityCenter: Saved jobs error: $e');
      
      state = state.copyWith(
        savedJobs: ActivityTabState(
          status: ActivityTabStatus.error,
          errorMessage: _getErrorMessage(e),
          count: 0,
          lastUpdated: DateTime.now(),
        ),
      );
    }
  }

  Future<void> _loadApplications() async {
    try {
      state = state.copyWith(
        applications: state.applications.copyWith(status: ActivityTabStatus.loading),
      );

      // Force refresh the applications provider
      await _ref.read(myApplicationsProvider.notifier).refresh();
      
      // Watch the current state
      final applicationsAsync = _ref.read(myApplicationsProvider);
      
      applicationsAsync.when(
        data: (applications) {
          if (applications.isEmpty) {
            state = state.copyWith(
              applications: const ActivityTabState(
                status: ActivityTabStatus.empty,
                count: 0,
              ).copyWith(lastUpdated: DateTime.now()),
            );
          } else {
            state = state.copyWith(
              applications: ActivityTabState(
                status: ActivityTabStatus.success,
                data: applications,
                count: applications.length,
                lastUpdated: DateTime.now(),
              ),
            );
          }
          debugPrint('✅ ActivityCenter: Applications loaded (${applications.length} items)');
        },
        loading: () {
          // Keep loading state
          debugPrint('🔄 ActivityCenter: Applications still loading...');
        },
        error: (error, stackTrace) {
          debugPrint('❌ ActivityCenter: Applications error: $error');
          state = state.copyWith(
            applications: ActivityTabState(
              status: ActivityTabStatus.error,
              errorMessage: _getErrorMessage(error),
              count: 0,
              lastUpdated: DateTime.now(),
            ),
          );
        },
      );
      
    } catch (e, stackTrace) {
      debugPrint('❌ ActivityCenter: Applications error: $e');
      debugPrint('Stack trace: $stackTrace');
      
      state = state.copyWith(
        applications: ActivityTabState(
          status: ActivityTabStatus.error,
          errorMessage: _getErrorMessage(e),
          count: 0,
          lastUpdated: DateTime.now(),
        ),
      );
    }
  }

  // ========== FIXED REVIEW LOADING ==========
  Future<void> _loadReviews() async {
    try {
      state = state.copyWith(
        reviews: state.reviews.copyWith(status: ActivityTabStatus.loading),
      );

      // FIXED: Load pending reviews and total review count separately
      final pendingReviewsAsync = _ref.read(postCompletionReviewProvider);
      final totalReviewsCount = _ref.read(totalReviewsCountProvider);
      
      // Get pending reviews count
      final pendingCount = pendingReviewsAsync.maybeWhen(
        data: (pendingReviews) => pendingReviews.length,
        orElse: () => 0,
      );
      
      // FIXED: Use pending reviews as primary activity indicator
      final reviewActivityData = pendingReviewsAsync.maybeWhen(
        data: (pendingReviews) => pendingReviews,
        orElse: () => <Map<String, dynamic>>[],
      );
      
      debugPrint('🔍 ActivityCenter Reviews Debug:');
      debugPrint('  - Pending reviews: $pendingCount');
      debugPrint('  - Total reviews received: $totalReviewsCount');
      debugPrint('  - Review activity data: ${reviewActivityData.length} items');
      
      // FIXED: Reviews tab shows pending reviews (action items)
      if (pendingCount == 0) {
        state = state.copyWith(
          reviews: const ActivityTabState(
            status: ActivityTabStatus.empty,
            count: 0,
          ).copyWith(lastUpdated: DateTime.now()),
        );
      } else {
        state = state.copyWith(
          reviews: ActivityTabState(
            status: ActivityTabStatus.success,
            data: reviewActivityData, // Pending reviews for action
            count: pendingCount, // Badge shows pending count
            lastUpdated: DateTime.now(),
          ),
        );
      }
      
      debugPrint('✅ ActivityCenter: Reviews loaded ($pendingCount pending reviews)');
      
    } catch (e, stackTrace) {
      debugPrint('❌ ActivityCenter: Reviews error: $e');
      debugPrint('Stack trace: $stackTrace'); 
      
      // For reviews, treat errors as empty state since it's not critical
      state = state.copyWith(
        reviews: ActivityTabState(
          status: ActivityTabStatus.empty,
          errorMessage: 'Review system temporarily unavailable',
          count: 0,
          lastUpdated: DateTime.now(),
        ),
      );
    }
  }

  Future<void> _loadSavedWorkers() async {
    try {
      state = state.copyWith(
        savedWorkers: state.savedWorkers.copyWith(status: ActivityTabStatus.loading),
      );

      final savedWorkersNotifier = _ref.read(savedWorkersProvider.notifier);
      await savedWorkersNotifier.loadInitialWorkers(forceRefresh: true);
      
      final savedWorkersAsync = _ref.read(savedWorkersProvider);
      
      savedWorkersAsync.when(
        data: (paginatedWorkers) {
          if (paginatedWorkers.results.isEmpty) {
            state = state.copyWith(
              savedWorkers: const ActivityTabState(
                status: ActivityTabStatus.empty,
                count: 0,
              ).copyWith(lastUpdated: DateTime.now()),
            );
          } else {
            state = state.copyWith(
              savedWorkers: ActivityTabState(
                status: ActivityTabStatus.success,
                data: paginatedWorkers,
                count: paginatedWorkers.results.length,
                lastUpdated: DateTime.now(),
              ),
            );
          }
          debugPrint('✅ ActivityCenter: Saved workers loaded (${paginatedWorkers.results.length} items)');
        },
        loading: () {
          // Keep loading state
        },
        error: (error, stackTrace) {
          debugPrint('❌ ActivityCenter: Saved workers error: $error');
          state = state.copyWith(
            savedWorkers: ActivityTabState(
              status: ActivityTabStatus.error,
              errorMessage: _getErrorMessage(error),
              count: 0,
              lastUpdated: DateTime.now(),
            ),
          );
        },
      );
      
    } catch (e, stackTrace) {
      debugPrint('❌ ActivityCenter: Saved workers error: $e');
      
      state = state.copyWith(
        savedWorkers: ActivityTabState(
          status: ActivityTabStatus.error,
          errorMessage: _getErrorMessage(e),
          count: 0,
          lastUpdated: DateTime.now(),
        ),
      );
    }
  }

  // ========== HELPER METHODS ==========

  void _updateLastRefresh() {
    state = state.copyWith(lastRefresh: DateTime.now());
  }

  String _getErrorMessage(dynamic error) {
    if (error.toString().contains('404')) {
      return 'Service temporarily unavailable';
    } else if (error.toString().contains('Network')) {
      return 'Network connection error';
    } else if (error.toString().contains('timeout')) {
      return 'Request timeout - please try again';
    }
    return 'Something went wrong';
  }

  // ========== INDIVIDUAL TAB ACTIONS ==========

  Future<void> toggleJobSave(int jobId, bool currentlySaved) async {
    try {
      await _ref.read(savedJobsProvider.notifier).toggleSave(jobId, currentlySaved);
      await _loadSavedJobs();
    } catch (e) {
      debugPrint('❌ ActivityCenter: Toggle job save error: $e');
    }
  }

  Future<void> toggleWorkerSave(int workerId, bool currentlySaved) async {
    try {
      await _ref.read(savedWorkersProvider.notifier).toggleSave(workerId, currentlySaved);
      await _loadSavedWorkers();
    } catch (e) {
      debugPrint('❌ ActivityCenter: Toggle worker save error: $e');
    }
  }

  // ========== FIXED REVIEW-SPECIFIC ACTIONS ==========
  
  Future<void> refreshReviewData() async {
    debugPrint('🔄 ActivityCenter: Refreshing review data specifically');
    
    // FIXED: Refresh both review providers
    await Future.wait([
      _ref.read(postCompletionReviewProvider.notifier).refresh(),
      _ref.read(reviewsReceivedProvider.notifier).forceRefresh(),
    ]);
    
    // Reload review tab
    await _loadReviews();
  }

  Future<void> markReviewCompleted(int jobId, String userRole) async {
    try {
      // Mark the review as completed in the pending reviews provider
      _ref.read(postCompletionReviewProvider.notifier).markReviewCompleted(
        jobId: jobId,
        userRole: userRole,
      );
      
      // Refresh review data
      await refreshReviewData();
      
    } catch (e) {
      debugPrint('❌ ActivityCenter: Mark review completed error: $e');
    }
  }

  Future<void> refreshApplicationData() async {
    debugPrint('🔄 ActivityCenter: Refreshing application data specifically');
    
    // Refresh applications provider
    await _ref.read(myApplicationsProvider.notifier).refresh();
    
    // Reload applications tab
    await _loadApplications();
  }
}

// ========== CONVENIENCE PROVIDERS ==========

enum ActivityTab {
  savedJobs,
  applications,
  reviews,
  savedWorkers,
}

// Individual tab state providers for easy access
final savedJobsTabProvider = Provider<ActivityTabState>((ref) {
  return ref.watch(activityCenterProvider).savedJobs;
});

final applicationsTabProvider = Provider<ActivityTabState>((ref) {
  return ref.watch(activityCenterProvider).applications;
});

final reviewsTabProvider = Provider<ActivityTabState>((ref) {
  return ref.watch(activityCenterProvider).reviews;
});

final savedWorkersTabProvider = Provider<ActivityTabState>((ref) {
  return ref.watch(activityCenterProvider).savedWorkers;
});

// Summary providers
final activitySummaryProvider = Provider<Map<String, int>>((ref) {
  final state = ref.watch(activityCenterProvider);
  return {
    'savedJobs': state.totalSavedJobs,
    'applications': state.totalApplications,
    'reviews': state.pendingReviews,
    'savedWorkers': state.totalSavedWorkers,
  };
});

final hasActionItemsProvider = Provider<bool>((ref) {
  return ref.watch(activityCenterProvider).hasActionItems;
});

final lastRefreshTimeProvider = Provider<DateTime>((ref) {
  return ref.watch(activityCenterProvider).lastRefresh;
});

// ========== FIXED REVIEW-SPECIFIC PROVIDERS ==========

/// Provider to get comprehensive review activity data
final reviewActivityDataProvider = Provider<Map<String, dynamic>>((ref) {
  final pendingReviews = ref.watch(postCompletionReviewProvider);
  final reviewsReceived = ref.watch(reviewsReceivedProvider);
  final reviewsGiven = ref.watch(reviewsGivenProvider);

  return {
    'pendingReviews': pendingReviews.value ?? [],
    'receivedReviews': reviewsReceived.value,
    'givenReviews': reviewsGiven.value,
    'pendingCount': (pendingReviews.value ?? []).length,
    'receivedCount': reviewsReceived.value?.summary.totalReviews ?? 0,
    'givenCount': reviewsGiven.value?.summary.totalReviews ?? 0,
  };
});

/// Provider to check if user has urgent review deadlines
final urgentReviewDeadlinesProvider = Provider<List<Map<String, dynamic>>>((ref) {
  final pendingReviews = ref.watch(postCompletionReviewProvider);
  final urgentReviews = ref.watch(urgentPendingReviewsProvider);
  
  return urgentReviews;
});

/// Extension for enum display name
extension ActivityTabExtension on ActivityTab {
  String get name {
    switch (this) {
      case ActivityTab.savedJobs:
        return 'Saved Jobs';
      case ActivityTab.applications:
        return 'Applications';
      case ActivityTab.reviews:
        return 'Reviews';
      case ActivityTab.savedWorkers:
        return 'Saved Workers';
    }
  }
}