import 'package:flutter/material.dart';
import 'package:workdey_frontend/core/models/profile/experience/experience_model.dart';

class ExperienceSection extends StatelessWidget {
  final List<Experience> experiences;
  final VoidCallback onAddPressed;
  final Function(Experience) onEditPressed;

  const ExperienceSection({
    super.key,
    required this.experiences,
    required this.onAddPressed,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return _buildSectionCard(
      title: 'Experience',
      action: IconButton(
        icon: const Icon(Icons.add, color: Color(0xFF3E8728)),
        onPressed: onAddPressed,
      ),
      children: [
        if (experiences.isEmpty)
          _buildEmptyState('No experience added yet', Icons.work_outline),
        ...experiences.map((exp) => _buildExperienceItem(exp)),
      ],
    );
  }

  Widget _buildExperienceItem(Experience exp) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exp.title,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (exp.company != null)
                    Text(
                      exp.company!,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit, size: 18, color: Colors.grey),
              onPressed: () => onEditPressed(exp),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          '${exp.startDate.year} - ${exp.isCurrent ? 'Present' : exp.endDate?.year ?? ''}',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13,
            color: Colors.grey[600],
          ),
        ),
        if (exp.description != null) ...[
          const SizedBox(height: 8),
          Text(
            exp.description!,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: Colors.grey[800],
            ),
          ),
        ],
        const Divider(height: 32),
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