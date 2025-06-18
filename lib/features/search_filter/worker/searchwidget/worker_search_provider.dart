import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/features/search_filter/search_core.dart';
import 'package:workdey_frontend/features/search_filter/worker/filterwidget/worker_filters_enums.dart';
import 'package:workdey_frontend/features/search_filter/worker/searchwidget/worker_search_state.dart';

final workerSearchProvider = StateNotifierProvider<
  WorkerSearchNotifier, 
  WorkerSearchState
>((ref) {
  return WorkerSearchNotifier();
});

class WorkerSearchNotifier extends BaseSearchNotifier<WorkerSearchState> {
  WorkerSearchNotifier() : super(const WorkerSearchState());
  Timer? _debounceTimer;

  @override
  void setQuery(String query) {
    _debounceTimer?.cancel();
    state = state.copyWith(query: query);
    
    _debounceTimer = Timer(const Duration(milliseconds: 400), () {
      // Trigger search here
      _performSearch();
    });
  }

  void setCategory(WorkerCategory? category) {
    state = state.copyWith(category: category);
    _performSearch();
  }

  void _performSearch() {
    // In a real app, you would call your worker search API here
    // Example:
    // final results = await ref.read(workerServiceProvider).search(
    //   query: state.query,
    //   category: state.category,
    // );
    // Then update your workers list provider
    // Convert enum to String if needed for API
   // final categoryName = state.category?.name;
    // Use categoryName in your API call
  }

  @override
  void toggleFilters() {
    state = state.copyWith(showFilters: !state.showFilters);
  }

  @override
  void reset() {
    state = const WorkerSearchState();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}