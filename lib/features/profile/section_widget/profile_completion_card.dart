// lib/features/profile/widgets/profile_completion_card.dart
import 'package:flutter/material.dart';
import 'package:workdey_frontend/core/models/profile/profile_model.dart';

class ProfileCompletionCard extends StatelessWidget {
  final UserProfile profile;

  const ProfileCompletionCard({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    final completionScore = profile.profileCompletenessScore;
    final missingSections = profile.missingProfileSections;

    // Don't show if profile is already complete
    if (completionScore >= 0.95) return const SizedBox.shrink();
    
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Compact Header
          Row(
            children: [
              Icon(
                Icons.trending_up,
                color: const Color(0xFF3E8728),
                size: 16,
              ),
              const SizedBox(width: 8),
              const Text(
                'Complete Profile',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              Text(
                '${(completionScore * 100).round()}%',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF3E8728),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Progress Bar
          LinearProgressIndicator(
            value: completionScore,
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF3E8728)),
            minHeight: 3,
          ),
          
          const SizedBox(height: 8),
          
          // Missing Sections (Compact)
          if (missingSections.isNotEmpty)
            Text(
              'Add: ${missingSections.take(3).join(', ')}${missingSections.length > 3 ? '...' : ''}',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey[600],
              ),
            ),
          
          const SizedBox(height: 8),
          
          // Action Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _navigateToProfileEdit(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3E8728),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Complete Profile',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToProfileEdit(BuildContext context) {
    Navigator.pushNamed(context, '/profile/edit');
  }
}