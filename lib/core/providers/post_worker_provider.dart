import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/enums/form_mode.dart';
import 'package:workdey_frontend/core/models/getworkers/get_workers_model.dart';
import 'package:workdey_frontend/core/models/paginated_response/paginated_response.dart';
import 'package:workdey_frontend/core/models/postworker/post_worker_model.dart';
import 'package:workdey_frontend/core/providers/providers.dart';
import 'package:workdey_frontend/core/services/post_worker_service.dart';

// ============================================================================
// CLEAN WORKER FORM STATE - Professional state management
// ============================================================================

@immutable
class WorkerFormState {
  final PostWorker worker;
  final FormMode mode;
  final bool isLoading;
  final bool isValid;
  final Map<String, String> errors;
  final int? editingWorkerId;

  const WorkerFormState({
    required this.worker,
    required this.mode,
    this.isLoading = false,
    this.isValid = false,
    this.errors = const {},
    this.editingWorkerId,
  });

  WorkerFormState copyWith({
    PostWorker? worker,
    FormMode? mode,
    bool? isLoading,
    bool? isValid,
    Map<String, String>? errors,
    int? editingWorkerId,
  }) {
    return WorkerFormState(
      worker: worker ?? this.worker,
      mode: mode ?? this.mode,
      isLoading: isLoading ?? this.isLoading,
      isValid: isValid ?? this.isValid,
      errors: errors ?? this.errors,
      editingWorkerId: editingWorkerId ?? this.editingWorkerId,
    );
  }

  // Clean initialization from existing worker (no primitive extensions)
  factory WorkerFormState.fromExistingWorker(Worker existingWorker) {
    return WorkerFormState(
      worker: PostWorker(
        title: existingWorker.title,
        category: existingWorker.category,
        location: existingWorker.location,
        skills: existingWorker.skills ?? [],
        bio: existingWorker.bio ?? '',
        availability: existingWorker.availability ?? 'FT',
        experienceYears: existingWorker.experienceYears ?? 0,
        portfolioLink: existingWorker.portfolioLink,
      ),
      mode: FormMode.edit,
      editingWorkerId: existingWorker.id,
    );
  }

  // Clean default state for new worker
  factory WorkerFormState.newWorker() {
    return WorkerFormState(
      worker: const PostWorker(
        title: '',
        category: 'CONSTRUCTION',
        location: '',
        skills: [],
        bio: '',
        availability: 'FT',
        experienceYears: 0,
      ),
      mode: FormMode.create,
    );
  }
}

// ============================================================================
// CLEAN WORKER FORM NOTIFIER - Professional logic
// ============================================================================

class WorkerFormNotifier extends StateNotifier<WorkerFormState> {
  final PostWorkerService _service;
  final Ref _ref;

  WorkerFormNotifier(this._service, this._ref) : super(WorkerFormState.newWorker());

  // Clean initialization methods
  void initializeForCreate() {
    state = WorkerFormState.newWorker();
  }

  void initializeForEdit(Worker existingWorker) {
    state = WorkerFormState.fromExistingWorker(existingWorker);
  }

  // Clean unified update method - no more primitive field-by-field updates
  void updateWorkerData({
    String? title,
    String? category,
    String? location,
    String? bio,
    String? availability,
    int? experienceYears,
    String? portfolioLink,
    List<String>? skills,
  }) {
    _updateWorker(state.worker.copyWith(
      title: title ?? state.worker.title,
      category: category ?? state.worker.category,
      location: location ?? state.worker.location,
      bio: bio ?? state.worker.bio,
      availability: availability ?? state.worker.availability,
      experienceYears: experienceYears ?? state.worker.experienceYears,
      portfolioLink: portfolioLink ?? state.worker.portfolioLink,
      skills: skills ?? state.worker.skills,
    ));
  }

  // Clean skill management
  void addSkill(String skill) {
    if (skill.trim().isEmpty || state.worker.skills.contains(skill.trim())) return;
    
    final updatedSkills = [...state.worker.skills, skill.trim()];
    _updateWorker(state.worker.copyWith(skills: updatedSkills));
  }

  void removeSkill(String skill) {
    final updatedSkills = state.worker.skills.where((s) => s != skill).toList();
    _updateWorker(state.worker.copyWith(skills: updatedSkills));
  }

  // Clean validation and state update
  void _updateWorker(PostWorker updatedWorker) {
    final errors = _validateWorker(updatedWorker);
    final isValid = errors.isEmpty;
    
    state = state.copyWith(
      worker: updatedWorker,
      errors: errors,
      isValid: isValid,
    );
  }

  Map<String, String> _validateWorker(PostWorker worker) {
    final errors = <String, String>{};
    
    if (worker.title.trim().isEmpty) {
      errors['title'] = 'Worker title is required';
    }
    
    if (worker.category.trim().isEmpty) {
      errors['category'] = 'Category is required';
    }
    
    if (worker.location.trim().isEmpty) {
      errors['location'] = 'Location is required';
    }
    
    if (worker.bio?.trim().isEmpty == true) {
      errors['bio'] = 'Bio/description is required';
    }
    
    if (worker.skills.isEmpty) {
      errors['skills'] = 'At least one skill is required';
    }
    
    if (worker.experienceYears == null || worker.experienceYears! < 0) {
      errors['experienceYears'] = 'Valid experience years required';
    }
    
    return errors;
  }

  // Clean submission
  Future<bool> submitWorker() async {
    if (!state.isValid) {
      return false;
    }
    
    state = state.copyWith(isLoading: true);
    
    try {
      if (state.mode == FormMode.edit && state.editingWorkerId != null) {
        await _service.updateWorker(state.editingWorkerId!, state.worker);
      } else {
        await _service.postWorker(state.worker);
      }
      
      // Refresh the posted workers list
      _ref.read(postedWorkersProvider.notifier).refreshWorkers();
      
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errors: {'submit': e.toString().replaceAll('Exception: ', '')},
      );
      return false;
    }
  }

  // Clean reset
  void reset() {
    state = WorkerFormState.newWorker();
  }
}

// ============================================================================
// CLEAN POSTED WORKERS PROVIDER - Professional pagination
// ============================================================================

class PostedWorkersNotifier extends StateNotifier<AsyncValue<PaginatedResponse<Worker>>> {
  final PostWorkerService _service;
  int _currentPage = 1;
  bool _hasMore = true;

  PostedWorkersNotifier(this._service) : super(const AsyncValue.loading()) {
    loadInitialWorkers();
  }

  bool get hasMore => _hasMore;

  Future<void> loadInitialWorkers({bool forceRefresh = false}) async {
    _currentPage = 1;
    _hasMore = true;
    state = const AsyncValue.loading();
    
    try {
      final workers = await _service.getMyWorkers(page: _currentPage);
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
      final newWorkers = await _service.getMyWorkers(page: _currentPage + 1);
      
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
      _hasMore = false;
      state = AsyncValue<PaginatedResponse<Worker>>.error(e, stack).copyWithPrevious(state);
    }
  }

  Future<void> refreshWorkers() async {
    await loadInitialWorkers(forceRefresh: true);
  }

  Future<void> removeWorker(int workerId) async {
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
    } on DioException catch (e) {
      throw Exception('Failed to delete worker: ${e.message}');
    }
  }
}

// ============================================================================
// CLEAN PROVIDERS - Professional setup
// ============================================================================

final postWorkerServiceProvider = Provider<PostWorkerService>((ref) {
  return PostWorkerService(ref.read(dioProvider));
});

final workerFormNotifierProvider = StateNotifierProvider<WorkerFormNotifier, WorkerFormState>((ref) {
  return WorkerFormNotifier(ref.read(postWorkerServiceProvider), ref);
});

final postedWorkersProvider = StateNotifierProvider<PostedWorkersNotifier, AsyncValue<PaginatedResponse<Worker>>>((ref) {
  return PostedWorkersNotifier(ref.read(postWorkerServiceProvider));
});

// Helper provider for backward compatibility
final myWorkersProvider = postedWorkersProvider;