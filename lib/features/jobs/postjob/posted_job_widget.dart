import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';
import 'package:workdey_frontend/features/jobs/postjob/posted_job_bottom_sheet.dart';

// ============================================================================
// CLEAN POSTED JOB CARD - Edge-to-edge, mature, LinkedIn-like design
// ============================================================================

class CleanPostedJobCard extends StatelessWidget {
  final Job job;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const CleanPostedJobCard({
    super.key,
    required this.job,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 1), // Minimal gap between cards
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
          onTap: () => _showJobDetailsBottomSheet(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 8),
                _buildJobTitle(),
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

  Widget _buildHeader() {
    return Row(
      children: [
        _buildStatusIndicator(),
        const SizedBox(width: 8),
        _buildJobTypeChip(),
        const Spacer(),
        _buildPostedTime(),
        const SizedBox(width: 8),
        _buildMenuButton(),
      ],
    );
  }

  Widget _buildStatusIndicator() {
    final isActive = _isJobActive();
    final daysLeft = _getDaysLeft();
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: isActive ? Colors.green[50] : Colors.red[50],
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isActive ? Colors.green[200]! : Colors.red[200]!,
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: isActive ? Colors.green[600] : Colors.red[600],
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            isActive ? (daysLeft > 0 ? 'Active' : 'Expires today') : 'Expired',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: isActive ? Colors.green[700] : Colors.red[700],
            ),
          ),
        ],
      ),
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

  Widget _buildPostedTime() {
    return Text(
      job.postTime ?? 'Recently',
      style: TextStyle(
        fontSize: 11,
        color: Colors.grey[600],
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildMenuButton() {
    return Builder(
      builder: (context) => InkWell(
        onTap: () => _showMenuOptions(context),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(
            Icons.more_horiz,
            size: 16,
            color: Colors.grey[600],
          ),
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

  Widget _buildLocation() {
    return Row(
      children: [
        Icon(
          Icons.location_on,
          size: 12,
          color: Colors.grey[500],
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            _getLocationText(),
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
              fontWeight: FontWeight.w400,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Row(
      children: [
        _buildApplicationsCount(),
        const SizedBox(width: 12),
        if (_hasSalary()) ...[
          _buildSalaryChip(),
          const SizedBox(width: 12),
        ],
        const Spacer(),
        _buildTimeLeft(),
      ],
    );
  }

  Widget _buildApplicationsCount() {
    // You might want to get actual count from your provider
    const applicationsCount = 0; // Replace with actual count
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.people,
            size: 12,
            color: Colors.blue[600],
          ),
          const SizedBox(width: 3),
          Text(
            '$applicationsCount',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.blue[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSalaryChip() {
    final salary = _getSalaryText();
    if (salary == null) return const SizedBox.shrink();
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        salary,
        style: TextStyle(
          fontSize: 11,
          color: Colors.green[700],
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildTimeLeft() {
    final daysLeft = _getDaysLeft();
    final isUrgent = daysLeft <= 3 && daysLeft > 0;
    final isExpired = daysLeft < 0;
    
    Color color;
    String text;
    
    if (isExpired) {
      color = Colors.red[600]!;
      text = 'Expired';
    } else if (daysLeft == 0) {
      color = Colors.orange[600]!;
      text = 'Today';
    } else if (isUrgent) {
      color = Colors.orange[600]!;
      text = '${daysLeft}d left';
    } else {
      color = Colors.grey[600]!;
      text = '${daysLeft}d left';
    }
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isExpired ? Icons.schedule : Icons.access_time,
          size: 12,
          color: color,
        ),
        const SizedBox(width: 3),
        Text(
          text,
          style: TextStyle(
            fontSize: 11,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Helper methods
  bool _isJobActive() {
    return job.dueDate?.isAfter(DateTime.now()) ?? true;
  }

  int _getDaysLeft() {
    if (job.dueDate == null) return 30; // Default
    return job.dueDate!.difference(DateTime.now()).inDays;
  }

  String _getLocationText() {
    if (job.city != null && job.district != null) {
      return '${job.district}, ${job.city}';
    } else if (job.city != null) {
      return job.city!;
    } else if (job.location != null) {
      return job.location!;
    }
    return 'Location not specified';
  }

  Color _getJobTypeColor() {
    switch (job.jobType.toUpperCase()) {
      case 'PRO':
        return const Color(0xFF1976D2); // Blue
      case 'LOC':
        return const Color(0xFF388E3C); // Green
      case 'INT':
        return const Color(0xFF7B1FA2); // Purple
      case 'VOL':
        return const Color(0xFFF57C00); // Orange
      default:
        return Colors.grey[600]!;
    }
  }

  String _getJobTypeLabel() {
    switch (job.jobType.toUpperCase()) {
      case 'PRO':
        return 'Professional';
      case 'LOC':
        return 'Local';
      case 'INT':
        return 'Internship';
      case 'VOL':
        return 'Volunteer';
      default:
        return job.jobType;
    }
  }

  bool _hasSalary() {
    return job.jobType == 'PRO' || job.jobType == 'LOC';
  }

  String? _getSalaryText() {
    if (!_hasSalary()) return null;
    
    final amount = job.typeSpecific['salary'];
    final period = job.typeSpecific['salary_period'] ?? 'd';
    
    if (amount != null) {
      final formattedAmount = NumberFormat.compact().format(amount);
      return 'FCFA $formattedAmount/$period';
    }
    
    return null;
  }

  void _showJobDetailsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CleanPostedJobBottomSheet(job: job),
    );
  }

  void _showMenuOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 32,
              height: 3,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            
            // Edit option
            ListTile(
              leading: Icon(Icons.edit, color: Colors.blue[600]),
              title: const Text('Edit Job'),
              onTap: () {
                Navigator.pop(context);
                if (onEdit != null) onEdit!();
              },
            ),
            
            // View applicants option
            ListTile(
              leading: Icon(Icons.people, color: Colors.green[600]),
              title: const Text('View Applicants'),
              onTap: () {
                Navigator.pop(context);
                _showJobDetailsBottomSheet(context);
              },
            ),
            
            // Delete option
            ListTile(
              leading: Icon(Icons.delete, color: Colors.red[600]),
              title: const Text('Delete Job'),
              onTap: () {
                Navigator.pop(context);
                _showDeleteConfirmation(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Job'),
        content: const Text(
          'Are you sure you want to delete this job posting? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (onDelete != null) onDelete!();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}