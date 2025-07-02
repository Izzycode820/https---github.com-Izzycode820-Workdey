// applicant_card.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workdey_frontend/core/models/applicant/applicant_model.dart';

class ApplicantCard extends StatelessWidget {
  final Application application;
  final bool isEmployerView;
  final Function(String)? onStatusChanged;

  const ApplicantCard({
    required this.application,
    this.isEmployerView = false,
    this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 12),
            if (application.response != null) _buildSkillsSection(),
            if (isEmployerView && application.matchStats != null) 
              _buildMatchStats(),
            _buildFooter(),
            if (isEmployerView) _buildStatusControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        CircleAvatar(
          child: Text(application.details.name[0]),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                application.details.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '${application.details.completedJobs} jobs completed',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
        Chip(
          label: Text(application.status.toUpperCase()),
          backgroundColor: _getStatusColor(application.status),
        ),
      ],
    );
  }

  Widget _buildSkillsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Skills Matched:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Wrap(
          spacing: 4,
          children: application.response!.skillsMet
              .map((skill) => Chip(label: Text(skill)))
              .toList(),
        ),
        if (application.response!.optionalSkillsMet.isNotEmpty) ...[
          const SizedBox(height: 8),
          const Text(
            'Bonus Skills:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Wrap(
            spacing: 4,
            children: application.response!.optionalSkillsMet
                .map((skill) => Chip(label: Text(skill)))
                .toList(),
          ),
        ],
        if (application.response!.notes.isNotEmpty) ...[
          const SizedBox(height: 8),
          const Text(
            'Notes:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(application.response!.notes),
        ],
      ],
    );
  }

  Widget _buildMatchStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            'Match: ${application.matchStats!.percentage}%',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _getMatchColor(application.matchStats!.percentage),
            ),
          ),
          const SizedBox(width: 16),
          Text('Required: ${application.matchStats!.requiredMatch}'),
          const SizedBox(width: 16),
          Text('Optional: ${application.matchStats!.optionalMatch}'),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        'Applied on ${DateFormat.yMMMd().format(application.appliedAt)}',
        style: TextStyle(color: Colors.grey[600]),
      ),
    );
  }

  Widget _buildStatusControls() {
    return ButtonBar(
      children: [
        if (application.status != 'APPROVED')
          ElevatedButton(
            onPressed: () => onStatusChanged?.call('APPROVED'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: const Text('Approve'),
          ),
        if (application.status != 'REJECTED')
          ElevatedButton(
            onPressed: () => onStatusChanged?.call('REJECTED'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Reject'),
          ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'APPROVED':
        return Colors.green.withOpacity(0.2);
      case 'REJECTED':
        return Colors.red.withOpacity(0.2);
      default:
        return Colors.orange.withOpacity(0.2);
    }
  }

  Color _getMatchColor(double percentage) {
    if (percentage > 75) return Colors.green;
    if (percentage > 50) return Colors.orange;
    return Colors.red;
  }
}