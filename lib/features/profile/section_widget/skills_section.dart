import 'package:flutter/material.dart';
import 'package:workdey_frontend/core/models/profile/skills/skill_model.dart';

class SkillsSection extends StatelessWidget {
  final List<Skill> skills;
  final VoidCallback onAddPressed;
  final Function(int) onDeletePressed;

  const SkillsSection({
    super.key,
    required this.skills,
    required this.onAddPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return _buildSectionCard(
      title: 'Skills',
      action: IconButton(
        icon: const Icon(Icons.add, color: Color(0xFF3E8728)),
        onPressed: onAddPressed,
      ),
      children: [
        if (skills.isEmpty)
          _buildEmptyState('No skills added yet', Icons.code),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: skills
              .map((skill) => Chip(
                    label: Text(skill.name),
                    deleteIcon: const Icon(Icons.close, size: 16),
                    onDeleted: () => onDeletePressed(skill.id),
                    backgroundColor: const Color(0xFFE8F5E9),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildEmptyState(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          Icon(icon, size: 48, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    Widget? action,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              if (action != null) action,
            ],
          ),
          const Divider(height: 24, thickness: 1),
          ...children,
        ],
      ),
    );
  }
}