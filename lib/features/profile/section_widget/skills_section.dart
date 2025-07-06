// lib/features/profile/widgets/profile_skills_section.dart
import 'package:flutter/material.dart';
import 'package:workdey_frontend/core/models/profile/skills/skill_model.dart';

class ProfileSkillsSection extends StatelessWidget {
  final List<Skill> skills;
  final bool isOwnProfile;
  final VoidCallback? onAdd;
  final Function(Skill)? onEdit;

  const ProfileSkillsSection({
    super.key,
    required this.skills,
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
                      'Skills',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3E8728).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${skills.length}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF3E8728),
                        ),
                      ),
                    ),
                  ],
                ),
                if (isOwnProfile)
                  IconButton(
                    icon: const Icon(Icons.add, size: 20),
                    onPressed: onAdd,
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.grey[100],
                      foregroundColor: const Color(0xFF3E8728),
                    ),
                  ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Skills Content
            if (skills.isNotEmpty)
              _buildSkillsContent(context)
            else if (isOwnProfile)
              _buildEmptyStateForOwner(context)
            else
              _buildEmptyStateForVisitor(),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillsContent(BuildContext context) {
    // Group skills by proficiency level
    final advancedSkills = skills.where((s) => s.proficiency == 'advanced').toList();
    final intermediateSkills = skills.where((s) => s.proficiency == 'intermediate').toList();
    final beginnerSkills = skills.where((s) => s.proficiency == 'beginner').toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Advanced Skills
        if (advancedSkills.isNotEmpty) ...[
          _buildSkillLevelSection('Expert Level', advancedSkills, Colors.green),
          const SizedBox(height: 16),
        ],
        
        // Intermediate Skills
        if (intermediateSkills.isNotEmpty) ...[
          _buildSkillLevelSection('Intermediate', intermediateSkills, Colors.blue),
          const SizedBox(height: 16),
        ],
        
        // Beginner Skills
        if (beginnerSkills.isNotEmpty) ...[
          _buildSkillLevelSection('Learning', beginnerSkills, Colors.orange),
          const SizedBox(height: 16),
        ],
        
        // Skills Summary
        if (skills.length > 3)
          _buildSkillsSummary(),
      ],
    );
  }

  Widget _buildSkillLevelSection(String title, List<Skill> skillList, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 16,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '(${skillList.length})',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: skillList.map((skill) => _buildSkillChip(skill, color)).toList(),
        ),
      ],
    );
  }

  Widget _buildSkillChip(Skill skill, Color color) {
    return InkWell(
      onTap: isOwnProfile ? () => onEdit?.call(skill) : null,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Skill Icon based on proficiency
            Icon(
              _getSkillIcon(skill.proficiency),
              size: 14,
              color: color,
            ),
            const SizedBox(width: 6),
            Text(
              skill.name,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
            // Willing to learn indicator
            if (skill.isWillingToLearn == true) ...[
              const SizedBox(width: 4),
              Icon(
                Icons.trending_up,
                size: 12,
                color: Colors.amber[700],
              ),
            ],
            // Edit indicator for own profile
            if (isOwnProfile) ...[
              const SizedBox(width: 4),
              Icon(
                Icons.edit,
                size: 10,
                color: color.withOpacity(0.7),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSkillsSummary() {
    final topSkills = skills.where((s) => s.proficiency == 'advanced').length;
    final learningSkills = skills.where((s) => s.isWillingToLearn == true).length;
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Icon(
            Icons.analytics_outlined,
            size: 16,
            color: Colors.grey[600],
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '$topSkills expert skills • $learningSkills skills actively learning',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
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
            Icons.star_outline,
            size: 32,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 12),
          const Text(
            'Showcase Your Skills',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add skills to help employers find you and understand your expertise',
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
            label: const Text('Add Skills'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3E8728),
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
              'No skills listed yet',
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

  IconData _getSkillIcon(String proficiency) {
    switch (proficiency) {
      case 'advanced':
        return Icons.star;
      case 'intermediate':
        return Icons.star_half;
      case 'beginner':
        return Icons.star_outline;
      default:
        return Icons.circle;
    }
  }
}