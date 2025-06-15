// lib/core/providers/get_worker_provider.dart
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/getworkers/get_workers_model.dart';
import 'package:workdey_frontend/core/models/paginated_response/paginated_response.dart';
import 'package:workdey_frontend/core/services/get_woker_service.dart';

class WorkersNotifier extends StateNotifier<AsyncValue<PaginatedResponse<Worker>>> {
  final WorkerService _service;
  int _currentPage = 1;
  bool _hasMore = true;

  WorkersNotifier(this._service) : super(const AsyncValue.loading()) {
    loadInitialWorkers();
  }
  
  bool get hasMore => _hasMore;

  Future<void> loadInitialWorkers({bool forceRefresh = false,
      String? category,
  }) async {
    _currentPage = 1;
    _hasMore = true;
    state = const AsyncValue<PaginatedResponse<Worker>>.loading();
    
    try {
      final workers = await _service.fetchWorkers(page: _currentPage, forceRefresh: forceRefresh, category: category,);
      state = AsyncValue<PaginatedResponse<Worker>>.data(workers);
    } catch (e, stack) {
      state = AsyncValue<PaginatedResponse<Worker>>.error(e, stack);
    }
  }

  Future<void> loadNextPage() async {
    if (!_hasMore || state.isLoading || state.value ==null) return;
    
    final currentData = state.value;
    if (currentData == null) return;

    try {
      state = AsyncValue<PaginatedResponse<Worker>>.loading()
          .copyWithPrevious(state);
      final newJobs = await _service.fetchWorkers(page: _currentPage + 1);
      
      if (newJobs.results.isEmpty) {
      // No more items - update state accordingly
      _hasMore = false;
      state = AsyncValue<PaginatedResponse<Worker>>.data(currentData); // Revert to previous state
      return;
    }

    // Successful load - update state
    _currentPage++;
    _hasMore = newJobs.next != null; // Update based on API response
    
    state = AsyncValue<PaginatedResponse<Worker>>.data(
      PaginatedResponse<Worker>(
        count: newJobs.count,
        results: [...currentData.results, ...newJobs.results],
        next: newJobs.next,
        previous: newJobs.previous,
      ),
    );
  } catch (e, stack) {
    debugPrint('Error loading next page: $e');
    // On error, revert to previous state but keep hasMore false
    _hasMore = false;
    state = AsyncValue<PaginatedResponse<Worker>>.error(e, stack).copyWithPrevious(state);
  }
}
Future<void> refreshJobs() async {
    await loadInitialWorkers(forceRefresh: true);
  }

}

final workersNotifierProvider = StateNotifierProvider<WorkersNotifier, AsyncValue<PaginatedResponse<Worker>>>((ref) {
  return WorkersNotifier(ref.read(workerServiceProvider));
});