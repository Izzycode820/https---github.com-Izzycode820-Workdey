import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/providers/providers.dart';
import 'package:workdey_frontend/screens/search_screen.dart';

class SearchBarWidget extends ConsumerStatefulWidget {
  final bool isJobSearch;
  
  const SearchBarWidget({
    super.key,
    required this.isJobSearch,
  });

  @override
  ConsumerState<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends ConsumerState<SearchBarWidget> {
  final _searchController = TextEditingController();
  Timer? _debounceTimer;

  @override
  void dispose() {
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    // Cancel previous timer if it exists
    _debounceTimer?.cancel();
    
    // Start new timer
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _performSearch(query);
    });
  }

  void _performSearch(String query) {
    if (widget.isJobSearch) {
      ref.read(jobSearchNotifierProvider.notifier)
      ..setQuery(query)
      ..searchJobs();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const JobSearchPage()),
    );
    } else {
      ref.read(workerSearchNotifierProvider.notifier)
      ..setQuery(query)
      ..searchWorkers();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const JobSearchPage()),
    );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: widget.isJobSearch 
            ? 'Search jobs...' 
            : 'Search workers...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          icon: const Icon(Icons.tune),
          onPressed: () {
            // Will implement filter opening in Phase 2
          
          //  if (widget.isJobSearch) {
          //    ref.read(jobSearchNotifierProvider.notifier).toggleFilters();
          //   } else {
          //      ref.read(workerSearchNotifierProvider.notifier).toggleFilters();
          //   }
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onChanged: _onSearchChanged,
    );
  }
}