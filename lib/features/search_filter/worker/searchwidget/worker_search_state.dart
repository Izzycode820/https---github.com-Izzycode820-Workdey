import 'package:workdey_frontend/features/search_filter/search_core.dart';
import 'package:workdey_frontend/features/search_filter/worker/filterwidget/worker_filters_enums.dart';

class WorkerSearchState extends BaseSearchState {
  final WorkerCategory? category;
  
  const WorkerSearchState({
    String query = '',
    this.category,
    bool showFilters = false,
  }) : super(query: query, showFilters: showFilters);

  @override
  bool get hasActiveFilters => category != null;

 WorkerSearchState copyWith({
    String? query,
    WorkerCategory? category, // Updated parameter type
    bool? showFilters,
  }) {
    return WorkerSearchState(
      query: query ?? this.query,
      category: category ?? this.category,
      showFilters: showFilters ?? this.showFilters,
    );
  }
}

