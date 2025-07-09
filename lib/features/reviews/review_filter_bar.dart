import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/providers/review_provider.dart';

class ReviewFilterBar extends ConsumerWidget {
  const ReviewFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(reviewFilterProvider);

    if (!_hasActiveFilters(filter)) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      child: Row(
        children: [
          const Icon(
            Icons.filter_list,
            size: 20,
            color: Color(0xFF3E8728),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  if (filter.reviewType != null)
                    _buildFilterChip(
                      context,
                      ref,
                      _getReviewTypeDisplay(filter.reviewType!),
                      () => ref.read(reviewFilterProvider.notifier)
                          .update((state) => state.copyWith(reviewType: null)),
                    ),
                  if (filter.minRating != null)
                    _buildFilterChip(
                      context,
                      ref,
                      '${filter.minRating}+ stars',
                      () => ref.read(reviewFilterProvider.notifier)
                          .update((state) => state.copyWith(minRating: null)),
                    ),
                ],
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              ref.read(reviewFilterProvider.notifier).state = ReviewFilter();
              ref.read(reviewsReceivedProvider.notifier).refresh();
            },
            child: const Text(
              'Clear all',
              style: TextStyle(
                color: Color(0xFF3E8728),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context,
    WidgetRef ref,
    String label,
    VoidCallback onRemove,
  ) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: Chip(
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF3E8728),
          ),
        ),
        deleteIcon: const Icon(
          Icons.close,
          size: 16,
          color: Color(0xFF3E8728),
        ),
        onDeleted: onRemove,
        backgroundColor: const Color(0xFF3E8728).withOpacity(0.1),
        side: const BorderSide(color: Color(0xFF3E8728), width: 1),
      ),
    );
  }

  bool _hasActiveFilters(ReviewFilter filter) {
    return filter.reviewType != null ||
           filter.minRating != null ||
           filter.maxRating != null;
  }

  String _getReviewTypeDisplay(String reviewType) {
    switch (reviewType) {
      case 'JOB_EMP_WORKER':
        return 'Job Reviews';
      case 'JOB_WORKER_EMP':
        return 'Employer Reviews';
      case 'SERVICE_CLIENT':
        return 'Service Reviews';
      case 'COMMUNITY':
        return 'Community Reviews';
      default:
        return reviewType;
    }
  }
}