import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';
import 'package:workdey_frontend/core/providers/saved_jobs_provider.dart';
import 'package:workdey_frontend/features/jobs/getjobs/job_bookmark.dart';
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

    return Container(
      margin: const EdgeInsets.only(bottom: 1), // Minimal gap like LinkedIn
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[300]!,
            width: 1.5,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showJobDetailsBottomSheet(context, job),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(isSaved),
                const SizedBox(height: 8),
                _buildJobTitle(),
                const SizedBox(height: 4),
                _buildCompanyInfo(),
                const SizedBox(height: 6),
                _buildLocation(),
                const SizedBox(height: 10),
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isSaved) {
    return Row(
      children: [
        // Post time
        Text(
          job.postTime ?? 'Recently',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Colors.red[600],
          ),
        ),
        const SizedBox(width: 8),
        // Job type chip
        _buildJobTypeChip(),
        const Spacer(),
        // Bookmark
        JobBookmarkWidget(
          jobId: job.id,
          isSaved: isSaved,
        ),
      ],
    );
  }

  Widget _buildJobTypeChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: _getJobTypeColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        _getJobTypeLabel(),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: _getJobTypeColor(),
        ),
      ),
    );
  }

  Widget _buildJobTitle() {
    return Text(
      job.title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.2,
        color: Color(0xFF181A1F),
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildCompanyInfo() {
    return Row(
      children: [
        // Company avatar
        CircleAvatar(
          radius: 10,
          backgroundColor: Colors.grey[200],
          backgroundImage: job.posterPicture != null 
              ? NetworkImage(job.posterPicture!) 
              : null,
          child: job.posterPicture == null 
              ? Icon(
                  Icons.person, 
                  size: 12, 
                  color: Colors.grey[600],
                )
              : null,
        ),
        const SizedBox(width: 6),
        // Company name
        Expanded(
          child: Text(
            job.posterName ?? 'Anonymous',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF181A1F),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 6),
        // Verification badges
        _buildVerificationBadges(),
      ],
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
          size: 12,
          color: verifiedCount == 3 ? Colors.green[600] : Colors.blue[600],
        ),
        if (verifiedCount < 3) ...[
          const SizedBox(width: 2),
          Text(
            '$verifiedCount/3',
            style: TextStyle(
              fontSize: 9,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildLocation() {
    return Row(
      children: [
        Icon(
          _getLocationIcon(),
          size: 12,
          color: Colors.grey[500],
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            job.locationDisplayText,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
              fontWeight: FontWeight.w400,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        // Distance info
        if (job.distanceText.isNotEmpty) ...[
          const SizedBox(width: 8),
          _buildDistanceChip(),
        ],
      ],
    );
  }

  Widget _buildDistanceChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: job.isAffordableForUser ? Colors.green[50] : Colors.orange[50],
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: job.isAffordableForUser ? Colors.green[300]! : Colors.orange[300]!,
          width: 0.5,
        ),
      ),
      child: Text(
        job.distanceText,
        style: TextStyle(
          fontSize: 9,
          color: job.isAffordableForUser ? Colors.green[700] : Colors.orange[700],
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Row(
      children: [
        // Job nature
        if (job.jobNature != null) ...[
          _buildInfoChip(job.jobNature!, Colors.grey),
          const SizedBox(width: 6),
        ],
        // Category
        _buildInfoChip(job.category, Colors.blue),
        const Spacer(),
        // Salary
        if (job.salaryDisplay != null)
          _buildSalaryChip(),
        // Application status
        if (job.hasApplied) ...[
          const SizedBox(width: 8),
          _buildAppliedChip(),
        ],
      ],
    );
  }

  Widget _buildInfoChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          color: Colors.green[700],
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildSalaryChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.green[200]!, width: 0.5),
      ),
      child: Text(
        job.salaryDisplay!,
        style: TextStyle(
          fontSize: 11,
          color: Colors.green[700],
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildAppliedChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.blue[200]!, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle,
            size: 10,
            color: Colors.blue[700],
          ),
          const SizedBox(width: 3),
          Text(
            'Applied',
            style: TextStyle(
              fontSize: 10,
              color: Colors.blue[700],
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // Helper methods
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

  Color _getJobTypeColor() {
    switch (job.jobType.toUpperCase()) {
      case 'PRO':
        return const Color(0xFF1976D2); // Blue
      case 'INT':
        return const Color(0xFF7B1FA2); // Purple
      case 'VOL':
        return const Color(0xFFF57C00); // Orange
      case 'LOC':
        return const Color(0xFF388E3C); // Green
      default:
        return Colors.grey[600]!;
    }
  }

  String _getJobTypeLabel() {
    switch (job.jobType.toUpperCase()) {
      case 'PRO':
        return 'Professional';
      case 'INT':
        return 'Internship';
      case 'VOL':
        return 'Volunteer';
      case 'LOC':
        return 'Local';
      default:
        return job.jobType;
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