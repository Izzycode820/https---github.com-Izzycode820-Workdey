import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/providers/recent_search_provider.dart';

class RecentSearchesList extends ConsumerWidget {
  const RecentSearchesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentSearches = ref.watch(recentSearchesProvider);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Recent Searches', 
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        ...recentSearches.map((query) => ListTile(
          leading: const Icon(Icons.history),
          title: Text(query),
          onTap: () {
            // Handle recent search tap
            // Example: ref.read(searchQueryProvider.notifier).state = query;
            // Then trigger search
          },
        )).toList(),
      ],
    );
  }
}