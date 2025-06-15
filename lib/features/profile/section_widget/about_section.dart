import 'package:flutter/material.dart';
import 'package:workdey_frontend/core/models/profile/profile_model.dart';

class AboutSection extends StatelessWidget {
  final UserProfile profile;

  const AboutSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return _buildSectionCard(
      title: 'About',
      children: [
        Text(
          profile.bio,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 15,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildDetailItem(Icons.email, profile.user.email ?? 'No email'),
            const SizedBox(width: 16),
            _buildDetailItem(Icons.phone, profile.user.phone ?? 'No phone'),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: const Color(0xFF3E8728)),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionCard({
    required String title,
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
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const Divider(height: 24, thickness: 1),
          ...children,
        ],
      ),
    );
  }
}