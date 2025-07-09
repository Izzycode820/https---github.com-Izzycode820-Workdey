import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/applicant/applicant_model.dart';
import 'package:workdey_frontend/core/providers/providers.dart';
import 'package:workdey_frontend/core/services/applicant_service.dart';

// FIXED: Keep the service provider as is
final applicationServiceProvider = Provider((ref) {
  final dio = ref.read(dioProvider);
  return ApplicantService(dio);
});

final applicantServiceProvider = Provider((ref) {
  final dio = ref.read(dioProvider);
  return ApplicantService(dio);
});

// FIXED: Convert from FutureProvider to StateNotifierProvider for better refresh control
final myApplicationsProvider = StateNotifierProvider<MyApplicationsNotifier, AsyncValue<List<Application>>>((ref) {
  return MyApplicationsNotifier(ref.read(applicantServiceProvider));
});

class MyApplicationsNotifier extends StateNotifier<AsyncValue<List<Application>>> {
  final ApplicantService _service;
  
  MyApplicationsNotifier(this._service) : super(const AsyncValue.loading()) {
    // FIXED: Auto-load on initialization
    loadApplications();
  }
  
  // FIXED: Robust loading with proper error handling
  Future<void> loadApplications() async {
    try {
      // Set loading state
      state = const AsyncValue.loading();
      
      // Make API call
      final applications = await _service.getMyApplications();
      
      // Update state with data
      state = AsyncValue.data(applications);
      
    } catch (error, stackTrace) {
      // FIXED: Proper error handling with stack trace
      state = AsyncValue.error(error, stackTrace);
    }
  }
  
  // FIXED: Public refresh method for UI calls
  Future<void> refresh() async {
    await loadApplications();
  }
  
  // FIXED: Force refresh method for pull-to-refresh
  Future<void> forceRefresh() async {
    // Don't show loading state for force refresh to avoid UI flicker
    try {
      final applications = await _service.getMyApplications();
      state = AsyncValue.data(applications);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
  
  // FIXED: Helper method to get applications by status
  List<Application> getApplicationsByStatus(String status) {
    return state.maybeWhen(
      data: (applications) => applications.where((app) => app.status == status).toList(),
      orElse: () => [],
    );
  }
  
  // FIXED: Helper method to get applications count
  int getApplicationsCount() {
    return state.maybeWhen(
      data: (applications) => applications.length,
      orElse: () => 0,
    );
  }
  
  // FIXED: Helper method to check if has applications
  bool get hasApplications {
    return state.maybeWhen(
      data: (applications) => applications.isNotEmpty,
      orElse: () => false,
    );
  }
}

// FIXED: Keep the job applicants provider but update it to match the corrected model
final jobApplicantsProvider = FutureProvider.family<List<Application>, int>((ref, jobId) {
  return ref.read(applicantServiceProvider).getJobApplicants(jobId);
});

// FIXED: Add convenience providers for common use cases
final pendingApplicationsProvider = Provider<List<Application>>((ref) {
  final myApplications = ref.watch(myApplicationsProvider);
  return myApplications.maybeWhen(
    data: (applications) => applications.where((app) => app.status == 'PENDING').toList(),
    orElse: () => [],
  );
});

final approvedApplicationsProvider = Provider<List<Application>>((ref) {
  final myApplications = ref.watch(myApplicationsProvider);
  return myApplications.maybeWhen(
    data: (applications) => applications.where((app) => app.status == 'APPROVED').toList(),
    orElse: () => [],
  );
});

final completedApplicationsProvider = Provider<List<Application>>((ref) {
  final myApplications = ref.watch(myApplicationsProvider);
  return myApplications.maybeWhen(
    data: (applications) => applications.where((app) => app.status == 'COMPLETED').toList(),
    orElse: () => [],
  );
});

// FIXED: Provider for applications requiring action
final actionRequiredApplicationsProvider = Provider<List<Application>>((ref) {
  final myApplications = ref.watch(myApplicationsProvider);
  return myApplications.maybeWhen(
    data: (applications) => applications.where((app) => app.needsAction).toList(),
    orElse: () => [],
  );
});

// FIXED: Provider for application stats
final applicationStatsProvider = Provider<Map<String, int>>((ref) {
  final myApplications = ref.watch(myApplicationsProvider);
  return myApplications.maybeWhen(
    data: (applications) {
      final stats = <String, int>{
        'total': applications.length,
        'pending': 0,
        'approved': 0,
        'rejected': 0,
        'completed': 0,
        'needsAction': 0,
      };
      
      for (final app in applications) {
        switch (app.status) {
          case 'PENDING':
            stats['pending'] = (stats['pending'] ?? 0) + 1;
            break;
          case 'APPROVED':
            stats['approved'] = (stats['approved'] ?? 0) + 1;
            break;
          case 'REJECTED':
            stats['rejected'] = (stats['rejected'] ?? 0) + 1;
            break;
          case 'COMPLETED':
            stats['completed'] = (stats['completed'] ?? 0) + 1;
            break;
        }
        
        if (app.needsAction) {
          stats['needsAction'] = (stats['needsAction'] ?? 0) + 1;
        }
      }
      
      return stats;
    },
    orElse: () => {
      'total': 0,
      'pending': 0,
      'approved': 0,
      'rejected': 0,
      'completed': 0,
      'needsAction': 0,
    },
  );
});