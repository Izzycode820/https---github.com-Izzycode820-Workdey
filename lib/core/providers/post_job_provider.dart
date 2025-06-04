import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/post_job_model.dart';
import 'package:workdey_frontend/core/providers/providers.dart';
import 'package:workdey_frontend/core/services/post_job_service.dart';

//Post job form
final postJobNotifierProvider = StateNotifierProvider.autoDispose<PostJobNotifier, PostJob>((ref) {
    return PostJobNotifier(ref.read(postJobServiceProvider));
});

class PostJobNotifier extends StateNotifier<PostJob> {
  final PostJobService _postJobService;
  
  PostJobNotifier(this._postJobService) : super(PostJob(
    jobType: 'LOC',
    title: '',
    category: 'IT',
    location: '',
    description: '',
    typeSpecific: {'salary_period': 'd', 'compensation_toggle': false},
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
      jobNature: field == 'jobNature' ? value : state.jobNature,
    );
  }

  void updateTypeSpecific(String key, dynamic value) {
    final newTypeSpecific = Map<String, dynamic>.from(state.typeSpecific);
    newTypeSpecific[key] = value;
    state = state.copyWith(typeSpecific: newTypeSpecific);
  }

  Future<bool> submitJob() async {
     final errors = state.validate();
    if (errors != null) {
      throw Exception('Validation failed: ${errors.values.join(', ')}');
    }

  try {
    final ref = ProviderContainer();
    await _postJobService.postJob(state);
    ref.read(postedJobsProvider.notifier).addJob(state);
    return true;
    } on DioException catch (e) {
      if (e.response?.statusCode == 403) {
        throw Exception('Verification level too low for this job type');
      }
      throw Exception(e.response?.data['error'] ?? 'Failed to post job');
    }
  }
}

final postedJobsProvider = StateNotifierProvider<PostedJobsNotifier, List<PostJob>>((ref) {
  return PostedJobsNotifier(ref.read(postJobServiceProvider));
});

class PostedJobsNotifier extends StateNotifier<List<PostJob>> {
  final PostJobService _service;

  PostedJobsNotifier(this._service) : super([]) {
    loadJobs();
  }

  Future<void> loadJobs() async {
    try {
      // Implement this method in your PostJobService
      final jobs = await _service.getPostedJobs();
      state = jobs;
    } catch (e) {
      state = []; // Fallback to empty list
    }
  }

  void addJob(PostJob job) {
    state = [job, ...state]; // Add new job at beginning
  }

  void removeJob(String jobId) {
    state = state.where((job) => job.id != jobId).toList();
  }
}