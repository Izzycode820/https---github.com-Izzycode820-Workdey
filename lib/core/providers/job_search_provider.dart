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
  int _currentPage = 1;
  bool _hasMore = true;

  JobSearchNotifier(this._service) : super(JobSearchState(
    results: [],
    isLoading: false,
    query: '',
    page: 1,
    hasMore: true,
  ));

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
        page: loadMore ? _currentPage + 1 : 1,
      //other params
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
}