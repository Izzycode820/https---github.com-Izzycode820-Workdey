// lib/features/profile/widgets/profile_education_section.dart
import 'package:flutter/material.dart';
import 'package:workdey_frontend/core/models/profile/education/education_model.dart';

class ProfileEducationSection extends StatelessWidget {
  final List<Education> educations;
  final bool isOwnProfile;
  final VoidCallback? onAdd;
  final Function(Education)? onEdit;

  const ProfileEducationSection({
    super.key,
    required this.educations,
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
                      'Education',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    if (educations.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.purple.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${educations.length} record${educations.length == 1 ? '' : 's'}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.purple,
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
                      foregroundColor: Colors.purple,
                    ),
                  ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Education Content
            if (educations.isNotEmpty)
              _buildEducationTimeline(context)
            else if (isOwnProfile)
              _buildEmptyStateForOwner(context)
            else
              _buildEmptyStateForVisitor(),
          ],
        ),
      ),
    );
  }

  Widget _buildEducationTimeline(BuildContext context) {
    // Sort educations by start date (most recent first)
    final sortedEducations = List<Education>.from(educations)
      ..sort((a, b) => b.startDate.compareTo(a.startDate));

    return Column(
      children: [
        ...sortedEducations.asMap().entries.map((entry) {
          final index = entry.key;
          final education = entry.value;
          final isLast = index == sortedEducations.length - 1;
          
          return _buildEducationItem(education, isLast);
        }),
        
        // Education Summary
        if (educations.length > 1)
          _buildEducationSummary(),
      ],
    );
  }

  Widget _buildEducationItem(Education education, bool isLast) {
    final isCurrentlyStudying = education.isCurrent;
    final duration = _getEducationDuration(education);
    final institutionIcon = _getInstitutionIcon(education.institution);
    
    return InkWell(
      onTap: isOwnProfile ? () => onEdit?.call(education) : null,
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
                    color: isCurrentlyStudying ? Colors.green : Colors.purple,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: (isCurrentlyStudying ? Colors.green : Colors.purple).withOpacity(0.3),
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
                    height: 70,
                    color: Colors.grey[300],
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
              ],
            ),
            
            const SizedBox(width: 16),
            
            // Education Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Institution and Level
                  Row(
                    children: [
                      Icon(
                        institutionIcon,
                        size: 20,
                        color: Colors.purple[600],
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          education.institution,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      if (isCurrentlyStudying)
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
                  
                  const SizedBox(height: 6),
                  
                  // Degree and Field of Study
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getEducationLevelColor(education.level).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: _getEducationLevelColor(education.level).withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          _getEducationLevelDisplay(education.level),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: _getEducationLevelColor(education.level),
                          ),
                        ),
                      ),
                      if (education.fieldOfStudy != null && education.fieldOfStudy!.isNotEmpty) ...[
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'in ${education.fieldOfStudy}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Duration
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
                    ],
                  ),
                  
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

  Widget _buildEducationSummary() {
    final currentEducation = educations.where((e) => e.isCurrent).length;
    final completedEducation = educations.where((e) => !e.isCurrent).length;
    final highestLevel = _getHighestEducationLevel();
    
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.purple[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.purple[200]!),
      ),
      child: Row(
        children: [
          Icon(
            Icons.school,
            size: 16,
            color: Colors.purple[600],
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '$completedEducation completed • $currentEducation ongoing • Highest: $highestLevel',
              style: TextStyle(
                fontSize: 12,
                color: Colors.purple[700],
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
            Icons.school_outlined,
            size: 32,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 12),
          const Text(
            'Add Your Education',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Share your educational background to show your qualifications',
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
            label: const Text('Add Education'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
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
              'No education records listed yet',
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
  String _getEducationDuration(Education education) {
    final start = education.startDate;
    final end = education.endDate ?? DateTime.now();
    
    final startYear = start.year;
    final endYear = education.isCurrent ? 'Present' : end.year.toString();
    
    final years = education.isCurrent 
        ? DateTime.now().year - startYear
        : end.year - startYear;
    
    String duration = '$startYear - $endYear';
    if (years > 0) {
      duration += ' • ${years}yr${years == 1 ? '' : 's'}';
    }
    
    return duration;
  }

  IconData _getInstitutionIcon(String institution) {
    final lowerInstitution = institution.toLowerCase();
    
    if (lowerInstitution.contains('university') || lowerInstitution.contains('université')) {
      return Icons.account_balance;
    } else if (lowerInstitution.contains('polytechnic') || lowerInstitution.contains('polytechnique')) {
      return Icons.precision_manufacturing;
    } else if (lowerInstitution.contains('institute') || lowerInstitution.contains('institut')) {
      return Icons.business;
    } else if (lowerInstitution.contains('college') || lowerInstitution.contains('collège')) {
      return Icons.school;
    } else if (lowerInstitution.contains('high school') || lowerInstitution.contains('lycée')) {
      return Icons.local_library;
    } else {
      return Icons.school;
    }
  }

  Color _getEducationLevelColor(String level) {
    switch (level.toLowerCase()) {
      case 'phd':
      case 'doctorate':
        return Colors.red;
      case 'master':
      case 'graduate':
        return Colors.purple;
      case 'bachelor':
      case 'undergraduate':
        return Colors.blue;
      case 'associate':
      case 'diploma':
        return Colors.green;
      case 'certificate':
        return Colors.orange;
      case 'high':
      case 'secondary':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  String _getEducationLevelDisplay(String level) {
    switch (level.toLowerCase()) {
      case 'phd':
        return 'PhD';
      case 'doctorate':
        return 'Doctorate';
      case 'master':
        return 'Master\'s';
      case 'graduate':
        return 'Graduate';
      case 'bachelor':
        return 'Bachelor\'s';
      case 'undergraduate':
        return 'Undergraduate';
      case 'associate':
        return 'Associate';
      case 'diploma':
        return 'Diploma';
      case 'certificate':
        return 'Certificate';
      case 'high':
        return 'High School';
      case 'secondary':
        return 'Secondary';
      default:
        return level;
    }
  }

  String _getHighestEducationLevel() {
    if (educations.isEmpty) return 'None';
    
    final levelPriority = {
      'phd': 7,
      'doctorate': 7,
      'master': 6,
      'graduate': 6,
      'bachelor': 5,
      'undergraduate': 5,
      'associate': 4,
      'diploma': 3,
      'certificate': 2,
      'high': 1,
      'secondary': 1,
    };
    
    String highestLevel = educations.first.level;
    int highestPriority = levelPriority[highestLevel.toLowerCase()] ?? 0;
    
    for (final education in educations) {
      final priority = levelPriority[education.level.toLowerCase()] ?? 0;
      if (priority > highestPriority) {
        highestLevel = education.level;
        highestPriority = priority;
      }
    }
    
    return _getEducationLevelDisplay(highestLevel);
  }
}