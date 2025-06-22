// features/search_filter/providers/search_filter_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/features/search_filter/job/filterwidgets/job_filter_enum.dart';
import 'package:workdey_frontend/features/search_filter/worker/filterwidget/worker_filters_enums.dart';

final searchFilterProvider = StateNotifierProvider<SearchFilterNotifier, SearchFilterState>((ref) {
  return SearchFilterNotifier();
});

abstract class BaseFilterState {
  final String query;
  final bool showFilters;
  
  const BaseFilterState({
    required this.query,
    required this.showFilters,
  });

  bool get hasActiveFilters;
}

class WorkerFilterState extends BaseFilterState {
  final WorkerCategory? category;
  final List<String>? skills;
  final String? location;
  final List<WorkerAvailability>? availability;
  
  const WorkerFilterState({
    String query = '',
    this.category,
    this.skills,
    this.location,
    this.availability,
    bool showFilters = false,
  }) : super(query: query, showFilters: showFilters);

  @override
  bool get hasActiveFilters => 
      category != null ||
      (skills?.isNotEmpty ?? false) || 
      location != null || 
      (availability?.isNotEmpty ?? false);

  WorkerFilterState copyWith({
    String? query,
    WorkerCategory? category,
    List<String>? skills,
    String? location,
    List<WorkerAvailability>? availability,
    bool? showFilters,
  }) {
    return WorkerFilterState(
      query: query ?? this.query,
      category: category ?? this.category,
      skills: skills ?? this.skills,
      location: location ?? this.location,
      availability: availability ?? this.availability,
      showFilters: showFilters ?? this.showFilters,
    );
  }
}

class JobFilterState extends BaseFilterState {
  final JobType? jobType;
  final JobCategory? category;
  final List<String>? skills;
  final String? location;
  final List<WorkingDays>? workingDays;
  final JobNature? jobNature;
  
  const JobFilterState({
    String query = '',
    this.jobType,
    this.category,
    this.skills,
    this.location,
    this.jobNature,
    this.workingDays,
    bool showFilters = false,
  }) : super(query: query, showFilters: showFilters);

  @override
  bool get hasActiveFilters => 
      jobType != null || 
      category != null ||
      (skills?.isNotEmpty ?? false) || 
      location != null || 
      jobNature != null ||
      (workingDays?.isNotEmpty ?? false);

  JobFilterState copyWith({
    String? query,
    JobType? jobType,
    JobCategory? category,
    List<String>? skills,
    String? location,
    JobNature? jobNature,
    List<WorkingDays>? workingDays,
    bool? showFilters,
  }) {
    return JobFilterState(
      query: query ?? this.query,
      jobType: jobType ?? this.jobType,
      category: category ?? this.category,
      skills: skills ?? this.skills,
      location: location ?? this.location,
      jobNature: jobNature ?? this.jobNature,
      workingDays: workingDays ?? this.workingDays,
      showFilters: showFilters ?? this.showFilters,
    );
  }
}

class SearchFilterState {
  final String query;
  final String? category;
  final bool showFilters;

  const SearchFilterState({
    this.query = '',
    this.category,
    this.showFilters = false,
  });

// Complete copyWith method
  SearchFilterState copyWith({
    String? query,
    String? category,
    bool? showFilters,
  }) {
    return SearchFilterState(
      query: query ?? this.query,
      category: category ?? this.category,
      showFilters: showFilters ?? this.showFilters,
    );
  }

  // Helper to check if any filter is active
  bool get hasActiveFilters => category != null;
}

class SearchFilterNotifier extends StateNotifier<SearchFilterState> {
  SearchFilterNotifier() : super(const SearchFilterState());

  void toggleFilters() => state = state.copyWith(showFilters: !state.showFilters);
  void setQuery(String query) => state = state.copyWith(query: query);
  void setCategory(String? category) => state = state.copyWith(category: category);
  void reset() => state = const SearchFilterState();
}