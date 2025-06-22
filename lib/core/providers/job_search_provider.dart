import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';
import 'package:workdey_frontend/core/services/Searchfilter/job_SF.dart';

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
  JobSearchState({
    required super.results,
    required super.isLoading,
    super.error,
    required super.query,
    required super.page,
    required super.hasMore,
  });

  JobSearchState copyWith({
    List<Job>? results,
    bool? isLoading,
    String? error,
    String? query,
    int? page,
    bool? hasMore,
  }) {
    return JobSearchState(
      results: results ?? this.results,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      query: query ?? this.query,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
// Notifiers
class JobSearchNotifier extends StateNotifier<JobSearchState> {
  final JobSearchService _service;

  JobSearchNotifier(this._service) : super(JobSearchState(
    results: [],
    isLoading: false,
    query: '',
    page: 1,
    hasMore: true,
  ));

  Future<void> searchJobs({String? query, bool loadMore = false}) async {
    try {
      state = state.copyWith(
        isLoading: true,
        error: null,
        query: query ?? state.query,
        page: loadMore ? state.page : 1,
      );

      final results = await _service.search(
        query: query ?? state.query,
        page: loadMore ? state.page + 1 : 1,
      );

      state = state.copyWith(
        isLoading: false,
        results: loadMore 
            ? [...state.results, ...results]
            : results,
        page: loadMore ? state.page + 1 : 1,
        hasMore: results.isNotEmpty, // Adjust based on your pagination logic
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void setQuery(String query) {
    state = state.copyWith(query: query);
  }
}