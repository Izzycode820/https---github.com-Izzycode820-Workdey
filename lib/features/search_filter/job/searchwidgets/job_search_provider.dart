import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/providers/providers.dart';
import 'package:workdey_frontend/core/services/Searchfilter/job_SF.dart';
import 'package:workdey_frontend/features/search_filter/job/filterwidgets/job_filter_enum.dart';
import 'package:workdey_frontend/features/search_filter/job/searchwidgets/job_search_state.dart';
import 'package:workdey_frontend/features/search_filter/search_core.dart';



class JobSearchNotifier extends BaseSearchNotifier<JobSearchState> {
  final JobSearchService _searchService;
  final Ref _ref;
  bool _isLoading = false;
  int _currentPage = 1;
  
  JobSearchNotifier(this._searchService, this._ref) : super(const JobSearchState());
  Timer? _debounceTimer;
  
  
   @override
  void setQuery(String query) {
    _debounceTimer?.cancel();
    state = state.copyWith(query: query);
    
    _debounceTimer = Timer(const Duration(milliseconds: 400), () {
      _performSearch();
    });
  }
  //Add other filters
  void setJobType(JobType? jobType) {
    state = state.copyWith(jobType: jobType);
    _performSearch();
  }

  void setcategory(JobCategory? category) {
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

  void setAvailability(List<WorkingDays>? workingDays) {
    state = state.copyWith(workingDays: workingDays);
    _performSearch();
  }

   void setJobNature(JobNature? jobNature) {
    state = state.copyWith(jobNature: jobNature);
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
      query: state.query,
      category: state.category,
      skills: state.skills,
      location: state.location,
      jobNature: state.jobNature,
      workingDays: state.workingDays,
      // Add pagination parameters as needed by your API
      page: _currentPage + 1,
    );
    
    if (results.isNotEmpty) {
      _currentPage++;
      _ref.read(jobResultsProvider.notifier).addResults(results);
    }
  } finally {
    _isLoading = false;
  }
}

  
//Api call
  Future<void> _performSearch() async{
    try {
      final results = await _searchService.search(
        query: state.query,
        // category: state.category,
        // skills: state.skills,
        // location: state.location,
        // jobNature: state.jobNature,
        // workingDays: state.workingDays,
      );
      // Update your results provider here
      _ref.read(jobResultsProvider.notifier).updateResults(results);
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
    state = const JobSearchState();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}