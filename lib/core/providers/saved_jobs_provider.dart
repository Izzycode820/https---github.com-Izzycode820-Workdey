import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';
import 'package:workdey_frontend/core/models/paginated_response/paginated_response.dart';
import 'package:workdey_frontend/core/services/saved_jobs_service.dart';


class SavedJobsNotifier extends StateNotifier<AsyncValue<PaginatedResponse<Job>>> {
  final SavedJobsService _service;
  int _currentPage = 1;
  bool _hasMore = true;

  SavedJobsNotifier(this._service) : super(const AsyncValue.loading()) {
    loadInitialJobs();
  }

  bool get hasMore => _hasMore;

  Future<void> loadInitialJobs({bool forceRefresh = false}) async {
    _currentPage = 1;
    _hasMore = true;
    state = const AsyncValue.loading();
    
    try {
      final jobs = await _service.getSavedJobs(page: _currentPage);
      state = AsyncValue<PaginatedResponse<Job>>.data(jobs);
    } catch (e, stack) {
      state = AsyncValue<PaginatedResponse<Job>>.error(e, stack);
    }
  }

  Future<void> loadNextPage() async {
    if (!_hasMore || state.isLoading || state.value == null) return;
    
    final currentData = state.value!;
    
    try {
      state = AsyncValue<PaginatedResponse<Job>>.loading()
          .copyWithPrevious(state);
      final newJobs = await _service.getSavedJobs(page: _currentPage + 1);
      
      if (newJobs.results.isEmpty) {
        _hasMore = false;
        state = AsyncValue<PaginatedResponse<Job>>.data(currentData);
        return;
      }

      _currentPage++;
      _hasMore = newJobs.next != null;
      
      state = AsyncValue<PaginatedResponse<Job>>.data(
        PaginatedResponse<Job>(
          count: newJobs.count,
          results: [...currentData.results, ...newJobs.results],
          next: newJobs.next,
          previous: newJobs.previous,
        ),
      );
    } catch (e, stack) {
      _hasMore = false;
    state = AsyncValue<PaginatedResponse<Job>>.error(e, stack).copyWithPrevious(state);
    }
  }

  Future<void> toggleSave(int jobId, bool currentlySaved) async {
    try {
      // Optimistic update
      final currentData = state.value;
      if (currentData != null) {
        final updatedJobs = currentData.results.map((job) {
          if (job.id == jobId) {
            return job.copyWith(isSaved: !currentlySaved);
          }
          return job;
        }).toList();

        state = AsyncValue.data(
          PaginatedResponse<Job>(
            count: currentData.count,
            results: updatedJobs,
            next: currentData.next,
            previous: currentData.previous,
          ),
        );

        // API call
        if (currentlySaved) {
          await _service.unsaveJob(jobId);
        } else {
          await _service.saveJob(jobId);
        }
      }
    } catch (e) {
      loadInitialJobs(); // Revert on error
      rethrow;
    }
  }

  Future<void> refresh() => loadInitialJobs(forceRefresh: true);
}

final savedJobsProvider = StateNotifierProvider<SavedJobsNotifier, 
    AsyncValue<PaginatedResponse<Job>>>((ref) {
  return SavedJobsNotifier(ref.read(savedJobsServiceProvider));
});