import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/getworkers/get_workers_model.dart';
import 'package:workdey_frontend/core/models/paginated_response/paginated_response.dart';
import 'package:workdey_frontend/core/services/saved_workers_service.dart';


class SavedWorkersNotifier extends StateNotifier<AsyncValue<PaginatedResponse<Worker>>> {
  final SavedWorkersService _service;
  int _currentPage = 1;
  bool _hasMore = true;

  SavedWorkersNotifier(this._service) : super(const AsyncValue.loading()) {
    loadInitialWorkers();
  }

  bool get hasMore => _hasMore;

  Future<void> loadInitialWorkers({bool forceRefresh = false}) async {
    _currentPage = 1;
    _hasMore = true;
    state = const AsyncValue.loading();
    
    try {
      final workers = await _service.getSavedWorkers(page: _currentPage);
      state = AsyncValue<PaginatedResponse<Worker>>.data(workers);
    } catch (e, stack) {
      state = AsyncValue<PaginatedResponse<Worker>>.error(e, stack);
    }
  }

  Future<void> loadNextPage() async {
    if (!_hasMore || state.isLoading || state.value == null) return;
    
    final currentData = state.value!;
    
    try {
      state = AsyncValue<PaginatedResponse<Worker>>.loading()
          .copyWithPrevious(state);
      final newWorkers = await _service.getSavedWorkers(page: _currentPage + 1);
      
      if (newWorkers.results.isEmpty) {
        _hasMore = false;
        state = AsyncValue<PaginatedResponse<Worker>>.data(currentData);
        return;
      }

      _currentPage++;
      _hasMore = newWorkers.next != null;
      
      state = AsyncValue<PaginatedResponse<Worker>>.data(
        PaginatedResponse<Worker>(
          count: newWorkers.count,
          results: [...currentData.results, ...newWorkers.results],
          next: newWorkers.next,
          previous: newWorkers.previous,
        ),
      );
    } catch (e, stack) {
      _hasMore = false;
    state = AsyncValue<PaginatedResponse<Worker>>.error(e, stack).copyWithPrevious(state);
    }
  }

  Future<void> toggleSave(int workerId, bool currentlySaved) async {
    try {
      // Optimistic update
      final currentData = state.value;
      if (currentData != null) {
        final updatedWorkers = currentData.results.map((Worker) {
          if (Worker.id == workerId) {
            return Worker.copyWith(isSaved: !currentlySaved);
          }
          return Worker;
        }).toList();

        state = AsyncValue.data(
          PaginatedResponse<Worker>(
            count: currentData.count,
            results: updatedWorkers,
            next: currentData.next,
            previous: currentData.previous,
          ),
        );

        // API call
        if (currentlySaved) {
          await _service.unsaveworker(workerId);
        } else {
          await _service.saveworker(workerId);
        }
      }
    } catch (e) {
      loadInitialWorkers(); // Revert on error
      rethrow;
    }
  }

  Future<void> refresh() => loadInitialWorkers(forceRefresh: true);
}

final savedWorkersProvider = StateNotifierProvider<SavedWorkersNotifier, 
    AsyncValue<PaginatedResponse<Worker>>>((ref) {
  return SavedWorkersNotifier(ref.read(savedWorkersServiceProvider));
});