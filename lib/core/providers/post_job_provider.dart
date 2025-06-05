import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/enums/form_mode.dart';
import 'package:workdey_frontend/core/models/job_model.dart';
import 'package:workdey_frontend/core/models/paginated_response.dart';
import 'package:workdey_frontend/core/models/post_job_model.dart';
import 'package:workdey_frontend/core/providers/providers.dart';
import 'package:workdey_frontend/core/services/post_job_service.dart';

//Post job form
final postJobNotifierProvider = StateNotifierProvider.autoDispose<PostJobNotifier, PostJob>((ref) {
    return PostJobNotifier(ref.read(postJobServiceProvider),
    ref,
    );
});

class PostJobNotifier extends StateNotifier<PostJob> {
  final PostJobService _postJobService;
  final Ref _ref;
  
  PostJobNotifier(this._postJobService, this._ref) : super(PostJob(
    jobType: 'LOC',
    title: '',
    job_nature: 'Full time',
    category: 'IT',
    location: '',
    description: '',
    typeSpecific: {'salary_period': 'm', 'compensation_toggle': false},
  ));

  void updateJobType(String type) {
  final Map<String, dynamic> newTypeSpecific = {}; // Explicitly typed
  if (type == 'PRO' || type == 'LOC') {
    newTypeSpecific['salary'] = null;
    newTypeSpecific['salary_period'] = 'd';
  } else {
    newTypeSpecific['compensation_toggle'] = false;
  }
  state = state.copyWith(jobType: type, typeSpecific: newTypeSpecific);
}

  void updateField(String field, dynamic value) {
    state = state.copyWith(
      title: field == 'title' ? value : state.title,
      category: field == 'category' ? value : state.category,
      location: field == 'location' ? value : state.location,
      description: field == 'description' ? value : state.description,
      rolesDescription: field == 'rolesDescription' ? value : state.rolesDescription,
      requirements: field == 'requirements' ? value : state.requirements,
      workingDays: field == 'workingDays' ? value : state.workingDays,
      dueDate: field == 'dueDate' ? value : state.dueDate,
      job_nature: field == 'job_nature' ? value : state.job_nature,
    );
  }

  void updateTypeSpecific(String key, dynamic value) {
    final newTypeSpecific = Map<String, dynamic>.from(state.typeSpecific);
    newTypeSpecific[key] = value;
    state = state.copyWith(typeSpecific: newTypeSpecific);
  }

  Future<bool> submitJob({required FormMode mode, int? jobId}) async {
  final errors = state.validate();
  if (errors != null) throw Exception(errors.values.join(', '));
  
  try {
    if (mode == FormMode.edit) {
      await _postJobService.updateJob(jobId!, state);
    } else {
      await _postJobService.postJob(state);
    }
    _ref.read(postedJobsProvider.notifier).refreshJobs();
    return true;
  } on DioException catch (e) {
    throw Exception(e.response?.data['error'] ?? 'Submission failed');
  }
}
}

final postedJobsProvider = StateNotifierProvider<PostedJobsNotifier, AsyncValue<PaginatedResponse<Job>>>((ref) {
  return PostedJobsNotifier(ref.read(postJobServiceProvider));
});

class PostedJobsNotifier extends StateNotifier<AsyncValue<PaginatedResponse<Job>>> {
  final PostJobService _service;
  int _currentPage = 1;
  bool _hasMore = true;

    PostedJobsNotifier(this._service) : super(const AsyncValue.loading()) {
    loadInitialJobs();
  }

  bool get hasMore => _hasMore;

  Future<void> loadInitialJobs({bool forceRefresh = false}) async {
    _currentPage = 1;
    _hasMore = true;
    state = const AsyncValue.loading();
    
    try {
      final jobs = await _service.getPostedJobs(page: _currentPage);
      state = AsyncValue.data(jobs);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> loadNextPage() async {
    if (!_hasMore || state.isLoading || state.value == null) return;
    
    final currentData = state.value;
    if (currentData == null) return;

    try {
      state = AsyncValue<PaginatedResponse<Job>>.loading()
          .copyWithPrevious(state);
      final newJobs = await _service.getPostedJobs(page: _currentPage + 1);
      
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
    debugPrint('Error loading next page: $e');
    // On error, revert to previous state but keep hasMore false
    _hasMore = false;
    state = AsyncValue<PaginatedResponse<Job>>.error(e, stack).copyWithPrevious(state);
  }
}

  Future<void> refreshJobs() async {
    await loadInitialJobs(forceRefresh: true);
  }

  Future<void> removeJob(int jobId) async {
    try {
      await _service.deleteJob(jobId);
      if (state.value != null) {
        final currentData = state.value!;
        state = AsyncValue<PaginatedResponse<Job>>.data(
          PaginatedResponse<Job>(
            count: currentData.count - 1,
            results: currentData.results.where((job) => job.id != jobId).toList(),
            next: currentData.next,
            previous: currentData.previous,
          ),
        );
      }
    } on DioException catch (e) {
      throw Exception('Failed to delete job: ${e.message}');
    }
  }
}