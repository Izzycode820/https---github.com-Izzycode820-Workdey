import 'package:workdey_frontend/features/search_filter/job/filterwidgets/job_filter_enum.dart';
import 'package:workdey_frontend/features/search_filter/search_core.dart';

//enum JobType { internship, professional, vulonteer, category}
//enum Category{ health, it, construction}

class JobSearchState extends BaseSearchState {
  final JobType? jobType;
  final JobCategory? category;
  final List<String>? skills;
  final String? location;
  final List<WorkingDays>? workingDays;
  final JobNature? jobNature;
  
  const JobSearchState({
    String query = '',
    this.jobType,
    this.category,
    this.skills,
    this.location,
    this.jobNature,
    this.workingDays,
    bool showFilters = false,
  }) : super(query: query, showFilters: showFilters);

  @override
  bool get hasActiveFilters => jobType != null || category != null ||
  (skills?.isNotEmpty ?? false) || 
      location != null || jobNature != null ||
      (workingDays?.isNotEmpty ?? false);

  // Similar copyWith implementation
  JobSearchState copyWith({
    String? query,
    JobCategory? category,
    JobType? jobType,
    List<String>? skills,
    String? location,
    List<WorkingDays>? workingDays,
    JobNature? jobNature,
    bool? showFilters,
  }) {
    return JobSearchState(
      query: query ?? this.query,
      category: category ?? this.category,
      jobType: jobType ?? this.jobType,
      skills: skills ?? this.skills,
      location: location ?? this.location,
      workingDays: workingDays ?? this.workingDays,
      jobNature: jobNature ?? this.jobNature,
      showFilters: showFilters ?? this.showFilters,
    );
  }
}