// my_application_card.dart - Job Card Style Redesign
import 'package:flutter/material.dart';
import 'package:workdey_frontend/core/models/applicant/applicant_model.dart';
import 'package:workdey_frontend/features/application/my_application_card_bottom_sheet.dart';

class MyApplicationCard extends StatelessWidget {
  final Application application;

  const MyApplicationCard({
    super.key,
    required this.application,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 1), // Minimal gap like LinkedIn/JobCard
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
          onTap: () => _showApplicationBottomSheet(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 8),
                _buildJobTitle(),
                const SizedBox(height: 4),
                _buildApplicationInfo(),
                const SizedBox(height: 6),
                _buildJobLocation(),
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
        // Applied time
        Text(
          'Applied ${_getTimeAgo(application.appliedAt)}',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Colors.blue[600],
          ),
        ),
        const SizedBox(width: 8),
        // Status chip
        _buildStatusChip(),
        const Spacer(),
        // Action needed indicator
        if (_needsAction())
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'Action',
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                color: Colors.orange[700],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildStatusChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: _getStatusColor(application.status).withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        _getStatusDisplay(application.status),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: _getStatusTextColor(application.status),
        ),
      ),
    );
  }

  Widget _buildJobTitle() {
    // Since we don't have job title directly, we'll use a placeholder or derive it
    return Text(
      'Job Application #${application.id}', // Would be actual job title in real implementation
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

  Widget _buildApplicationInfo() {
    return Row(
      children: [
        // Status icon
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: _getStatusColor(application.status),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            _getStatusIcon(application.status),
            color: Colors.white,
            size: 12,
          ),
        ),
        const SizedBox(width: 6),
        // Status text
        Expanded(
          child: Text(
            _getStatusDisplayText(application.status),
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
        // Priority indicator
        if (application.status == 'APPROVED' || application.status == 'IN_PROGRESS')
          Icon(
            Icons.priority_high,
            size: 16,
            color: Colors.orange[600],
          ),
      ],
    );
  }

  Widget _buildJobLocation() {
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
            'Job Location', // Would be actual job location in real implementation
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
        // Skills preview (if available)
        if (application.response?.skillsMet.isNotEmpty ?? false) ...[
          _buildInfoChip(application.response!.skillsMet.first, Colors.blue),
          if (application.response!.skillsMet.length > 1) ...[
            const SizedBox(width: 6),
            Text(
              '+${application.response!.skillsMet.length - 1}',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
        const Spacer(),
        // Application details indicator
        Icon(
          Icons.chevron_right,
          size: 16,
          color: Colors.grey[400],
        ),
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
          color: Colors.grey[300],
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void _showApplicationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => MyApplicationBottomSheet(
        application: application,
      ),
    );
  }

  // Helper methods
  bool _needsAction() {
    return application.status == 'APPROVED' || 
           application.status == 'IN_PROGRESS';
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

  String _getStatusDisplayText(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return 'Under Review';
      case 'APPROVED':
        return 'Ready to Start';
      case 'REJECTED':
        return 'Not Selected';
      case 'IN_PROGRESS':
        return 'Job Active';
      case 'COMPLETED':
        return 'Job Done';
      default:
        return status;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return Icons.schedule;
      case 'APPROVED':
        return Icons.check_circle;
      case 'REJECTED':
        return Icons.cancel;
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
      case 'PENDING':
        return Colors.orange;
      case 'APPROVED':
        return const Color(0xFF3E8728);
      case 'REJECTED':
        return Colors.red;
      case 'IN_PROGRESS':
        return Colors.blue;
      case 'COMPLETED':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return Colors.orange[700]!;
      case 'APPROVED':
        return const Color(0xFF3E8728);
      case 'REJECTED':
        return Colors.red[700]!;
      case 'IN_PROGRESS':
        return Colors.blue[700]!;
      case 'COMPLETED':
        return Colors.purple[700]!;
      default:
        return Colors.grey[700]!;
    }
  }
}