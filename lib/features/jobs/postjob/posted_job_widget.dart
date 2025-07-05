import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';
import 'package:workdey_frontend/features/jobs/postjob/posted_job_bottom_sheet.dart';

class PostedJobItem extends StatelessWidget {
  final Job job;
  final VoidCallback onTap;

  const PostedJobItem({
    super.key,
    required this.job,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showJobDetailsBottomSheet(context),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row: Status + Job Type + Menu
              Row(
                children: [
                  _buildStatusChip(),
                  const Spacer(),
                  _buildJobTypeChip(),
                  const SizedBox(width: 8),
                  _buildMenuButton(context),
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
              
              // Location (One Line)
              Row(
                children: [
                  Icon(
                    Icons.location_on,
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
                ],
              ),
              const SizedBox(height: 12),
              
              // Bottom Row: Applications + Salary + Due Date
              Row(
                children: [
                  // Applications count
                  _buildApplicationsChip(),
                  const Spacer(),
                  // Salary (if applicable)
                  if (_getSalary() != null) ...[
                    _buildSalaryChip(),
                    const SizedBox(width: 8),
                  ],
                  // Due date
                  _buildDueDateChip(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip() {
    // You can customize this based on job status
    final isActive = job.dueDate?.isAfter(DateTime.now()) ?? true;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? Colors.green[50] : Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isActive ? Colors.green[200]! : Colors.grey[300]!,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isActive ? Icons.visibility : Icons.visibility_off,
            size: 12,
            color: isActive ? Colors.green[700] : Colors.grey[600],
          ),
          const SizedBox(width: 4),
          Text(
            isActive ? 'Active' : 'Expired',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isActive ? Colors.green[700] : Colors.grey[600],
            ),
          ),
        ],
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

  Widget _buildMenuButton(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert, size: 20, color: Colors.grey[600]),
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [
              Icon(Icons.edit, size: 16),
              SizedBox(width: 8),
              Text('Edit'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              Icon(Icons.delete, size: 16, color: Colors.red),
              SizedBox(width: 8),
              Text('Delete', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ],
      onSelected: (value) {
        if (value == 'edit') {
          // Handle edit
          onTap();
        } else if (value == 'delete') {
          // Handle delete with confirmation
          _showDeleteConfirmation(context);
        }
      },
    );
  }

  Widget _buildApplicationsChip() {
    // You'll need to add applications count to your Job model
    // For now, using a placeholder
    const applicationsCount = 0; // Replace with actual count
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.people, size: 12, color: Colors.blue[700]),
          const SizedBox(width: 4),
          Text(
            '$applicationsCount apps',
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
    final salary = _getSalary();
    if (salary == null) return const SizedBox.shrink();
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green[200]!),
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

  Widget _buildDueDateChip() {
    if (job.dueDate == null) return const SizedBox.shrink();
    
    final now = DateTime.now();
    final daysLeft = job.dueDate!.difference(now).inDays;
    final isUrgent = daysLeft <= 2;
    final isExpired = daysLeft < 0;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isExpired 
            ? Colors.red[50] 
            : isUrgent 
                ? Colors.orange[50] 
                : Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isExpired 
              ? Colors.red[200]! 
              : isUrgent 
                  ? Colors.orange[200]! 
                  : Colors.grey[300]!,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isExpired ? Icons.alarm_off : Icons.schedule,
            size: 12,
            color: isExpired 
                ? Colors.red[700] 
                : isUrgent 
                    ? Colors.orange[700] 
                    : Colors.grey[600],
          ),
          const SizedBox(width: 4),
          Text(
            isExpired 
                ? 'Expired' 
                : daysLeft == 0 
                    ? 'Today' 
                    : '${daysLeft}d left',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isExpired 
                  ? Colors.red[700] 
                  : isUrgent 
                      ? Colors.orange[700] 
                      : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  String? _getSalary() {
    if (job.jobType == 'PRO' || job.jobType == 'LOC') {
      final amount = job.typeSpecific['salary'];
      final period = job.typeSpecific['salary_period'] ?? 'd';
      if (amount != null) {
        return 'FCFA ${NumberFormat().format(amount)}/$period';
      }
    }
    return null;
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

  void _showJobDetailsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PostedJobDetailsBottomSheet(job: job),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Job'),
        content: const Text('Are you sure you want to delete this job posting? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Handle delete logic here
              onTap(); // You might want to pass a delete callback instead
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}