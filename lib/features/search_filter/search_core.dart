import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseSearchState {
  final String query;
  final bool showFilters;
  
  const BaseSearchState({
    required this.query,
    required this.showFilters,
  });

  bool get hasActiveFilters;
}
 
 // Base class for all search notifiers
abstract class BaseSearchNotifier<T extends BaseSearchState> 
  extends StateNotifier<T> {
  BaseSearchNotifier(super.state);

  void setQuery(String query);
  void toggleFilters();
  void reset();
}