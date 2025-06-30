import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';
import 'package:workdey_frontend/core/models/paginated_response/paginated_response.dart';
import 'package:workdey_frontend/core/services/connectivity_service.dart';
import 'package:workdey_frontend/core/services/get_job_service.dart';
import 'package:workdey_frontend/core/providers/providers.dart';

final jobServiceProvider = Provider<JobService>((ref) {
  return JobService(
    ref.read(dioProvider),
    ref.read(localCacheProvider), // Now including local cache
  );
});

final connectivityProvider = Provider<ConnectivityService>((ref) {
  return ConnectivityService();
});

class JobsNotifier extends StateNotifier<AsyncValue<PaginatedResponse<Job>>> {
  final JobService _service;
  int _currentPage = 1;
  bool _hasMore = true;
  String? _currentCity;
  String? _currentDistrict;

  String? get currentCity => _currentCity;
  String? get currentDistrict => _currentDistrict;

  JobsNotifier(this._service) : super(const AsyncValue.loading()) {
    loadInitialJobs();
  }
  
  bool get hasMore => _hasMore;
  
  Future<void> loadInitialJobs({bool forceRefresh = false}) async {
    _currentPage = 1;
    _hasMore = true;
    state = const AsyncValue<PaginatedResponse<Job>>.loading();
    
    try {
      final jobs = _currentCity == null
         ? await _service.fetchJobs(page: _currentPage, forceRefresh: forceRefresh)
         :await _service.fetchJobsByLocation(
              page: _currentPage,
              forceRefresh: forceRefresh,
              city: _currentCity,
              district: _currentDistrict,
            );
      state = AsyncValue<PaginatedResponse<Job>>.data(jobs);
    } catch (e, stack) {
      state = AsyncValue<PaginatedResponse<Job>>.error(e, stack);
    }
  }

  Future<void> loadNextPage() async {
    if (!_hasMore || state.isLoading || state.value ==null) return;
    
    final currentData = state.value;
    if (currentData == null) return;

    try {
      state = AsyncValue<PaginatedResponse<Job>>.loading()
          .copyWithPrevious(state);
      final newJobs = _currentCity == null
      ? await _service.fetchJobs(page: _currentPage + 1)
      : await _service.fetchJobsByLocation(
              page: _currentPage + 1,
              city: _currentCity,
              district: _currentDistrict,
            );
      
      if (newJobs.results.isEmpty) {
      // No more items - update state accordingly
      _hasMore = false;
      state = AsyncValue<PaginatedResponse<Job>>.data(currentData); // Revert to previous state
      return;
    }

    // Successful load - update state
    _currentPage++;
    _hasMore = newJobs.next != null; // Update based on API response
    
    state = AsyncValue<PaginatedResponse<Job>>.data(
      PaginatedResponse<Job>(
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
    state = AsyncValue<PaginatedResponse<Job>>.error(e, stack).copyWithPrevious(state);
  }
}

  Future<void> refreshJobs() async {
    await loadInitialJobs(forceRefresh: true);
  }

  Future<Job> getJobDetails(String jobId) async {
    try {
      return await _service.getJobDetails(jobId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> applyForJob(String jobId) async {
    try {
      await _service.applyForJob(jobId);
      // Update the job's applied status in the list
      final currentData = state.value?.results ?? [];
      final jobIndex = currentData.indexWhere((j) => j.id == jobId);
      if (jobIndex != -1) {
        state = AsyncValue<PaginatedResponse<Job>>.data(
          PaginatedResponse<Job>(
            count: state.value?.count ?? 0,
            results: [
              ...currentData.take(jobIndex),
              currentData[jobIndex].copyWith(hasApplied: true),
              ...currentData.skip(jobIndex + 1),
            ],
            next: state.value?.next,
            previous: state.value?.previous,
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> searchByLocation({String? city, String? district}) async {
    _currentCity = city;
    _currentDistrict = district;
    _currentPage = 1; // Reset pagination
    await loadInitialJobs(forceRefresh: true);
  }

  Future<void> loadInitialJobsByLocation({bool forceRefresh = false}) async {
    _currentPage = 1;
    _hasMore = true;
    state = const AsyncValue.loading();

    try {
      final jobs = await _service.fetchJobsByLocation(
        page: _currentPage,
        forceRefresh: forceRefresh,
        city: _currentCity, // Pass city to API
        district: _currentDistrict, // Pass district to API
      );
      state = AsyncValue.data(jobs);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

final jobsNotifierProvider = StateNotifierProvider<JobsNotifier, AsyncValue<PaginatedResponse<Job>>>((ref) {
  return JobsNotifier(ref.read(jobServiceProvider));
});

final jobDetailsProvider = FutureProvider.family<Job, String>((ref, jobId) async {
  return ref.read(jobServiceProvider).getJobDetails(jobId);
});