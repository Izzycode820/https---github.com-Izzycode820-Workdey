import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/features/search_filter/job/searchwidgets/job_search_bar.dart';
import 'package:workdey_frontend/features/search_filter/search_context.dart';
import 'package:workdey_frontend/features/search_filter/worker/searchwidget/workers_search_bar.dart';

class SearchBarWidget extends ConsumerWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchContext = ref.watch(searchContextProvider);
    
    return switch (searchContext) {
      SearchContext.workers => const WorkerSearchBar(),
      SearchContext.jobs => const JobSearchBar(),
    };
  }
}