import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/getworkers/get_workers_model.dart';
import 'package:workdey_frontend/core/services/Searchfilter/worker_SF.dart';

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
  WorkerSearchState({
    required super.results,
    required super.isLoading,
    super.error,
    required super.query,
    required super.page,
    required super.hasMore,
  });

  WorkerSearchState copyWith({
    List<Worker>? results,
    bool? isLoading,
    String? error,
    String? query,
    int? page,
    bool? hasMore,
  }) {
    return WorkerSearchState(
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
class WorkerSearchNotifier extends StateNotifier<WorkerSearchState> {
  final WorkerSearchService _service;

  WorkerSearchNotifier(this._service) : super(WorkerSearchState(
    results: [],
    isLoading: false,
    query: '',
    page: 1,
    hasMore: true,
  ));

  Future<void> searchWorkers({String? query, bool loadMore = false}) async {
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