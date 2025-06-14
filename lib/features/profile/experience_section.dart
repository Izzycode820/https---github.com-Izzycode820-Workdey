import 'package:flutter/material.dart';
import 'package:workdey_frontend/core/models/profile/experience/experience_model.dart';

class ExperienceSection extends StatelessWidget {
  final List<Experience> experiences;

  const ExperienceSection({super.key, required this.experiences});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Experience',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        if (experiences.isEmpty)
          const Text('No experience added yet')
        else
          Column(
            children: experiences.map((exp) => _buildExperienceItem(exp)).toList(),
          ),
      ],
    );
  }

  Widget _buildExperienceItem(Experience experience) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              experience.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            if (experience.company != null)
              Text(experience.company!),
            const SizedBox(height: 8),
            Text(
              '${_formatDate(experience.startDate)} - ${experience.endDate != null ? _formatDate(experience.endDate!) : 'Present'}',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.month}/${date.year}';
  }
}