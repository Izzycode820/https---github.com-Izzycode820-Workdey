// providers/post_worker_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/getworkers/get_workers_model.dart';
import 'package:workdey_frontend/core/models/paginated_response/paginated_response.dart';
import 'package:workdey_frontend/core/models/postworker/post_worker_model.dart';
import 'package:workdey_frontend/core/providers/providers.dart';
import 'package:workdey_frontend/core/services/post_worker_service.dart';

final postWorkerServiceProvider = Provider((ref) {
  final dio = ref.read(dioProvider);
  return PostWorkerService(dio);
});

final postWorkerNotifierProvider = StateNotifierProvider.autoDispose<PostWorkerNotifier, PostWorker>((ref) {
  return PostWorkerNotifier(ref.read(postWorkerServiceProvider));
});

class PostWorkerNotifier extends StateNotifier<PostWorker> {
  final PostWorkerService _service;
  
  PostWorkerNotifier(this._service) : super(PostWorker(
    title: '',
    category: 'CONSTRUCTION',
    location: '',
    skills: [],
    bio: '',
    availability: 'FT',
    experienceYears: 0,
  ));

  void updateField(String field, dynamic value) {
    state = state.copyWith(
      title: field == 'title' ? value : state.title,
      category: field == 'category' ? value : state.category,
      location: field == 'location' ? value : state.location,
      bio: field == 'bio' ? value : state.bio,
      availability: field == 'availability' ? value : state.availability,
      experienceYears: field == 'experienceYears' ? value : state.experienceYears,
      portfolioLink: field == 'portfolioLink' ? value : state.portfolioLink,
    );
  }

  void addSkill(String skill) {
    if (skill.isNotEmpty) {
      state = state.copyWith(skills: [...state.skills, skill]);
    }
  }

  void removeSkill(String skill) {
    state = state.copyWith(
      skills: state.skills.where((s) => s != skill).toList(),
    );
  }

  Future<void> submitWorker({required int? workerId}) async {
    if (workerId != null) {
      await _service.updateWorker(workerId, state);
    } else {
      await _service.postWorker(state);
    }
  }
}

final myWorkersProvider = StateNotifierProvider<MyWorkersNotifier, AsyncValue<PaginatedResponse<Worker>>>((ref) {
  return MyWorkersNotifier(ref.read(postWorkerServiceProvider));
});

class MyWorkersNotifier extends StateNotifier<AsyncValue<PaginatedResponse<Worker>>> {
  final PostWorkerService _service;
  int _currentPage = 1;
  bool _hasMore = true;

  MyWorkersNotifier(this._service) : super(const AsyncValue.loading()) {
    loadWorkers();
  }
 bool get hasMore => _hasMore;

  Future<void> loadWorkers({bool forceRefresh = false}) async {
    _currentPage = 1;
    _hasMore = true;
    state = const AsyncValue.loading();

    try {
      final workers = await _service.getMyWorkerscard(page: _currentPage);
      state = AsyncValue.data(workers);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
  Future<void> loadNextPage() async {
    if (!_hasMore || state.isLoading || state.value == null) return;
    
    final currentData = state.value;
    if (currentData == null) return;

    try {
      state = AsyncValue<PaginatedResponse<Worker>>.loading()
          .copyWithPrevious(state);
      final newWorkers = await _service.getMyWorkerscard(page: _currentPage + 1);
      
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
    debugPrint('Error loading next page: $e');
    // On error, revert to previous state but keep hasMore false
    _hasMore = false;
    state = AsyncValue<PaginatedResponse<Worker>>.error(e, stack).copyWithPrevious(state);
  }
}

  Future<void> refreshWorker() async {
    await loadWorkers(forceRefresh: true);
  }

  Future<void> deleteWorker(int workerId) async {
    try {
      await _service.deleteWorker(workerId);
      if (state.value != null) {
        final currentData = state.value!;
        state = AsyncValue<PaginatedResponse<Worker>>.data(
          PaginatedResponse<Worker>(
            count: currentData.count - 1,
            results: currentData.results.where((worker) => worker.id != workerId).toList(),
            next: currentData.next,
            previous: currentData.previous,
          ),
        );
      }
    } catch (e) {
      throw Exception('Failed to delete worker: ${e.toString()}');
    }
  }
}