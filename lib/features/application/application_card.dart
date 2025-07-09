// application_card.dart - Minimal Design that opens Bottom Sheet
import 'package:flutter/material.dart';
import 'package:workdey_frontend/core/models/applicant/applicant_model.dart';
import 'package:workdey_frontend/features/application/application_details_bottom_sheet.dart';

class ApplicantCard extends StatelessWidget {
  final Application application;
  final bool isEmployerView;
  final Function(String)? onStatusChanged;

  const ApplicantCard({
    super.key,
    required this.application,
    this.isEmployerView = false,
    this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 1), // Minimal gap like LinkedIn
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[200]!,
            width: 0.5,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEmployerView 
              ? () => _showApplicationBottomSheet(context)
              : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 8),
                _buildQuickInfo(),
                if (!isEmployerView) ...[
                  const SizedBox(height:8),
                  _buildApplicationDetails(),
                ],
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
        // Profile Avatar
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: _getVerificationColor(application.details.verification_level),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              application.details.name.isNotEmpty 
                  ? application.details.name[0].toUpperCase()
                  : '?',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        
        // Name and Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      application.details.name,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF181A1F),
                      ),
                    ),
                  ),
                  _buildVerificationBadge(application.details.verification_level),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.work_history,
                    size: 14,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${application.details.completedJobs} jobs completed',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        // Status Badge
        _buildStatusChip(application.status),
      ],
    );
  }

  Widget _buildQuickInfo() {
    return Row(
      children: [
        // Applied Date
        Expanded(
          child: Row(
            children: [
              Icon(
                Icons.schedule,
                size: 14,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 4),
              Text(
                'Applied ${_getTimeAgo(application.appliedAt)}',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        
        // Match Percentage (if available)
        if (application.matchStats != null && isEmployerView)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _getMatchColor(application.matchStats!.percentage).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _getMatchColor(application.matchStats!.percentage).withOpacity(0.3),
              ),
            ),
            child: Text(
              '${application.matchStats!.percentage.toStringAsFixed(0)}% match',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: _getMatchColor(application.matchStats!.percentage),
              ),
            ),
          ),
        
        // Tap indicator for employer view
        if (isEmployerView) ...[
          const SizedBox(width: 8),
          Icon(
            Icons.chevron_right,
            size: 20,
            color: Colors.grey[400],
          ),
        ],
      ],
    );
  }

  Widget _buildApplicationDetails() {
    // Only show for non-employer view (My Applications screen)
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (application.response?.skillsMet.isNotEmpty ?? false) ...[
          const Text(
            'Skills Matched:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF181A1F),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: application.response!.skillsMet
                .take(3) // Show only first 3 skills
                .map((skill) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3E8728).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        skill,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF3E8728),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ],
    );
  }

  void _showApplicationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ApplicationBottomSheet(
        application: application,
        onStatusChanged: onStatusChanged,
      ),
    );
  }

  Widget _buildVerificationBadge(int verificationLevel) {
    String text;
    Color color;
    
    switch (verificationLevel) {
      case 3:
        text = 'VERIFIED';
        color = const Color(0xFF3E8728);
        break;
      case 2:
        text = 'PARTIAL';
        color = Colors.orange;
        break;
      case 1:
        text = 'BASIC';
        color = Colors.blue;
        break;
      default:
        text = 'UNVERIFIED';
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Inter',
          color: color,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _getStatusColor(status),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        _getStatusDisplay(status),
        style: TextStyle(
          fontFamily: 'Inter',
          color: _getStatusTextColor(status),
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inMinutes}m ago';
    }
  }

  String _getStatusDisplay(String status) {
    switch (status.toUpperCase()) {
      case 'IN_PROGRESS':
        return 'ACTIVE';
      case 'COMPLETED':
        return 'DONE';
      default:
        return status.toUpperCase();
    }
  }

  Color _getVerificationColor(int level) {
    switch (level) {
      case 3: return const Color(0xFF3E8728);
      case 2: return Colors.orange;
      case 1: return Colors.blue;
      default: return Colors.grey;
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

  Color _getMatchColor(double percentage) {
    if (percentage >= 80) return const Color(0xFF3E8728);
    if (percentage >= 60) return Colors.orange;
    if (percentage >= 40) return Colors.amber;
    return Colors.red;
  }
}