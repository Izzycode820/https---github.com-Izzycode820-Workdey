import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/enums/form_mode.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';
import 'package:workdey_frontend/core/models/paginated_response/paginated_response.dart';
import 'package:workdey_frontend/core/models/postjob/post_job_model.dart';
import 'package:workdey_frontend/core/providers/providers.dart';
import 'package:workdey_frontend/core/services/post_job_service.dart';

// ============================================================================
// CLEAN JOB FORM STATE - No more primitive manual updates
// ============================================================================

@immutable
class JobFormState {
  final PostJob job;
  final FormMode mode;
  final bool isLoading;
  final bool isValid;
  final Map<String, String> errors;
  final int? editingJobId;

  const JobFormState({
    required this.job,
    required this.mode,
    this.isLoading = false,
    this.isValid = false,
    this.errors = const {},
    this.editingJobId,
  });

  JobFormState copyWith({
    PostJob? job,
    FormMode? mode,
    bool? isLoading,
    bool? isValid,
    Map<String, String>? errors,
    int? editingJobId,
  }) {
    return JobFormState(
      job: job ?? this.job,
      mode: mode ?? this.mode,
      isLoading: isLoading ?? this.isLoading,
      isValid: isValid ?? this.isValid,
      errors: errors ?? this.errors,
      editingJobId: editingJobId ?? this.editingJobId,
    );
  }

  // Clean initialization from existing job (no primitive extensions)
  factory JobFormState.fromExistingJob(Job existingJob) {
    return JobFormState(
      job: PostJob(
        id: existingJob.id,
        jobType: existingJob.jobType,
        title: existingJob.title,
        category: existingJob.category,
        location: existingJob.location,
        city: existingJob.city,
        district: existingJob.district,
        job_nature: existingJob.jobNature,
        description: existingJob.description,
        rolesDescription: existingJob.rolesDescription,
        requirements: existingJob.requirements ?? [],
        workingDays: existingJob.workingDays ?? [],
        dueDate: existingJob.dueDate?.toIso8601String().split('T')[0],
        typeSpecific: Map<String, dynamic>.from(existingJob.typeSpecific),
        requiredSkills: existingJob.requiredSkills ?? [],
        optionalSkills: existingJob.optionalSkills ?? [],
      ),
      mode: FormMode.edit,
      editingJobId: existingJob.id,
    );
  }

  // Clean default state for new job
  factory JobFormState.newJob() {
    return JobFormState(
      job: PostJob(
        jobType: 'PRO',
        title: '',
        category: 'IT',
        location: '',
        city: '',
        district: '',
        job_nature: 'Full time',
        description: '',
        typeSpecific: {
          'salary_period': 'm',
          'compensation_toggle': false,
        },
        requiredSkills: [],
        optionalSkills: [],
      ),
      mode: FormMode.create,
    );
  }
}

// ============================================================================
// CLEAN JOB FORM NOTIFIER - No more primitive manual field updates
// ============================================================================

class JobFormNotifier extends StateNotifier<JobFormState> {
  final PostJobService _service;
  final Ref _ref;

  JobFormNotifier(this._service, this._ref) : super(JobFormState.newJob());

  // Clean initialization methods
  void initializeForCreate() {
    state = JobFormState.newJob();
  }

  void initializeForEdit(Job existingJob) {
    state = JobFormState.fromExistingJob(existingJob);
  }

  // Clean job type update with automatic field management
  void updateJobType(String newType) {
    final updatedTypeSpecific = <String, dynamic>{};
    
    // Smart type-specific field management
    switch (newType) {
      case 'PRO':
      case 'LOC':
        updatedTypeSpecific.addAll({
          'salary': state.job.typeSpecific['salary'],
          'salary_period': state.job.typeSpecific['salary_period'] ?? 'm',
        });
        break;
      case 'INT':
      case 'VOL':
        updatedTypeSpecific.addAll({
          'compensation_toggle': state.job.typeSpecific['compensation_toggle'] ?? false,
          if (state.job.typeSpecific['compensation_toggle'] == true)
            'bonus_supplementary': state.job.typeSpecific['bonus_supplementary'],
        });
        break;
    }

    _updateJob(state.job.copyWith(
      jobType: newType,
      typeSpecific: updatedTypeSpecific,
    ));
  }

  // Clean unified update method - no more primitive field-by-field updates
  void updateJobData({
    String? title,
    String? category,
    String? location,
    String? city,
    String? district,
    String? jobNature,
    String? description,
    String? rolesDescription,
    List<String>? requirements,
    List<String>? workingDays,
    String? dueDate,
    List<String>? requiredSkills,
    List<String>? optionalSkills,
    Map<String, dynamic>? typeSpecific,
  }) {
    _updateJob(state.job.copyWith(
      title: title ?? state.job.title,
      category: category ?? state.job.category,
      location: location ?? state.job.location,
      city: city ?? state.job.city,
      district: district ?? state.job.district,
      job_nature: jobNature ?? state.job.job_nature,
      description: description ?? state.job.description,
      rolesDescription: rolesDescription ?? state.job.rolesDescription,
      requirements: requirements ?? state.job.requirements,
      workingDays: workingDays ?? state.job.workingDays,
      dueDate: dueDate ?? state.job.dueDate,
      requiredSkills: requiredSkills ?? state.job.requiredSkills,
      optionalSkills: optionalSkills ?? state.job.optionalSkills,
      typeSpecific: typeSpecific ?? state.job.typeSpecific,
    ));
  }

  // Clean type-specific updates
  void updateTypeSpecificField(String key, dynamic value) {
    final updatedTypeSpecific = Map<String, dynamic>.from(state.job.typeSpecific);
    updatedTypeSpecific[key] = value;
    
    _updateJob(state.job.copyWith(typeSpecific: updatedTypeSpecific));
  }

  // Clean skill management
  void addRequiredSkill(String skill) {
    if (skill.trim().isEmpty || state.job.requiredSkills.contains(skill.trim())) return;
    
    final updatedSkills = [...state.job.requiredSkills, skill.trim()];
    _updateJob(state.job.copyWith(requiredSkills: updatedSkills));
  }

  void removeRequiredSkill(String skill) {
    final updatedSkills = state.job.requiredSkills.where((s) => s != skill).toList();
    _updateJob(state.job.copyWith(requiredSkills: updatedSkills));
  }

  void addOptionalSkill(String skill) {
    if (skill.trim().isEmpty || state.job.optionalSkills.contains(skill.trim())) return;
    
    final updatedSkills = [...state.job.optionalSkills, skill.trim()];
    _updateJob(state.job.copyWith(optionalSkills: updatedSkills));
  }

  void removeOptionalSkill(String skill) {
    final updatedSkills = state.job.optionalSkills.where((s) => s != skill).toList();
    _updateJob(state.job.copyWith(optionalSkills: updatedSkills));
  }

  void addRequirement(String requirement) {
    if (requirement.trim().isEmpty || state.job.requirements.contains(requirement.trim())) return;
    
    final updatedRequirements = [...state.job.requirements, requirement.trim()];
    _updateJob(state.job.copyWith(requirements: updatedRequirements));
  }

  void removeRequirement(String requirement) {
    final updatedRequirements = state.job.requirements.where((r) => r != requirement).toList();
    _updateJob(state.job.copyWith(requirements: updatedRequirements));
  }

  // Clean validation
  void _updateJob(PostJob updatedJob) {
    final errors = _validateJob(updatedJob);
    final isValid = errors.isEmpty;
    
    state = state.copyWith(
      job: updatedJob,
      errors: errors,
      isValid: isValid,
    );
  }

  Map<String, String> _validateJob(PostJob job) {
    final errors = <String, String>{};
    
    if (job.title.trim().isEmpty) {
      errors['title'] = 'Job title is required';
    }
    
    if (job.category.trim().isEmpty) {
      errors['category'] = 'Category is required';
    }
    
    if (job.description.trim().isEmpty) {
      errors['description'] = 'Description is required';
    }
    
    if (job.dueDate?.isEmpty ?? true) {
      errors['dueDate'] = 'Due date is required';
    }
    
    if ((job.city?.isEmpty ?? true) && (job.location?.isEmpty ?? true)) {
      errors['location'] = 'Location is required';
    }
    
    if (job.requiredSkills.isEmpty) {
      errors['requiredSkills'] = 'At least one required skill is needed';
    }
    
    // Validate salary for paid jobs
    if (job.jobType == 'PRO' || job.jobType == 'LOC') {
      final salary = job.typeSpecific['salary'];
      if (salary == null || (salary is num && salary <= 0)) {
        errors['salary'] = 'Valid salary is required for paid jobs';
      }
    }
    
    return errors;
  }

  // Clean submission
  Future<bool> submitJob() async {
    if (!state.isValid) {
      return false;
    }
    
    state = state.copyWith(isLoading: true);
    
    try {
      if (state.mode == FormMode.edit && state.editingJobId != null) {
        await _service.updateJob(state.editingJobId!, state.job);
      } else {
        await _service.postJob(state.job);
      }
      
      // Refresh the posted jobs list
      _ref.read(postedJobsProvider.notifier).refreshJobs();
      
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
    state = JobFormState.newJob();
  }
}

// ============================================================================
// CLEAN POSTED JOBS PROVIDER - No changes needed, already clean
// ============================================================================

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

// ============================================================================
// CLEAN PROVIDERS - No more primitive dependencies
// ============================================================================

final jobFormNotifierProvider = StateNotifierProvider<JobFormNotifier, JobFormState>((ref) {
  return JobFormNotifier(ref.read(postJobServiceProvider), ref);
});

final postedJobsProvider = StateNotifierProvider<PostedJobsNotifier, AsyncValue<PaginatedResponse<Job>>>((ref) {
  return PostedJobsNotifier(ref.read(postJobServiceProvider));
});