// features/search_filter/providers/search_filter_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchFilterProvider = StateNotifierProvider<SearchFilterNotifier, SearchFilterState>((ref) {
  return SearchFilterNotifier();
});

class SearchFilterState {
  final String query;
  final String? category;
  final bool showFilters;

  const SearchFilterState({
    this.query = '',
    this.category,
    this.showFilters = false,
  });

// Complete copyWith method
  SearchFilterState copyWith({
    String? query,
    String? category,
    bool? showFilters,
  }) {
    return SearchFilterState(
      query: query ?? this.query,
      category: category ?? this.category,
      showFilters: showFilters ?? this.showFilters,
    );
  }

  // Helper to check if any filter is active
  bool get hasActiveFilters => category != null;
}

class SearchFilterNotifier extends StateNotifier<SearchFilterState> {
  SearchFilterNotifier() : super(const SearchFilterState());

  void toggleFilters() => state = state.copyWith(showFilters: !state.showFilters);
  void setQuery(String query) => state = state.copyWith(query: query);
  void setCategory(String? category) => state = state.copyWith(category: category);
  void reset() => state = const SearchFilterState();
}