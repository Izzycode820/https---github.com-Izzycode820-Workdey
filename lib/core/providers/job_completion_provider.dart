// lib/core/providers/job_completion_provider.dart
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/providers/applicantion_provider.dart';
import 'package:workdey_frontend/core/providers/post_completion_review_provider.dart';
import 'package:workdey_frontend/core/services/job_completion_service.dart';

// ========== JOB COMPLETION PROVIDER ==========
final jobCompletionProvider = StateNotifierProvider<JobCompletionNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  return JobCompletionNotifier(ref.read(jobCompletionServiceProvider));
});

class JobCompletionNotifier extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  final JobCompletionService _jobCompletionService;
  
  JobCompletionNotifier(this._jobCompletionService) : super(const AsyncValue.data({}));

  /// Mark a job as complete
  Future<Map<String, dynamic>> markJobComplete({
    required int applicationId,
    DateTime? actualStartDate,
    required WidgetRef ref,
    DateTime? actualEndDate,
    int? finalPayment,
    String? completionNotes,
  }) async {
    try {
      state = const AsyncValue.loading();
      
      final result = await _jobCompletionService.markJobComplete(
        applicationId: applicationId,
        actualStartDate: actualStartDate,
        actualEndDate: actualEndDate,
        finalPayment: finalPayment,
        completionNotes: completionNotes,
      );
      ref.invalidate(myApplicationsProvider);
      ref.invalidate(jobApplicantsProvider);

      state = AsyncValue.data(result);
      return result;
    } catch (e, st) {
      debugPrint('❌ Mark job complete error: $e');
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  /// Confirm job completion
  Future<Map<String, dynamic>> confirmJobCompletion(int completionId) async {
    try {
      state = const AsyncValue.loading();
      
      final result = await _jobCompletionService.confirmJobCompletion(completionId);
      
      state = AsyncValue.data(result);
      return result;
    } catch (e, st) {
      debugPrint('❌ Confirm job completion error: $e');
      state = AsyncValue.error(e, st);
      rethrow;
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
      state = const AsyncValue.loading();
      
      final result = await _jobCompletionService.recordServiceCompletion(
        workerProfileId: workerProfileId,
        serviceDescription: serviceDescription,
        serviceDate: serviceDate,
        paymentAmount: paymentAmount,
        serviceNotes: serviceNotes,
      );
      
      state = AsyncValue.data(result);
      return result;
    } catch (e, st) {
      debugPrint('❌ Record service completion error: $e');
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  /// Confirm service completion
  Future<Map<String, dynamic>> confirmServiceCompletion(int serviceId) async {
    try {
      state = const AsyncValue.loading();
      
      final result = await _jobCompletionService.confirmServiceCompletion(serviceId);
      
      state = AsyncValue.data(result);
      return result;
    } catch (e, st) {
      debugPrint('❌ Confirm service completion error: $e');
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  void resetState() {
    state = const AsyncValue.data({});
  }
}

// ========== PENDING CONFIRMATIONS PROVIDER ==========
final pendingConfirmationsProvider = StateNotifierProvider<PendingConfirmationsNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  return PendingConfirmationsNotifier(ref.read(jobCompletionServiceProvider));
});

class PendingConfirmationsNotifier extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  final JobCompletionService _jobCompletionService;
  
  PendingConfirmationsNotifier(this._jobCompletionService) : super(const AsyncValue.loading()) {
    loadPendingConfirmations();
  }

  Future<void> loadPendingConfirmations() async {
    try {
      state = const AsyncValue.loading();
      final result = await _jobCompletionService.getPendingConfirmations();
      state = AsyncValue.data(result);
    } catch (e, st) {
      debugPrint('❌ Load pending confirmations error: $e');
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() => loadPendingConfirmations();

Future<void> retryFailedOperation() async {
  if (state.hasError) {
    await loadPendingConfirmations();
  }
}
}

// ========== CONVENIENCE PROVIDERS ==========

/// Get count of pending confirmations
final pendingConfirmationsCountProvider = Provider<int>((ref) {
  final pendingConfirmations = ref.watch(pendingConfirmationsProvider);
  return pendingConfirmations.value?['pending_count'] ?? 0;
});

/// Get list of pending completion items
final pendingCompletionItemsProvider = Provider<List<dynamic>>((ref) {
  final pendingConfirmations = ref.watch(pendingConfirmationsProvider);
  return pendingConfirmations.value?['completions'] ?? [];
});

/// Check if user has any pending confirmations
final hasPendingConfirmationsProvider = Provider<bool>((ref) {
  final count = ref.watch(pendingConfirmationsCountProvider);
  return count > 0;
});


// ========== APPLICATION INTEGRATION HELPERS ==========

/// Provider to check if specific application has pending completion
final applicationCompletionStatusProvider = Provider.family<String, int>((ref, applicationId) {
  final pendingItems = ref.watch(pendingCompletionItemsProvider);
  
  final relevantCompletion = pendingItems.cast<Map<String, dynamic>>().firstWhere(
    (completion) => completion['application']?['id'] == applicationId,
    orElse: () => <String, dynamic>{},
  );
  
  if (relevantCompletion.isEmpty) return 'none';
  
  final isEmployerConfirmed = relevantCompletion['employer_confirmed'] ?? false;
  final isWorkerConfirmed = relevantCompletion['worker_confirmed'] ?? false;
  
  if (isEmployerConfirmed && isWorkerConfirmed) return 'completed';
  if (isEmployerConfirmed && !isWorkerConfirmed) return 'pending_worker';
  if (!isEmployerConfirmed && isWorkerConfirmed) return 'pending_employer';
  return 'pending_both';
});

/// Provider to get completion ID for specific application
final applicationCompletionIdProvider = Provider.family<int?, int>((ref, applicationId) {
  final pendingItems = ref.watch(pendingCompletionItemsProvider);
  
  final relevantCompletion = pendingItems.cast<Map<String, dynamic>>().firstWhere(
    (completion) => completion['application']?['id'] == applicationId,
    orElse: () => <String, dynamic>{},
  );
  
  return relevantCompletion['id'] as int?;
});

// ========== BATCH OPERATIONS ==========

/// Helper to refresh all completion-related providers
void refreshAllCompletionProviders(WidgetRef ref) {
  ref.invalidate(pendingConfirmationsProvider);
  ref.invalidate(postCompletionReviewProvider);
  ref.invalidate(myApplicationsProvider);
}

/// Helper to handle completion success with full refresh
Future<void> handleCompletionSuccess(WidgetRef ref, {String? successMessage}) async {
  refreshAllCompletionProviders(ref);
  
  if (successMessage != null) {
    // This would be called from UI context
    debugPrint('✅ Completion success: $successMessage');
  }
}


// //Future Works
// // ========== NUDGE EMPLOYER PROVIDER ==========
// final nudgeEmployerProvider = StateNotifierProvider<NudgeEmployerNotifier, AsyncValue<void>>((ref) {
//   return NudgeEmployerNotifier();
// });

// class NudgeEmployerNotifier extends StateNotifier<AsyncValue<void>> {
//   NudgeEmployerNotifier() : super(const AsyncValue.data(null));

//   /// Send nudge to employer (placeholder implementation)
//   Future<void> sendNudge(int applicationId) async {
//     try {
//       state = const AsyncValue.loading();
      
//       // TODO: Implement actual nudge API call
//       // For now, simulate the action
//       await Future.delayed(const Duration(seconds: 1));
      
//       state = const AsyncValue.data(null);
//     } catch (e, st) {
//       state = AsyncValue.error(e, st);
//       rethrow;
//     }
//   }
// }