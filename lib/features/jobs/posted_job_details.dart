// posted_job_details.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/job_model.dart';
import 'package:workdey_frontend/core/providers/post_job_provider.dart';
import 'package:workdey_frontend/features/jobs/confirmation_dialog.dart';
import 'package:workdey_frontend/screens/applicants_screen.dart';
import 'package:workdey_frontend/screens/postjob_form.dart';

class PostedJobDetails extends ConsumerWidget {
  final Job job;

  const PostedJobDetails({super.key, required this.job});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final salary = (job.jobType == 'PRO' || job.jobType == 'LOC')
        ? job.typeSpecific['salary']?.toString()
        : null;
    final salaryPeriod = job.typeSpecific['salary_period']?.toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _navigateToEditForm(context, job),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => _showDeleteConfirmation(context, ref, job.id),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            _buildHeaderSection(context),
            const SizedBox(height: 24),
            
            // Job details
            _buildDetailSection(
              title: 'Job Description',
              content: job.description,
            ),
            const SizedBox(height: 20),
            
            // Salary information if available
            if (salary != null) ...[
              _buildDetailSection(
                title: 'Salary',
                content: 'FCFA ${NumberFormat().format(double.tryParse(salary) ?? 0)} ${_getSalaryPeriodText(salaryPeriod)}',
              ),
              const SizedBox(height: 20),
            ],
            
            // Job metadata
            _buildMetaDataSection(),
            const SizedBox(height: 30),
            
            // Applicants button
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.people_alt_outlined),
                label: const Text('View Applicants'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                ),
                onPressed: () => _navigateToApplicants(context, job.id),
              ),
            ),
        )],
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          job.title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.location_on, size: 18, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Text(job.location),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: [
            Chip(
              label: Text(job.jobType),
              backgroundColor: Colors.grey[200],
            ),
            Chip(
              label: Text(job.category),
              backgroundColor: Colors.grey[200],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 15,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildMetaDataSection() {
    return Column(
      children: [
        _buildMetaDataRow('Due Date', 
          job.dueDate != null 
            ? DateFormat('MMM d, y').format(job.dueDate!)
            : 'Not specified'),
        const SizedBox(height: 12),
        _buildMetaDataRow('Job Nature', job.jobNature ?? 'Flexible'),
        const SizedBox(height: 12),
        _buildMetaDataRow('Posted Date', 
          DateFormat('MMM d, y').format(job.createdAt)),
      ],
    );
  }

  Widget _buildMetaDataRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
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

  void _navigateToEditForm(BuildContext context, Job job) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostJobForm(jobToEdit: job),
      ),
    );
  }

  Future<void> _showDeleteConfirmation(
    BuildContext context, 
    WidgetRef ref, 
    String jobId,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => const ConfirmationDialog(
        title: 'Delete Job',
        message: 'Are you sure you want to delete this job posting? This action cannot be undone.',
        confirmText: 'Delete',
        cancelText: 'Cancel',
      ),
    );

    if (confirmed == true) {
      await ref.read(postedJobsProvider.notifier).deleteJob(jobId);
      if (context.mounted) Navigator.pop(context);
    }
  }

  void _navigateToApplicants(BuildContext context, String jobId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ApplicantsScreen(jobId: jobId),
      ),
    );
  }
}