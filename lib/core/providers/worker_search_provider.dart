import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/getworkers/get_workers_model.dart';
import 'package:workdey_frontend/core/services/Searchfilter/worker_SF.dart';
import 'package:workdey_frontend/features/search_filter/worker_filters_enums.dart';


extension WorkerSearchStateX on WorkerSearchState {
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

// Worker Search State
  class WorkerSearchState extends SearchState<Worker> {
  final WorkerCategory? category;
  final List<String>? skills;
  final String? location;
  final List<WorkerAvailability>? availability;

  WorkerSearchState({
    required super.results,
    required super.isLoading,
    super.error,
    required super.query,
    required super.page,
    required super.hasMore,
    this.category,
    this.skills,
    this.location,
    this.availability,
  });

  //@override
  WorkerSearchState copyWith({
    List<Worker>? results,
    bool? isLoading,
    String? error,
    String? query,
    int? page,
    bool? hasMore,
    WorkerCategory? category,
    List<String>? skills,
    String? location,
    List<WorkerAvailability>? availability,
  }) {
    return WorkerSearchState(
      results: results ?? this.results,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      query: query ?? this.query,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      category: category ?? this.category,
      skills: skills ?? this.skills,
      location: location ?? this.location,
      availability: availability ?? this.availability,
    );
  }
}

// Notifiers
class WorkerSearchNotifier extends StateNotifier<WorkerSearchState> {
  final WorkerSearchService _service;
  int _currentPage = 1;
  bool _hasMore = true;

  WorkerSearchNotifier(this._service) : super(WorkerSearchState(
    results: [],
    isLoading: false,
    query: '',
    page: 1,
    hasMore: true,
  ));

   void setCategory(WorkerCategory? category) {
    state = state.copyWith(category: category);
  }

  void setSkills(List<String>? skills) {
    state = state.copyWith(skills: skills);
  }

  void setLocation(String? location) {
    state = state.copyWith(location: location);
  }

  void setAvailability(List<WorkerAvailability>? availability) {
    state = state.copyWith(availability: availability);
  }
  
  Future<void> searchWorkers({String? query, bool loadMore = false}) async {
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
      skills: state.skills,
      location: state.location,
      availability: state.availability,
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
  state = WorkerSearchState(
    results: [],
    isLoading: false,
    query: '',
    page: 1,
    hasMore: true,
  );
}

void resetAllFilters() {
  // Create new empty lists
  final emptySkills = <String>[];
  final emptyAvailability = <WorkerAvailability>[];
  
  state = WorkerSearchState(
    // Preserve search context
    results: state.results,
    query: state.query,
    isLoading: false,
    page: 1,
    hasMore: true,
    error: null,
    
    // Clear all filters
    category: null,
    skills: emptySkills,
    location: null,
    availability: emptyAvailability,
  );
  
  if (state.query.isNotEmpty) {
    searchWorkers(query: state.query);
  }
}
}