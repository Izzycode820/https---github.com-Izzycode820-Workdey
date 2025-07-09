// lib/features/activity_center/widgets/activity_summary_card.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActivitySummaryCard extends StatelessWidget {
  final Map<String, int> summary;
  final bool hasActionItems;
  final DateTime lastRefresh;
  final VoidCallback onRefresh;
  final bool isRefreshing;

  const ActivitySummaryCard({
    super.key,
    required this.summary,
    required this.hasActionItems,
    required this.lastRefresh,
    required this.onRefresh,
    required this.isRefreshing,
  });

  @override
  Widget build(BuildContext context) {
    final totalItems = summary.values.fold<int>(0, (sum, count) => sum + count);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF3E8728).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.dashboard,
              color: Color(0xFF3E8728),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          
          // Title and subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'My Activities',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF181A1F),
                      ),
                    ),
                    if (hasActionItems) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'Action needed',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  totalItems > 0 
                      ? '$totalItems item${totalItems == 1 ? '' : 's'} • Updated ${_getTimeAgo(lastRefresh)}'
                      : 'Start your job search journey',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          
          // Stats preview (simplified)
          Row(
            children: [
              _buildMiniStat('${summary['savedJobs'] ?? 0}', Colors.blue),
              const SizedBox(width: 8),
              _buildMiniStat('${summary['applications'] ?? 0}', const Color(0xFF3E8728)),
              const SizedBox(width: 8),
              _buildMiniStat('${summary['reviews'] ?? 0}', Colors.amber),
              const SizedBox(width: 8),
              _buildMiniStat('${summary['savedWorkers'] ?? 0}', Colors.purple),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStat(String count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        count,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inMinutes < 1) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return DateFormat('MMM d, h:mm a').format(dateTime);
    }
  }
}