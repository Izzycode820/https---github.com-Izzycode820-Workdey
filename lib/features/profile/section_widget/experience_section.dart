// lib/features/profile/widgets/experience_section.dart
import 'package:flutter/material.dart';
import 'package:workdey_frontend/core/models/profile/experience/experience_model.dart';

class ProfileExperienceSection extends StatelessWidget {
  final List<Experience> experiences;
  final bool isOwnProfile;
  final VoidCallback? onAdd;
  final Function(Experience)? onEdit;

  const ProfileExperienceSection({
    super.key,
    required this.experiences,
    required this.isOwnProfile,
    this.onAdd,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'Experience',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  if (experiences.isNotEmpty) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${_getTotalYears()}yr',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              if (isOwnProfile)
                InkWell(
                  onTap: onAdd,
                  borderRadius: BorderRadius.circular(4),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      Icons.add,
                      size: 16,
                      color: Colors.blue,
                    ),
                  ),
                ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Experience Content
          if (experiences.isNotEmpty)
            _buildExperienceTimeline(context)
          else if (isOwnProfile)
            _buildEmptyStateForOwner(context)
          else
            _buildEmptyStateForVisitor(),
        ],
      ),
    );
  }

  Widget _buildExperienceTimeline(BuildContext context) {
    // Sort experiences by start date (most recent first)
    final sortedExperiences = List<Experience>.from(experiences)
      ..sort((a, b) => b.startDate.compareTo(a.startDate));

    return Column(
      children: [
        ...sortedExperiences.asMap().entries.map((entry) {
          final index = entry.key;
          final experience = entry.value;
          final isLast = index == sortedExperiences.length - 1;
          
          return _buildExperienceItem(experience, isLast);
        }),
        
        // Experience Summary
        if (experiences.length > 1)
          _buildExperienceSummary(),
      ],
    );
  }

  Widget _buildExperienceItem(Experience experience, bool isLast) {
    final isCurrentPosition = experience.isCurrent ?? false;
    final duration = _getExperienceDuration(experience);
    
    return InkWell(
      onTap: isOwnProfile ? () => onEdit?.call(experience) : null,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline
            Column(
              children: [
                // Timeline dot
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isCurrentPosition ? Colors.green : Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
                // Timeline line
                if (!isLast)
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.grey[300],
                    margin: const EdgeInsets.symmetric(vertical: 3),
                  ),
              ],
            ),
            
            const SizedBox(width: 12),
            
            // Experience Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Position and Status
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          experience.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      if (isCurrentPosition)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(color: Colors.green[200]!),
                          ),
                          child: Text(
                            'Current',
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w500,
                              color: Colors.green[700],
                            ),
                          ),
                        ),
                    ],
                  ),
                  
                  const SizedBox(height: 2),
                  
                  // Company and Type
                  Row(
                    children: [
                      Icon(
                        _getCompanyIcon(experience.company),
                        size: 12,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          experience.company!,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                        decoration: BoxDecoration(
                          color: _getJobTypeColor(experience.jobType).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text(
                          _getJobTypeDisplay(experience.jobType),
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w500,
                            color: _getJobTypeColor(experience.jobType),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 4),
                  
                  // Duration
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 10,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(width: 3),
                      Text(
                        duration,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  
                  // Description (if available)
                  if (experience.description != null && experience.description!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      experience.description!,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[700],
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  
                  // Edit indicator for own profile
                  if (isOwnProfile) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.edit,
                          size: 8,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(width: 3),
                        Text(
                          'Tap to edit',
                          style: TextStyle(
                            fontSize: 8,
                            color: Colors.grey[400],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExperienceSummary() {
    final currentJobs = experiences.where((e) => e.isCurrent == true).length;
    final categories = experiences.map((e) => e.category).toSet().length;
    
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Row(
        children: [
          Icon(
            Icons.insights,
            size: 12,
            color: Colors.blue[600],
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              '${_getTotalYears()}yr total • $currentJobs current • $categories industrie${categories == 1 ? '' : 's'}',
              style: TextStyle(
                fontSize: 10,
                color: Colors.blue[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyStateForOwner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          Icon(
            Icons.work_outline,
            size: 24,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 8),
          const Text(
            'Add Work Experience',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Share your professional journey',
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: onAdd,
            icon: const Icon(Icons.add, size: 14),
            label: const Text('Add Experience'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              textStyle: const TextStyle(fontSize: 11),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyStateForVisitor() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            size: 16,
            color: Colors.grey[500],
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'No work experience listed yet',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Methods
  int _getTotalYears() {
    if (experiences.isEmpty) return 0;
    
    int totalMonths = 0;
    for (final exp in experiences) {
      final start = exp.startDate;
      final end = exp.endDate ?? DateTime.now();
      final months = (end.year - start.year) * 12 + end.month - start.month;
      totalMonths += months.abs();
    }
    
    return (totalMonths / 12).round();
  }

  String _getExperienceDuration(Experience experience) {
    final start = experience.startDate;
    final end = experience.endDate ?? DateTime.now();
    
    final startMonth = '${_getMonthName(start.month)} ${start.year}';
    final endMonth = experience.isCurrent == true 
        ? 'Present'
        : '${_getMonthName(end.month)} ${end.year}';
    
    final months = (end.year - start.year) * 12 + end.month - start.month;
    final years = (months / 12).floor();
    final remainingMonths = months % 12;
    
    String duration = '$startMonth - $endMonth';
    if (years > 0 || remainingMonths > 0) {
      final parts = <String>[];
      if (years > 0) parts.add('${years}yr');
      if (remainingMonths > 0) parts.add('${remainingMonths}mo');
      duration += ' • ${parts.join(' ')}';
    }
    
    return duration;
  }

  String _getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }

  IconData _getCompanyIcon(String? company) {
    if (company == null) return Icons.business;
    final lowerCompany = company.toLowerCase();
    if (lowerCompany.contains('government') || lowerCompany.contains('ministry')) {
      return Icons.account_balance;
    } else if (lowerCompany.contains('university') || lowerCompany.contains('school')) {
      return Icons.school;
    } else if (lowerCompany.contains('hospital') || lowerCompany.contains('clinic')) {
      return Icons.local_hospital;
    } else if (lowerCompany.contains('bank')) {
      return Icons.account_balance_wallet;
    } else {
      return Icons.business;
    }
  }

  Color _getJobTypeColor(String? jobType) {
    if (jobType == null) return Colors.grey;
    switch (jobType.toLowerCase()) {
      case 'full-time':
        return Colors.green;
      case 'part-time':
        return Colors.orange;
      case 'contract':
        return Colors.purple;
      case 'freelance':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  String _getJobTypeDisplay(String? jobType) {
    if (jobType == null) return 'Unknown';
    switch (jobType.toLowerCase()) {
      case 'full-time':
        return 'Full-time';
      case 'part-time':
        return 'Part-time';
      case 'contract':
        return 'Contract';
      case 'freelance':
        return 'Freelance';
      default:
        return jobType;
    }
  }
}