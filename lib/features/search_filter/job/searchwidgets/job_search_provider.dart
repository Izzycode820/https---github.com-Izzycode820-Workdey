import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/features/search_filter/job/filterwidgets/job_filter_enum.dart';
import 'package:workdey_frontend/features/search_filter/job/searchwidgets/job_search_state.dart';
import 'package:workdey_frontend/features/search_filter/search_core.dart';

final jobSearchProvider = StateNotifierProvider<
  JobSearchNotifier, 
  JobSearchState
>((ref) {
  return JobSearchNotifier();
});

class JobSearchNotifier extends BaseSearchNotifier<JobSearchState> {
  JobSearchNotifier() : super(const JobSearchState());
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
//Api call
  void _performSearch() {
    // Call your job search API here
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