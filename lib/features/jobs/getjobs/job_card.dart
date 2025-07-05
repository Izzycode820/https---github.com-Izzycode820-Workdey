import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';
import 'package:workdey_frontend/core/providers/saved_jobs_provider.dart';
import 'package:workdey_frontend/features/jobs/getjobs/job_bookmark.dart';
import 'package:workdey_frontend/features/jobs/getjobs/job_detailes.dart';
import 'package:workdey_frontend/features/jobs/getjobs/job_details_bottom_sheet.dart';

class JobCard extends ConsumerWidget {
  final Job job;
  final Function(int)? onBookmarkPressed;

  const JobCard({
    super.key,
    required this.job,
    this.onBookmarkPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSaved = ref.watch(savedJobsProvider).maybeWhen(
      data: (data) => data.results.any((j) => j.id == job.id),
      orElse: () => job.isSaved,
    );

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showJobDetailsBottomSheet(context, job),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row: Post Time + Bookmark + Job Type
              Row(
                children: [
                  Text(
                    job.postTime ?? 'Recently',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.red[600],
                    ),
                  ),
                  const Spacer(),
                  _buildJobTypeChip(),
                  const SizedBox(width: 8),
                  JobBookmarkWidget(
                    jobId: job.id,
                    isSaved: isSaved,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              // Job Title (Main Focus)
              Text(
                job.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              
              // Location + Distance (One Line)
              Row(
                children: [
                  Icon(
                    _getLocationIcon(),
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      job.locationDisplayText,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (job.distanceText.isNotEmpty) ...[
                    const SizedBox(width: 8),
                    _buildDistanceChip(),
                  ],
                ],
              ),
              const SizedBox(height: 12),
              
              // Bottom Row: Poster + Verification + Salary
              Row(
                children: [
                  // Poster Name + Verification
                  Expanded(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundImage: job.posterPicture != null 
                              ? NetworkImage(job.posterPicture!) 
                              : null,
                          child: job.posterPicture == null 
                              ? Icon(Icons.person, size: 16, color: Colors.grey[600])
                              : null,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            job.posterName ?? 'Anonymous',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 4),
                        _buildVerificationBadges(),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Salary (Right Side)
                  if (job.salaryDisplay != null)
                    _buildSalaryChip(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildJobTypeChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getJobTypeColor(job.jobType),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        job.jobType,
        style: const TextStyle(
          fontSize: 11,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildDistanceChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: job.isAffordableForUser ? Colors.green[50] : Colors.orange[50],
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: job.isAffordableForUser ? Colors.green[300]! : Colors.orange[300]!,
          width: 0.5,
        ),
      ),
      child: Text(
        job.distanceText,
        style: TextStyle(
          fontSize: 10,
          color: job.isAffordableForUser ? Colors.green[700] : Colors.orange[700],
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildVerificationBadges() {
    if (job.verificationBadges == null) return const SizedBox.shrink();
    
    final badges = job.verificationBadges!;
    final verifiedCount = [
      badges['email'] == true,
      badges['phone'] == true,
      badges['id'] == true,
    ].where((v) => v).length;

    if (verifiedCount == 0) return const SizedBox.shrink();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.verified,
          size: 14,
          color: verifiedCount == 3 ? Colors.green : Colors.blue,
        ),
        if (verifiedCount < 3) ...[
          const SizedBox(width: 2),
          Text(
            '$verifiedCount/3',
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[600],
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSalaryChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green[200]!, width: 0.5),
      ),
      child: Text(
        job.salaryDisplay!,
        style: TextStyle(
          fontSize: 12,
          color: Colors.green[700],
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  IconData _getLocationIcon() {
    switch (job.locationAccuracy) {
      case 'gps':
        return Icons.gps_fixed;
      case 'zone':
        return Icons.location_on;
      case 'city':
        return Icons.location_city;
      default:
        return Icons.location_off;
    }
  }

  Color _getJobTypeColor(String type) {
    switch (type.toUpperCase()) {
      case 'PRO':
        return Colors.blue[600]!;
      case 'INT':
        return Colors.purple[600]!;
      case 'VOL':
        return Colors.orange[600]!;
      case 'LOC':
        return Colors.teal[600]!;
      default:
        return Colors.grey[600]!;
    }
  }
}

void _showJobDetailsBottomSheet(BuildContext context, Job job) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => JobDetailsBottomSheet(job: job),
  );
}