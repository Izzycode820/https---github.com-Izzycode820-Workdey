import 'package:flutter/material.dart';
import 'package:workdey_frontend/core/models/profile/education/education_model.dart';
class EducationSection extends StatelessWidget {
  final List<Education> educations;

  const EducationSection({super.key, required this.educations});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Education',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        if (educations.isEmpty)
          const Text('No education added yet')
        else
          Column(
            children: educations.map((edu) => _buildEducationItem(edu)).toList(),
          ),
      ],
    );
  }

  Widget _buildEducationItem(Education education) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              education.institution,
              style: const TextStyle(fontWeight: FontWeight.bold)),

            if (education.fieldOfStudy != null)
              Text(education.fieldOfStudy!),
            const SizedBox(height: 8),
            Text(
              '${_formatDate(education.startDate)} - ${education.endDate != null ? _formatDate(education.endDate!) : 'Present'}',
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