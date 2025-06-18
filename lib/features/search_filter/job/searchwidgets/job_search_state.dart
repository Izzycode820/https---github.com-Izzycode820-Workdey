import 'package:workdey_frontend/features/search_filter/job/filterwidgets/job_filter_enum.dart';
import 'package:workdey_frontend/features/search_filter/search_core.dart';

//enum JobType { internship, professional, vulonteer, category}
//enum Category{ health, it, construction}

class JobSearchState extends BaseSearchState {
  final JobType? jobType;
  final JobCategory? category;
  
  const JobSearchState({
    String query = '',
    this.jobType,
    this.category,
    bool showFilters = false,
  }) : super(query: query, showFilters: showFilters);

  @override
  bool get hasActiveFilters => jobType != null || category != null;

  // Similar copyWith implementation
  JobSearchState copyWith({
    String? query,
    JobCategory? category,
    JobType? jobType,
    bool? showFilters,
  }) {
    return JobSearchState(
      query: query ?? this.query,
      category: category ?? this.category,
      jobType: jobType ?? this.jobType,
      showFilters: showFilters ?? this.showFilters,
    );
  }
}