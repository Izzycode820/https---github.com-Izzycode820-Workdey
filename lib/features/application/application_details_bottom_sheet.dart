import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:workdey_frontend/core/models/applicant/applicant_model.dart';
import 'package:workdey_frontend/core/providers/applicantion_provider.dart';

class ApplicationBottomSheet extends ConsumerStatefulWidget {
  final Application application;
  final Function(String)? onStatusChanged;

  const ApplicationBottomSheet({
    super.key,
    required this.application,
    this.onStatusChanged,
  });

  @override
  ConsumerState<ApplicationBottomSheet> createState() => _ApplicationBottomSheetState();
}

class _ApplicationBottomSheetState extends ConsumerState<ApplicationBottomSheet> {
  bool _isUpdating = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final bottomSheetHeight = screenHeight * 0.6; // 60% height

    return Container(
      height: bottomSheetHeight,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          _buildHandle(),
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildApplicantInfo(),
                  const SizedBox(height: 20),
                  if (widget.application.matchStats != null) ...[
                    _buildMatchStats(),
                    const SizedBox(height: 20),
                  ],
                  if (widget.application.response?.skillsMet.isNotEmpty == true) ...[
                    _buildSkillsSection(),
                    const SizedBox(height: 20),
                  ],
                  _buildStatusSection(),
                  const SizedBox(height: 100), // Space for floating buttons
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHandle() {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 8),
      width: 32,
      height: 3,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.application.details.name.isNotEmpty 
                      ? widget.application.details.name 
                      : 'Anonymous Applicant',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    _buildStatusChip(),
                    const SizedBox(width: 8),
                    Text(
                      'Applied on ${DateFormat.yMMMd().format(widget.application.appliedAt)}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, size: 20),
            style: IconButton.styleFrom(
              backgroundColor: Colors.grey[100],
              padding: const EdgeInsets.all(8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip() {
    final color = _getStatusColor(widget.application.status);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        _getStatusText(widget.application.status),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget _buildApplicantInfo() {
    return _buildSection(
      title: 'Applicant Information',
      icon: Icons.person,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _getVerificationColor(widget.application.details.verification_level),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    widget.application.details.name.isNotEmpty 
                        ? widget.application.details.name[0].toUpperCase()
                        : '?',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.application.details.name.isNotEmpty 
                          ? widget.application.details.name 
                          : 'Anonymous',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    _buildVerificationBadge(),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildInfoRow('Jobs Completed', '${widget.application.details.completedJobs}'),
          _buildInfoRow('Verification Level', '${widget.application.details.verification_level}/3'),
        ],
      ),
    );
  }

  Widget _buildVerificationBadge() {
    final level = widget.application.details.verification_level;
    String text;
    Color color;
    IconData icon;
    
    switch (level) {
      case 3:
        text = 'FULLY VERIFIED';
        color = const Color(0xFF3E8728);
        icon = Icons.verified;
        break;
      case 2:
        text = 'PARTIALLY VERIFIED';
        color = Colors.orange;
        icon = Icons.verified_user;
        break;
      case 1:
        text = 'BASIC VERIFIED';
        color = Colors.blue;
        icon = Icons.check_circle;
        break;
      default:
        text = 'UNVERIFIED';
        color = Colors.grey;
        icon = Icons.help_outline;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 12),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchStats() {
    final stats = widget.application.matchStats!;
    final color = _getMatchColor(stats.percentage);
    
    return _buildSection(
      title: 'Match Statistics',
      icon: Icons.analytics,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.3), width: 0.5),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      '${stats.percentage.toInt()}%',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: color,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Overall Match',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: color,
                        ),
                      ),
                      Text(
                        'Skills alignment with job requirements',
                        style: TextStyle(
                          fontSize: 12,
                          color: color.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildMatchStatItem(
                    'Required Skills',
                    stats.requiredMatch,
                    Icons.star,
                    Colors.orange,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildMatchStatItem(
                    'Bonus Skills',
                    stats.optionalMatch.toString(),
                    Icons.star_border,
                    Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchStatItem(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsSection() {
    return _buildSection(
      title: 'Skills Matched',
      icon: Icons.psychology,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.application.response!.skillsMet.isNotEmpty) ...[
            const Text(
              'Required Skills Met',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF3E8728),
              ),
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: widget.application.response!.skillsMet
                  .map((skill) => _buildChip(skill, const Color(0xFF3E8728)))
                  .toList(),
            ),
          ],
          if (widget.application.response!.optionalSkillsMet.isNotEmpty) ...[
            const SizedBox(height: 12),
            const Text(
              'Bonus Skills Met',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: widget.application.response!.optionalSkillsMet
                  .map((skill) => _buildChip(skill, Colors.blue))
                  .toList(),
            ),
          ],
          if (widget.application.response!.notes.isNotEmpty) ...[
            const SizedBox(height: 12),
            const Text(
              'Application Notes',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.application.response!.notes,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusSection() {
    if (widget.application.status == 'PENDING') {
      return _buildActionButtons();
    } else {
      return _buildStatusInfo();
    }
  }

  Widget _buildActionButtons() {
    return _buildSection(
      title: 'Review Application',
      icon: Icons.rate_review,
      child: Column(
        children: [
          Text(
            'Make a decision on this application',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _isUpdating ? null : () => _updateApplicationStatus('REJECTED'),
                  icon: _isUpdating 
                      ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.close, size: 18),
                  label: const Text('Reject'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red[600],
                    side: BorderSide(color: Colors.red[600]!),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _isUpdating ? null : () => _updateApplicationStatus('APPROVED'),
                  icon: _isUpdating 
                      ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : const Icon(Icons.check, size: 18),
                  label: const Text('Approve'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3E8728),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusInfo() {
    final color = _getStatusColor(widget.application.status);
    final statusText = _getStatusText(widget.application.status);
    
    return _buildSection(
      title: 'Application Status',
      icon: Icons.info_outline,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.3), width: 0.5),
        ),
        child: Row(
          children: [
            Icon(_getStatusIcon(widget.application.status), color: color, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    statusText,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                  Text(
                    _getStatusDescription(widget.application.status),
                    style: TextStyle(
                      fontSize: 12,
                      color: color.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Status update method - FIXED with correct provider
  Future<void> _updateApplicationStatus(String newStatus) async {
    setState(() => _isUpdating = true);
    
    try {
      await ref.read(applicantServiceProvider).updateApplicationStatus(
        widget.application.id,
        newStatus,
      );
      
      if (mounted) {
        // Call the callback to refresh parent
        widget.onStatusChanged?.call(newStatus);
        
        // Close bottom sheet
        Navigator.pop(context);
        
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Application ${newStatus.toLowerCase()} successfully!',
            ),
            backgroundColor: newStatus == 'APPROVED' 
                ? const Color(0xFF3E8728) 
                : Colors.red[600],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update application: ${e.toString()}'),
            backgroundColor: Colors.red[600],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isUpdating = false);
      }
    }
  }

  // Helper widgets
  Widget _buildSection({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: Colors.grey[600]),
            const SizedBox(width: 6),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.3), width: 0.5),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // Helper methods
  Color _getVerificationColor(int level) {
    switch (level) {
      case 0: return Colors.grey[400]!;
      case 1: return Colors.orange[400]!;
      case 2: return Colors.blue[400]!;
      case 3:
      default: return Colors.green[400]!;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING': return Colors.orange[600]!;
      case 'APPROVED': return Colors.green[600]!;
      case 'REJECTED': return Colors.red[600]!;
      case 'IN_PROGRESS': return Colors.blue[600]!;
      case 'COMPLETED': return Colors.purple[600]!;
      default: return Colors.grey[600]!;
    }
  }

  String _getStatusText(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING': return 'Pending Review';
      case 'APPROVED': return 'Approved';
      case 'REJECTED': return 'Rejected';
      case 'IN_PROGRESS': return 'In Progress';
      case 'COMPLETED': return 'Completed';
      default: return status;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING': return Icons.schedule;
      case 'APPROVED': return Icons.check_circle;
      case 'REJECTED': return Icons.cancel;
      case 'IN_PROGRESS': return Icons.work;
      case 'COMPLETED': return Icons.task_alt;
      default: return Icons.help_outline;
    }
  }

  String _getStatusDescription(String status) {
    switch (status.toUpperCase()) {
      case 'APPROVED': return 'Application has been approved and work can begin';
      case 'REJECTED': return 'Application was not accepted for this position';
      case 'IN_PROGRESS': return 'Work is currently in progress';
      case 'COMPLETED': return 'Job has been successfully completed';
      default: return 'Application status';
    }
  }

  Color _getMatchColor(double percentage) {
    if (percentage >= 80) return Colors.green[600]!;
    if (percentage >= 60) return Colors.blue[600]!;
    if (percentage >= 40) return Colors.orange[600]!;
    return Colors.red[600]!;
  }
}