// application_details_bottom_sheet.dart - Rich Bottom Sheet with Full Details and Management
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workdey_frontend/core/models/applicant/applicant_model.dart';

class ApplicationBottomSheet extends StatelessWidget {
  final Application application;
  final Function(String)? onStatusChanged;

  const ApplicationBottomSheet({
    super.key,
    required this.application,
    this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
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
                  _buildHeader(),
                  const SizedBox(height: 24),
                  if (application.matchStats != null) ...[
                    _buildMatchStats(),
                    const SizedBox(height: 24),
                  ],
                  if (application.response != null) ...[
                    _buildSkillsSection(),
                    const SizedBox(height: 24),
                  ],
                  _buildStatusActions(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: _getVerificationColor(application.details.verification_level),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              application.details.name.isNotEmpty 
                  ? application.details.name[0].toUpperCase()
                  : '?',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                application.details.name,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF181A1F),
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.work_history,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${application.details.completedJobs} jobs completed',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Applied on ${DateFormat.yMMMd().format(application.appliedAt)}',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _buildVerificationBadge(application.details.verification_level),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVerificationBadge(int verificationLevel) {
    String text;
    Color color;
    IconData icon;
    
    switch (verificationLevel) {
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Inter',
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchStats() {
    if (application.matchStats == null) return const SizedBox.shrink();
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _getMatchColor(application.matchStats!.percentage).withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _getMatchColor(application.matchStats!.percentage).withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Match Analysis',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF181A1F),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${application.matchStats!.percentage.toStringAsFixed(1)}%',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: _getMatchColor(application.matchStats!.percentage),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Overall Match',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  value: application.matchStats!.percentage / 100,
                  strokeWidth: 8,
                  backgroundColor: Colors.grey.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getMatchColor(application.matchStats!.percentage),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildMatchStatItem(
                  'Required Skills',
                  application.matchStats!.requiredMatch,
                  Icons.star,
                  Colors.orange,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildMatchStatItem(
                  'Bonus Skills',
                  application.matchStats!.optionalMatch.toString(),
                  Icons.star_border,
                  Colors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMatchStatItem(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF181A1F),
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsSection() {
    if (application.response == null) return const SizedBox.shrink();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Application Details',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF181A1F),
          ),
        ),
        const SizedBox(height: 16),
        
        // Required Skills
        if (application.response!.skillsMet.isNotEmpty) ...[
          _buildSkillCategory(
            'Required Skills Matched',
            application.response!.skillsMet,
            const Color(0xFF3E8728),
            Icons.check_circle,
          ),
          const SizedBox(height: 16),
        ],
        
        // Optional Skills
        if (application.response!.optionalSkillsMet.isNotEmpty) ...[
          _buildSkillCategory(
            'Bonus Skills',
            application.response!.optionalSkillsMet,
            Colors.blue,
            Icons.star,
          ),
          const SizedBox(height: 16),
        ],
        
        // Notes
        if (application.response!.notes.isNotEmpty) ...[
          const Text(
            'Additional Message',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF181A1F),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              application.response!.notes,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSkillCategory(String title, List<String> skills, Color color, IconData icon) {
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
                fontSize: 16,
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
          children: skills.map((skill) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withOpacity(0.3)),
            ),
            child: Text(
              skill,
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

  Widget _buildStatusActions(BuildContext context) {
    if (application.status == 'APPROVED' || application.status == 'REJECTED') {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _getStatusColor(application.status),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              application.status == 'APPROVED' ? Icons.check_circle : Icons.cancel,
              color: _getStatusTextColor(application.status),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Application ${application.status.toLowerCase()}',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: _getStatusTextColor(application.status),
                    ),
                  ),
                  Text(
                    application.status == 'APPROVED' 
                        ? 'You can now contact this applicant'
                        : 'This applicant was not selected',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
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

    return Column(
      children: [
        const Text(
          'Review Application',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF181A1F),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Make a decision on this application',
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
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _showStatusConfirmation(context, 'REJECTED');
                },
                icon: const Icon(Icons.close, size: 18),
                label: const Text('Reject'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _showStatusConfirmation(context, 'APPROVED');
                },
                icon: const Icon(Icons.check, size: 18),
                label: const Text('Approve'),
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
  }

  void _showStatusConfirmation(BuildContext context, String newStatus) {
    onStatusChanged?.call(newStatus);
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