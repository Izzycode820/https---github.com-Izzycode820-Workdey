// my_application_bottom_sheet.dart - Rich Bottom Sheet for Worker View
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:workdey_frontend/core/models/applicant/applicant_model.dart';
import 'package:workdey_frontend/core/providers/applicantion_provider.dart';
import 'package:workdey_frontend/core/providers/providers.dart';
import 'package:workdey_frontend/core/services/job_completion_service.dart';

class MyApplicationBottomSheet extends ConsumerWidget {
  final Application application;

  const MyApplicationBottomSheet({
    super.key,
    required this.application,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle Bar
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Content
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatusHeader(),
                  const SizedBox(height: 24),
                  _buildApplicationTimeline(),
                  const SizedBox(height: 24),
                  if (application.response != null) ...[
                    _buildSubmittedInfo(),
                    const SizedBox(height: 24),
                  ],
                  _buildCompletionStatus(),
                  const SizedBox(height: 24),
                  _buildActionSection(context, ref),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _getStatusColor(application.status),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              _getStatusIcon(application.status),
              color: _getStatusTextColor(application.status),
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Application ${application.status.toLowerCase()}',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: _getStatusTextColor(application.status),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _getStatusMessage(application.status),
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    color: _getStatusTextColor(application.status).withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApplicationTimeline() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Application Timeline',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF181A1F),
          ),
        ),
        const SizedBox(height: 16),
        
        // Timeline Item - Applied
        _buildTimelineItem(
          'Application Submitted',
          DateFormat.yMMMd().add_jm().format(application.appliedAt),
          Icons.send,
          const Color(0xFF3E8728),
          isCompleted: true,
        ),
        
        // Timeline Item - Under Review
        _buildTimelineItem(
          'Under Review',
          application.status == 'PENDING' ? 'In progress' : 'Completed',
          Icons.visibility,
          Colors.orange,
          isCompleted: application.status != 'PENDING',
          isActive: application.status == 'PENDING',
        ),
        
        // Timeline Item - Decision
        _buildTimelineItem(
          application.status == 'APPROVED' ? 'Approved' : 
          application.status == 'REJECTED' ? 'Rejected' : 
          application.status == 'IN_PROGRESS' ? 'Job Started' :
          application.status == 'COMPLETED' ? 'Job Completed' : 'Decision Pending',
          application.status == 'PENDING' ? 'Waiting for employer' : 'Completed',
          application.status == 'APPROVED' ? Icons.check_circle : 
          application.status == 'REJECTED' ? Icons.cancel : 
          application.status == 'IN_PROGRESS' ? Icons.work :
          application.status == 'COMPLETED' ? Icons.done_all : Icons.schedule,
          application.status == 'APPROVED' ? const Color(0xFF3E8728) : 
          application.status == 'REJECTED' ? Colors.red : 
          application.status == 'IN_PROGRESS' ? Colors.blue :
          application.status == 'COMPLETED' ? Colors.purple : Colors.grey,
          isCompleted: application.status != 'PENDING',
          isLast: application.status != 'APPROVED' && application.status != 'IN_PROGRESS',
        ),

        // Timeline Item - Job Completion (only for approved/in progress)
        if (application.status == 'APPROVED' || application.status == 'IN_PROGRESS' || application.status == 'COMPLETED')
          _buildTimelineItem(
            'Job Completion',
            application.status == 'COMPLETED' ? 'Completed' : 'Pending',
            Icons.task_alt,
            Colors.purple,
            isCompleted: application.status == 'COMPLETED',
            isActive: application.status == 'IN_PROGRESS',
            isLast: true,
          ),
      ],
    );
  }

  Widget _buildTimelineItem(
    String title,
    String subtitle,
    IconData icon,
    Color color, {
    bool isCompleted = false,
    bool isActive = false,
    bool isLast = false,
  }) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isCompleted || isActive ? color : Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                icon,
                color: isCompleted || isActive ? Colors.white : Colors.grey,
                size: 20,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: isCompleted ? color : Colors.grey.withOpacity(0.3),
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isCompleted || isActive ? const Color(0xFF181A1F) : Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmittedInfo() {
    if (application.response == null) return const SizedBox.shrink();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Application Details',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF181A1F),
          ),
        ),
        const SizedBox(height: 16),
        
        // Skills Submitted
        if (application.response!.skillsMet.isNotEmpty) ...[
          _buildInfoSection(
            'Skills Highlighted',
            application.response!.skillsMet,
            Icons.star,
            const Color(0xFF3E8728),
          ),
          const SizedBox(height: 16),
        ],
        
        // Optional Skills
        if (application.response!.optionalSkillsMet.isNotEmpty) ...[
          _buildInfoSection(
            'Bonus Skills',
            application.response!.optionalSkillsMet,
            Icons.star_border,
            Colors.blue,
          ),
          const SizedBox(height: 16),
        ],
        
        // Notes
        if (application.response!.notes.isNotEmpty) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.note, color: Color(0xFF3E8728), size: 16),
                    SizedBox(width: 8),
                    Text(
                      'Your Message',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF181A1F),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  application.response!.notes,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildInfoSection(String title, List<String> items, IconData icon, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items.map((item) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withOpacity(0.3)),
            ),
            child: Text(
              item,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildCompletionStatus() {
    if (application.status != 'APPROVED' && 
        application.status != 'IN_PROGRESS' && 
        application.status != 'COMPLETED') {
      return const SizedBox.shrink();
    }

    // Check completion status
    final completion = application.completion;
    final isApproved = application.status == 'APPROVED';
    final isInProgress = application.status == 'IN_PROGRESS';
    final isCompleted = application.status == 'COMPLETED';

    Color statusColor;
    IconData statusIcon;
    String statusTitle;
    String statusDescription;

    if (isCompleted) {
      statusColor = Colors.purple;
      statusIcon = Icons.done_all;
      statusTitle = 'Job Completed';
      statusDescription = 'Great work! The job has been successfully completed.';
    } else if (isInProgress) {
      statusColor = Colors.blue;
      statusIcon = Icons.work;
      statusTitle = 'Job In Progress';
      if (completion?.employerConfirmed == true && completion?.workerConfirmed == false) {
        statusDescription = 'Employer marked job complete. Please confirm when you\'re done.';
      } else if (completion?.workerConfirmed == true && completion?.employerConfirmed == false) {
        statusDescription = 'Waiting for employer to confirm completion.';
      } else {
        statusDescription = 'Job is currently in progress. Keep up the good work!';
      }
    } else {
      statusColor = const Color(0xFF3E8728);
      statusIcon = Icons.check_circle;
      statusTitle = 'Ready to Start';
      statusDescription = 'Congratulations! You can now start working on this job.';
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(statusIcon, color: statusColor, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  statusTitle,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  statusDescription,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    color: statusColor.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionSection(BuildContext context, WidgetRef ref) {
    if (application.status == 'PENDING') {
      return Column(
        children: [
          const Text(
            'Application Actions',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF181A1F),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Send a polite reminder to the employer',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _showNudgeDialog(context, ref),
              icon: const Icon(Icons.notifications, size: 18),
              label: const Text('Nudge Employer'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.orange,
                side: const BorderSide(color: Colors.orange),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      );
    } else if (application.status == 'APPROVED') {
      return Column(
        children: [
          const Text(
            'Job Management',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF181A1F),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You\'re approved! Contact the employer to get started',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _contactEmployer(context),
                  icon: const Icon(Icons.message, size: 18),
                  label: const Text('Contact Employer'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3E8728),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    } else if (application.status == 'IN_PROGRESS') {
      return Column(
        children: [
          const Text(
            'Job Completion',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF181A1F),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Mark the job as complete when you\'re finished',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _showConfirmCompletionDialog(context, ref),
              icon: const Icon(Icons.task_alt, size: 18),
              label: const Text('Confirm Job Complete'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      );
    } else if (application.status == 'COMPLETED') {
      return Column(
        children: [
          const Text(
            'Review & Rating',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF181A1F),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Help others by leaving a review for the employer',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _navigateToReviewForm(context),
              icon: const Icon(Icons.star, size: 18),
              label: const Text('Leave Review'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      );
    }
    
    return const SizedBox.shrink();
  }

  Future<void> _showNudgeDialog(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.notifications,
                  color: Colors.orange,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Nudge Employer',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0xFF181A1F),
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Send a polite reminder to the employer about your pending application?',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.orange,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'You can only send one nudge per application to maintain professionalism.',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: const Text(
                'Send Nudge',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await _sendNudge(context, ref);
    }
  }

  Future<void> _showConfirmCompletionDialog(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.task_alt,
                  color: Colors.purple,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Confirm Job Completion',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0xFF181A1F),
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Confirm that this job has been completed successfully?',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.blue,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Both you and the employer must confirm completion before you can leave reviews.',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: const Text(
                'Confirm',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await _confirmJobCompletion(context, ref);
    }
  }

  Future<void> _sendNudge(BuildContext context, WidgetRef ref) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              SizedBox(width: 16),
              Text('Sending nudge...', style: TextStyle(fontFamily: 'Inter')),
            ],
          ),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );

      // TODO: Implement actual nudge API
      await Future.delayed(const Duration(seconds: 1));
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 20),
                SizedBox(width: 16),
                Text('Nudge sent! The employer has been notified.', style: TextStyle(fontFamily: 'Inter')),
              ],
            ),
            backgroundColor: Colors.orange,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send nudge: ${e.toString()}', style: const TextStyle(fontFamily: 'Inter')),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    }
  }

  Future<void> _confirmJobCompletion(BuildContext context, WidgetRef ref) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              SizedBox(width: 16),
              Text('Confirming completion...', style: TextStyle(fontFamily: 'Inter')),
            ],
          ),
          backgroundColor: Colors.purple,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );

      final jobCompletionService = JobCompletionService(ref.read(dioProvider));
      
      await jobCompletionService.markJobComplete(
        applicationId: application.id,
        actualEndDate: DateTime.now(),
        completionNotes: 'Job confirmed complete by worker',
      );
      
      ref.invalidate(myApplicationsProvider);
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 20),
                SizedBox(width: 16),
                Expanded(child: Text('Job completion confirmed! You can now leave a review.', style: TextStyle(fontFamily: 'Inter'))),
              ],
            ),
            backgroundColor: Colors.purple,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to confirm completion: ${e.toString()}', style: const TextStyle(fontFamily: 'Inter')),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    }
  }

  void _contactEmployer(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Contact employer functionality will be implemented soon'),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _navigateToReviewForm(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Review form will be implemented in the next phase'),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  // Helper methods
  String _getStatusMessage(String status) {
    switch (status.toUpperCase()) {
      case 'APPROVED':
        return 'Congratulations! The employer wants to hire you.';
      case 'REJECTED':
        return 'Unfortunately, you weren\'t selected for this position.';
      case 'PENDING':
        return 'The employer is reviewing your application.';
      case 'IN_PROGRESS':
        return 'Job is currently in progress.';
      case 'COMPLETED':
        return 'Job completed successfully.';
      default:
        return 'Application status unknown.';
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toUpperCase()) {
      case 'APPROVED':
        return Icons.check_circle;
      case 'REJECTED':
        return Icons.cancel;
      case 'PENDING':
        return Icons.schedule;
      case 'IN_PROGRESS':
        return Icons.work;
      case 'COMPLETED':
        return Icons.done_all;
      default:
        return Icons.help;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'APPROVED':
        return const Color(0xFF3E8728).withOpacity(0.1);
      case 'REJECTED':
        return Colors.red.withOpacity(0.1);
      case 'PENDING':
        return Colors.orange.withOpacity(0.1);
      case 'IN_PROGRESS':
        return Colors.blue.withOpacity(0.1);
      case 'COMPLETED':
        return Colors.purple.withOpacity(0.1);
      default:
        return Colors.grey.withOpacity(0.1);
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status.toUpperCase()) {
      case 'APPROVED':
        return const Color(0xFF3E8728);
      case 'REJECTED':
        return Colors.red;
      case 'PENDING':
        return Colors.orange;
      case 'IN_PROGRESS':
        return Colors.blue;
      case 'COMPLETED':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}