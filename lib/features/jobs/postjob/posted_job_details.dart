// posted_job_details.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';
import 'package:workdey_frontend/core/providers/post_job_provider.dart';
import 'package:workdey_frontend/features/jobs/postjob/confirmation_dialog.dart';
import 'package:workdey_frontend/screens/applicants_screen.dart';
import 'package:workdey_frontend/screens/edit_job_screen.dart';

class PostedJobDetails extends ConsumerStatefulWidget {
  final Job job;

  const PostedJobDetails({super.key, required this.job});

  @override
  ConsumerState<PostedJobDetails> createState() => _PostedJobDetailsState();
}

class _PostedJobDetailsState extends ConsumerState<PostedJobDetails> {
  bool _showFullDescription = false;
  bool _showFullRoles = false;

  @override
  Widget build(BuildContext context) {
    final salary = (widget.job.jobType == 'PRO' || widget.job.jobType == 'LOC')
        ? widget.job.typeSpecific['salary']?.toString()
        : null;
    final salaryPeriod = widget.job.typeSpecific['salary_period']?.toString();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FC),
      appBar: AppBar(
        title: Text(
          widget.job.title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _navigateToEditForm(context, widget.job),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => _showDeleteConfirmation(context, ref, widget.job.id),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              children: [
                // Header Section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 32,
                            backgroundImage: widget.job.posterPicture != null 
                                ? NetworkImage(widget.job.posterPicture!) 
                                : null,
                            child: widget.job.posterPicture == null 
                                ? const Icon(Icons.person, size: 32) 
                                : null,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.job.title,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 26,
                                    height: 1.2,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Posted by: ${widget.job.poster}',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: Colors.black.withOpacity(0.8),
                                  ),
                                ),
                                if (widget.job.postTime != null) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    widget.job.postTime!,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          if (widget.job.expiresIn != null)
                            _DetailChip(
                              icon: Icons.calendar_today,
                              label: widget.job.expiresIn!,
                            ),
                          const SizedBox(width: 8),
                          _DetailChip(
                            icon: Icons.work_outline,
                            label: widget.job.jobType,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Job Info Sections
                _buildSection(
                  title: 'Description',
                  content: widget.job.description,
                  expanded: _showFullDescription,
                  onExpand: () => setState(() => _showFullDescription = !_showFullDescription),
                ),

                if (widget.job.rolesDescription != null)
                  _buildSection(
                    title: 'Roles and Responsibilities',
                    content: widget.job.rolesDescription!,
                    expanded: _showFullRoles,
                    onExpand: () => setState(() => _showFullRoles = !_showFullRoles),
                  ),

                if (salary != null)
                  _buildSection(
                    title: 'Salary',
                    content: 'FCFA ${NumberFormat().format(double.tryParse(salary) ?? 0)} ${_getSalaryPeriodText(salaryPeriod)}',
                  ),

                if (widget.job.requirements != null && widget.job.requirements!.isNotEmpty)
                  _buildSection(
                    title: 'Requirements',
                    content: widget.job.requirements!.map((r) => '• $r').join('\n'),
                  ),

                if (widget.job.workingDays != null)
                  _buildSection(
                    title: 'Working Days',
                    content: widget.job.workingDays!.join(', '),
                  ),
                  if (widget.job.city != null)
                      _buildSection(
                        title: 'City',
                        content: widget.job.city!,
                      ),

                    if (widget.job.district != null)
                      _buildSection(
                        title: 'District',
                        content: widget.job.district!,
                      ),

                if (widget.job.category != null)
                  _buildSection(
                    title: 'Category',
                    content: widget.job.category!,
                  ),

                if (widget.job.jobNature != null)
                  _buildSection(
                    title: 'Job Nature',
                    content: widget.job.jobNature!,
                  ),
                if (widget.job.requiredSkills != null && widget.job.requiredSkills!.isNotEmpty)
                      _buildSection(
                        title: 'Required Skills',
                        content: widget.job.requiredSkills!.map((s) => '• $s').join('\n'),
                      ),

                    if (widget.job.optionalSkills != null && widget.job.optionalSkills!.isNotEmpty)
                      _buildSection(
                        title: 'Bonus Skills',
                        content: widget.job.optionalSkills!.map((s) => '• $s').join('\n'),
  ),

                const SizedBox(height: 24),
              ],
            ),
          ),

          // Floating Applicants Button
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: SizedBox(
              height: 52,
              child: FilledButton.icon(
                icon: const Icon(Icons.people_alt_outlined),
                label: const Text('View Applicants'),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF3E8728),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  shadowColor: const Color(0xFF1C58F2).withOpacity(0.1),
                ),
                onPressed: () => _navigateToApplicants(context, widget.job.id),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String content,
    bool expanded = false,
    VoidCallback? onExpand,
  }) {
    const maxLines = 3;
    final shouldShowExpand = content.split('\n').length > maxLines || 
                         content.length > 150;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(24),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 11.5,
              letterSpacing: 0.75,
              color: Colors.black.withOpacity(0.75),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 14,
              height: 1.5,
            ),
            maxLines: expanded ? null : maxLines,
            overflow: expanded ? null : TextOverflow.ellipsis,
          ),
          if (shouldShowExpand && onExpand != null) ...[
            const SizedBox(height: 8),
            GestureDetector(
              onTap: onExpand,
              child: Text(
                expanded ? 'SHOW LESS' : 'READ MORE',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  letterSpacing: 0.25,
                  color: Color(0xFF3E8728),
                ),
              ),
            ),
          ],
        ],
      ),
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
      builder: (context) => EditJobScreen(job: job),
    ),
  );
}

  Future<void> _showDeleteConfirmation(
    BuildContext context, 
    WidgetRef ref, 
    int jobId,
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
      await ref.read(postedJobsProvider.notifier).removeJob(jobId);
      if (context.mounted) Navigator.pop(context);
    }
  }

  void _navigateToApplicants(BuildContext context, int jobId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ApplicantsScreen(jobId: jobId),
      ),
    );
  }
}

class _DetailChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  
  const _DetailChip({required this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: icon != null 
          ? const EdgeInsets.only(left: 4, right: 8)
          : EdgeInsets.zero,
      label: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ),
      avatar: icon != null 
          ? Icon(icon, size: 16, color: Colors.grey[600])
          : null,
      backgroundColor: Colors.grey[200],
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }
}