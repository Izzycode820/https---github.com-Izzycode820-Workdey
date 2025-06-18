import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SearchContext {
  jobs,
  workers,
}

final searchContextProvider = StateProvider<SearchContext>((ref) {
  // We'll implement auto-detection in Step 3
  return SearchContext.workers; // Temporary default nad will be overridden by route genarator
});