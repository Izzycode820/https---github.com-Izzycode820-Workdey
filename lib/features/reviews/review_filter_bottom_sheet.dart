import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/providers/review_provider.dart';

class ReviewFilterBottomSheet extends ConsumerStatefulWidget {
  const ReviewFilterBottomSheet({super.key});

  @override
  ConsumerState<ReviewFilterBottomSheet> createState() => _ReviewFilterBottomSheetState();
}

class _ReviewFilterBottomSheetState extends ConsumerState<ReviewFilterBottomSheet> {
  late ReviewFilter _tempFilter;

  @override
  void initState() {
    super.initState();
    _tempFilter = ref.read(reviewFilterProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Text(
                  'Filter Reviews',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _tempFilter = ReviewFilter();
                    });
                  },
                  child: const Text('Reset'),
                ),
              ],
            ),
          ),

          const Divider(),

          // Filter options
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildReviewTypeFilter(),
                  const SizedBox(height: 24),
                  _buildRatingFilter(),
                  const SizedBox(height: 24),
                  _buildSortingOptions(),
                ],
              ),
            ),
          ),

          // Apply button
          Container(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _applyFilters,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3E8728),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Apply Filters',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewTypeFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Review Type',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildFilterChip(
              'All Reviews',
              _tempFilter.reviewType == null,
              () => setState(() => _tempFilter = _tempFilter.copyWith(reviewType: null)),
            ),
            _buildFilterChip(
              'Job Reviews',
              _tempFilter.reviewType == 'JOB_EMP_WORKER',
              () => setState(() => _tempFilter = _tempFilter.copyWith(reviewType: 'JOB_EMP_WORKER')),
            ),
            _buildFilterChip(
              'Employer Reviews',
              _tempFilter.reviewType == 'JOB_WORKER_EMP',
              () => setState(() => _tempFilter = _tempFilter.copyWith(reviewType: 'JOB_WORKER_EMP')),
            ),
            _buildFilterChip(
              'Service Reviews',
              _tempFilter.reviewType == 'SERVICE_CLIENT',
              () => setState(() => _tempFilter = _tempFilter.copyWith(reviewType: 'SERVICE_CLIENT')),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRatingFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Minimum Rating',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        
        Row(
          children: [1, 2, 3, 4, 5].map((rating) {
            final isSelected = _tempFilter.minRating == rating;
            return GestureDetector(
              onTap: () => setState(() => _tempFilter = _tempFilter.copyWith(
                minRating: isSelected ? null : rating,
              )),
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF3E8728) : Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected ? const Color(0xFF3E8728) : Colors.grey[300]!,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      size: 16,
                      color: isSelected ? Colors.white : Colors.amber,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$rating+',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? Colors.white : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSortingOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sort By',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        
        ...[
          ('created_at', 'Most Recent'),
          ('-created_at', 'Oldest First'),
          ('overall_rating', 'Highest Rated'),
          ('-overall_rating', 'Lowest Rated'),
        ].map((sortOption) {
          final isSelected = _tempFilter.sortBy == sortOption.$1;
          return RadioListTile<String>(
            title: Text(sortOption.$2),
            value: sortOption.$1,
            groupValue: _tempFilter.sortBy,
            onChanged: (value) => setState(() => _tempFilter = _tempFilter.copyWith(sortBy: value)),
            activeColor: const Color(0xFF3E8728),
            dense: true,
          );
        }).toList(),
      ],
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3E8728) : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF3E8728) : Colors.grey[300]!,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }

  void _applyFilters() {
    ref.read(reviewFilterProvider.notifier).state = _tempFilter;
    ref.read(reviewsReceivedProvider.notifier).refresh();
    Navigator.pop(context);
  }
}