import 'package:flutter_riverpod/flutter_riverpod.dart';

final recentSearchesProvider = StateNotifierProvider<RecentSearchesNotifier, List<String>>((ref) {
  return RecentSearchesNotifier();
});

class RecentSearchesNotifier extends StateNotifier<List<String>> {
  RecentSearchesNotifier() : super([]);

  void addSearch(String query) {
    state = [query, ...state.where((q) => q != query).take(4)];
  }
}