import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/providers/providers.dart';
import 'package:workdey_frontend/core/services/Searchfilter/worker_SF.dart';
import 'package:workdey_frontend/features/search_filter/search_core.dart';
import 'package:workdey_frontend/features/search_filter/worker/filterwidget/worker_filters_enums.dart';
import 'package:workdey_frontend/features/search_filter/worker/searchwidget/worker_search_state.dart';


class WorkerSearchNotifier extends BaseSearchNotifier<WorkerSearchState> {
  final WorkerSearchService _searchService;
  final Ref _ref;
  bool _isLoading = false;
int _currentPage = 1;

  WorkerSearchNotifier(this._searchService, this._ref) : super(const WorkerSearchState());
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

   void setSkills(List<String>? skills) {
    state = state.copyWith(skills: skills);
    _performSearch();
  }

  void setLocation(String? location) {
    state = state.copyWith(location: location);
    _performSearch();
  }

  void setAvailability(List<WorkerAvailability>? availability) {
    state = state.copyWith(availability: availability);
    _performSearch();
  }

Future<void> refreshSearch() async {
  state = state.copyWith(showFilters: false);
  await _performSearch();
}

Future<void> loadMore() async {
  if (_isLoading) return;
  _isLoading = true;
  
  try {
    final results = await _searchService.search(
      // query: state.query,
      // category: state.category,
      // skills: state.skills,
      // location: state.location,
      // availability: state.availability,
      // Add pagination parameters as needed by your API
      page: _currentPage + 1,
    );
    
    if (results.isNotEmpty) {
      _currentPage++;
      _ref.read(workerResultsProvider.notifier).addResults(results);
    }
  } finally {
    _isLoading = false;
  }
}

  Future<void> _performSearch() async{
    try {
      final results = await _searchService.search(
        query: state.query,
        category: state.category,
        skills: state.skills,
        location: state.location,
        availability: state.availability,
      );
      // Update your results provider here
      _ref.read(workerResultsProvider.notifier).updateResults(results);
    } catch (e) {
      // Handle error
    }
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