import 'package:workdey_frontend/features/search_filter/search_core.dart';
import 'package:workdey_frontend/features/search_filter/worker/filterwidget/worker_filters_enums.dart';

class WorkerSearchState extends BaseSearchState {
  final WorkerCategory? category;
  final List<String>? skills;
  final String? location;
  final List<WorkerAvailability>? availability;
  
  const WorkerSearchState({
    String query = '',
    this.category,
    this.skills,
    this.location,
    this.availability,
    bool showFilters = false,
  }) : super(query: query, showFilters: showFilters);

  @override
  bool get hasActiveFilters => 
  category != null ||
  (skills?.isNotEmpty ?? false) || 
      location != null || 
      (availability?.isNotEmpty ?? false);

 WorkerSearchState copyWith({
    String? query,
    WorkerCategory? category,
    List<String>? skills,
    String? location,
    List<WorkerAvailability>? availability,
    bool? showFilters,
  }) {
    return WorkerSearchState(
      query: query ?? this.query,
      category: category ?? this.category,
      skills: skills ?? this.skills,
      location: location ?? this.location,
      availability: availability ?? this.availability,
      showFilters: showFilters ?? this.showFilters,
    );
  }
}

