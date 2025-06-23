import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';
import 'package:workdey_frontend/core/services/Searchfilter/job_SF.dart';
import 'package:workdey_frontend/features/search_filter/job_filter_enum.dart';

extension JobSearchStateX on JobSearchState {
  bool get canLoadMore => !isLoading && hasMore;
}

// Base state classes
abstract class SearchState<T> {
  final List<T> results;
  final bool isLoading;
  final String? error;
  final String query;
  final int page;
  final bool hasMore;
  

  const SearchState({
    required this.results,
    required this.isLoading,
    this.error,
    required this.query,
    required this.page,
    required this.hasMore,
  });
}

// Job Search State
class JobSearchState extends SearchState<Job> {
  final JobCategory? category;
  final JobType? jobType;
  final List<String>? skills;
  final String? location;
  final List<WorkingDays>? workingDays;
  final JobNature? jobNature;

  JobSearchState({
    required super.results,
    required super.isLoading,
    super.error,
    required super.query,
    required super.page,
    required super.hasMore,
    this.category,
    this.jobType,
    this.skills,
    this.location,
    this.workingDays,
    this.jobNature,
  });

  //@override
  JobSearchState copyWith({
    List<Job>? results,
    bool? isLoading,
    String? error,
    String? query,
    int? page,
    bool? hasMore,
    JobCategory? category,
    JobType? jobType,
    List<String>? skills,
    String? location,
    List<WorkingDays>? workingDays,
    JobNature? jobNature,
  }) {
    return JobSearchState(
      results: results ?? this.results,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      query: query ?? this.query,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      category: category ?? this.category,
      jobType: jobType ?? this.jobType,
      skills: skills ?? this.skills,
      location: location ?? this.location,
      workingDays: workingDays ?? this.workingDays,
      jobNature: jobNature ?? this.jobNature,
    );
  }
}
// Notifiers
class JobSearchNotifier extends StateNotifier<JobSearchState> {
  final JobSearchService _service;
  int _currentPage = 1;
  bool _hasMore = true;

  JobSearchNotifier(this._service) : super(JobSearchState(
    results: [],
    isLoading: false,
    query: '',
    page: 1,
    hasMore: true,
  ));


//filters
void setCategory(JobCategory? category) {
    state = state.copyWith(category: category);
  }

  void setJobType(JobType? type) {
    state = state.copyWith(jobType: type);
  }

  void setSkills(List<String>? skills) {
    state = state.copyWith(skills: skills);
  }

  void setLocation(String? location) {
    state = state.copyWith(location: location);
  }

  void setWorkingDays(List<WorkingDays>? days) {
    state = state.copyWith(workingDays: days);
  }

  void setJobNature(JobNature? nature) {
    state = state.copyWith(jobNature: nature);
  }
  
  Future<void> searchJobs({String? query, bool loadMore = false}) async {
    try {
      if (!loadMore) {
        _currentPage = 1;
        _hasMore = true;
        state = state.copyWith(
          isLoading: true,
          error: null,
          query: query ?? state.query,
          page: 1,
          results: [],
        );
      } else {
        if (!_hasMore) return;
        state = state.copyWith(isLoading: true);
      }


       
      final results = await _service.search(
      query: query ?? state.query,
      category: state.category,
      jobType: state.jobType,
      skills: state.skills,
      location: state.location,
      workingDays: state.workingDays,
      jobNature: state.jobNature,
      page: loadMore ? _currentPage + 1 : 1,
    );

      // Handle empty response
      if (results.isEmpty) {
        _hasMore = false;
        state = state.copyWith(
          isLoading: false,
          hasMore: false,
        );
        return;
      }

      _currentPage = loadMore ? _currentPage + 1 : 1;
      _hasMore = results.isNotEmpty; // Or use API's pagination info if available

      state = state.copyWith(
        isLoading: false,
        results: loadMore 
            ? [...state.results, ...results]
            : results,
        page: loadMore ? state.page + 1 : 1,
      hasMore: results.isNotEmpty,
      );
    } catch (e) {
      // On error, maintain existing results but show error
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        hasMore: false,
      );
    }
  }

Future<void> triggerSearch() async {
  state = state.copyWith(isLoading: true);
  
  final results = await _service.search(query: state.query);
  
  state = state.copyWith(
    isLoading: false,
    results: results,
  );
}

  void setQuery(String query) {
    state = state.copyWith(query: query);
  }

  void resetAll() {
  state = JobSearchState(
    results: [],
    isLoading: false,
    query: '',
    page: 1,
    hasMore: true,
  );
}

void resetAllFilters() {
  // Create new empty lists for array filters
  final emptyList = <String>[];
  final emptyDaysList = <WorkingDays>[];
  
  // Create completely new state object
  state = JobSearchState(
    // Preserve search context
    results: state.results,
    query: state.query,
    isLoading: false,
    page: 1,
    hasMore: true,
    error: null,
    
    // Clear all filters
    category: null,
    jobType: null,
    skills: emptyList,
    location: null,
    workingDays: emptyDaysList,
    jobNature: null,
  );
  
  // Re-run search with cleared filters but same query
  if (state.query.isNotEmpty) {
    searchJobs(query: state.query);
  }}

}