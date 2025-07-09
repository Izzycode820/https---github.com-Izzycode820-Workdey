import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';
import 'package:workdey_frontend/core/models/paginated_response/paginated_response.dart';
import 'package:workdey_frontend/core/providers/activity_state_provider.dart';
import 'package:workdey_frontend/features/activities/activity_state_builder.dart';
import 'package:workdey_frontend/features/jobs/getjobs/job_card.dart';

class SavedJobsActivityTab extends ConsumerStatefulWidget {
  const SavedJobsActivityTab({super.key});

  @override
  ConsumerState<SavedJobsActivityTab> createState() => _SavedJobsActivityTabState();
}

class _SavedJobsActivityTabState extends ConsumerState<SavedJobsActivityTab> {
  bool _isRefreshing = false;

  @override
  Widget build(BuildContext context) {
    final tabState = ref.watch(savedJobsTabProvider);

    return ActivityTabStateBuilder<PaginatedResponse<Job>>(
      tabState: tabState,
      onRefresh: () => _handleRefresh(),
      emptyTitle: 'No Saved Jobs Yet',
      emptyMessage: 'Start saving jobs you\'re interested in to see them here.',
      emptyIcon: Icons.bookmark_outline,
      emptyActionLabel: 'Browse Jobs',
      onEmptyAction: () => Navigator.pushNamed(context, '/find-jobs'),
      successBuilder: (context, paginatedJobs) {
        return Column(
          children: [
            // Thin refresh header
            _buildRefreshHeader(paginatedJobs.results.length),
            
            // Jobs list
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: paginatedJobs.results.length,
                itemBuilder: (context, index) {
                  final job = paginatedJobs.results[index];
                  return JobCard(
                    job: job,
                    onBookmarkPressed: (jobId) {
                      ref.read(activityCenterProvider.notifier)
                          .toggleJobSave(jobId, job.isSaved);
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRefreshHeader(int count) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          Text(
            '$count saved job${count == 1 ? '' : 's'}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: _isRefreshing ? null : _handleRefresh,
            borderRadius: BorderRadius.circular(6),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_isRefreshing)
                    SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[600]!),
                      ),
                    )
                  else
                    Icon(
                      Icons.refresh,
                      size: 14,
                      color: Colors.blue[600],
                    ),
                  const SizedBox(width: 4),
                  Text(
                    'Refresh',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleRefresh() async {
    if (_isRefreshing) return;
    
    setState(() => _isRefreshing = true);
    
    try {
      await ref.read(activityCenterProvider.notifier).refreshSingleTab(ActivityTab.savedJobs);
    } finally {
      if (mounted) {
        setState(() => _isRefreshing = false);
      }
    }
  }
}