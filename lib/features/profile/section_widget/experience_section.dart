// lib/features/profile/widgets/profile_experience_section.dart
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
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
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
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    if (experiences.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${_getTotalYears()} years',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                if (isOwnProfile)
                  IconButton(
                    icon: const Icon(Icons.add, size: 20),
                    onPressed: onAdd,
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.grey[100],
                      foregroundColor: Colors.blue,
                    ),
                  ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Experience Content
            if (experiences.isNotEmpty)
              _buildExperienceTimeline(context)
            else if (isOwnProfile)
              _buildEmptyStateForOwner(context)
            else
              _buildEmptyStateForVisitor(),
          ],
        ),
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
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline
            Column(
              children: [
                // Timeline dot
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: isCurrentPosition ? Colors.green : Colors.blue,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: (isCurrentPosition ? Colors.green : Colors.blue).withOpacity(0.3),
                        blurRadius: 4,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
                // Timeline line
                if (!isLast)
                  Container(
                    width: 2,
                    height: 60,
                    color: Colors.grey[300],
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
              ],
            ),
            
            const SizedBox(width: 16),
            
            // Experience Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Position and Company
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          experience.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      if (isCurrentPosition)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.green[200]!),
                          ),
                          child: Text(
                            'Current',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.green[700],
                            ),
                          ),
                        ),
                    ],
                  ),
                  
                  const SizedBox(height: 4),
                  
                  // Company and Type
                  Row(
                    children: [
                      Icon(
                        _getCompanyIcon(experience.company),
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          experience.company!,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getJobTypeColor(experience.jobType).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          _getJobTypeDisplay(experience.jobType),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: _getJobTypeColor(experience.jobType),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Duration and Category
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 14,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        duration,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.category,
                        size: 14,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _getCategoryDisplay(experience.category),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  
                  // Description
                  if (experience.description != null && experience.description!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      experience.description!,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[700],
                        height: 1.4,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  
                  // Edit indicator for own profile
                  if (isOwnProfile) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.edit,
                          size: 12,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Tap to edit',
                          style: TextStyle(
                            fontSize: 11,
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
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Row(
        children: [
          Icon(
            Icons.insights,
            size: 16,
            color: Colors.blue[600],
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '${_getTotalYears()} years total • $currentJobs current position${currentJobs == 1 ? '' : 's'} • $categories industr${categories == 1 ? 'y' : 'ies'}',
              style: TextStyle(
                fontSize: 12,
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          Icon(
            Icons.work_outline,
            size: 32,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 12),
          const Text(
            'Add Your Work Experience',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Share your professional journey to build credibility with employers',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: onAdd,
            icon: const Icon(Icons.add, size: 18),
            label: const Text('Add Experience'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyStateForVisitor() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            size: 20,
            color: Colors.grey[500],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'No work experience listed yet',
              style: TextStyle(
                fontSize: 14,
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
      if (years > 0) parts.add('${years}yr${years == 1 ? '' : 's'}');
      if (remainingMonths > 0) parts.add('${remainingMonths}mo${remainingMonths == 1 ? '' : 's'}');
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
    final lowerCompany = company!.toLowerCase();
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

  String _getCategoryDisplay(String? category) {
    if (category == null) return 'Other';
    switch (category) {
      case 'IT':
        return 'Technology';
      case 'HEALTH':
        return 'Healthcare';
      case 'FINANCE':
        return 'Finance';
      case 'CONSTRUCTION':
        return 'Construction';
      case 'EDUCATION':
        return 'Education';
      case 'OTHER':
        return 'Other';
      default:
        return category;
    }
  }
}