import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workdey_frontend/core/models/post_job_model.dart';

class PostedJobItem extends StatelessWidget {
  final PostJob job;
  final VoidCallback onTap;

  const PostedJobItem({
    super.key,
    required this.job,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Extract salary data from typeSpecific
    final salary = job.jobType == 'PRO' || job.jobType == 'LOC'
        ? job.typeSpecific['salary']?.toString()
        : null;
    final salaryPeriod = job.typeSpecific['salary_period']?.toString();

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Job title and basic info
              Text(
                job.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              
              // Location and type chips
              Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(job.location),
                  const Spacer(),
                  Chip(
                    label: Text(job.jobType),
                    backgroundColor: Colors.grey[200],
                  ),
                  const SizedBox(width: 8),
                  Chip(
                    label: Text(job.category),
                    backgroundColor: Colors.grey[200],
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Salary display (only for paid jobs)
              if (salary != null)
                Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.attach_money, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '${NumberFormat().format(double.parse(salary))} ${_getSalaryPeriodText(salaryPeriod)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                ),

              // Job description preview
              Text(
                job.description.length > 100
                    ? '${job.description.substring(0, 100)}...'
                    : job.description,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),

              // Job metadata
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildMetadataItem('Due Date', job.dueDate ?? 'Not specified'),
                  _buildMetadataItem('Nature', job.jobNature ?? 'Flexible'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetadataItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  String _getSalaryPeriodText(String? period) {
    switch (period) {
      case 'd': return '/day';
      case 'w': return '/week';
      case 'm': return '/month';
      default: return '';
    }
  }
}