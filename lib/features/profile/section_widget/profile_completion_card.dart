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
    if (completionScore >= 95) return const SizedBox.shrink();
    
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF3E8728).withOpacity(0.1),
            Colors.blue.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF3E8728).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3E8728).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    color: Color(0xFF3E8728),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Complete Your Profile',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        'Get more job opportunities',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${(completionScore * 100).round()}%',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E8728),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Progress Bar
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Profile Strength',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                    Text(
                      _getStrengthLabel(completionScore),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _getStrengthColor(completionScore),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: completionScore,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _getStrengthColor(completionScore),
                    ),
                    minHeight: 8,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Missing Sections
            if (missingSections.isNotEmpty) ...[
              Text(
                'Complete these sections:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 12),
              
              ...missingSections.take(3).map((section) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _buildMissingSection(context, section),
              )),
              
              if (missingSections.length > 3)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    'and ${missingSections.length - 3} more...',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
            ],
            
            const SizedBox(height: 16),
            
            // Benefits of Complete Profile
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.emoji_events,
                        size: 16,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Benefits of Complete Profile',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ...completionScore < 0.8 ? [
                    _buildBenefit('🎯', 'Get 3x more job matches'),
                    _buildBenefit('⭐', 'Build trust with employers'),
                    _buildBenefit('💼', 'Access premium opportunities'),
                    _buildBenefit('🔔', 'Receive priority notifications'),
                  ] : [
                    _buildBenefit('✅', 'Profile optimized for success'),
                    _buildBenefit('🏆', 'You\'re ahead of 80% of users'),
                    _buildBenefit('🚀', 'Ready for top opportunities'),
                  ]
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Action Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _navigateToProfileEdit(context),
                icon: Icon(
                  completionScore >= 0.8 ? Icons.verified : Icons.edit,
                  size: 18,
                ),
                label: Text(
                  completionScore >= 0.8 ? 'Profile Complete!' : 'Complete Profile',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: completionScore >= 0.8 
                      ? Colors.green 
                      : const Color(0xFF3E8728),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMissingSection(BuildContext context, String section) {
    IconData icon;
    VoidCallback? onTap;
    
    switch (section) {
      case 'Professional Bio':
        icon = Icons.edit_note;
        onTap = () => Navigator.pushNamed(context, '/profile/edit/about');
        break;
      case 'Location':
        icon = Icons.location_on;
        onTap = () => Navigator.pushNamed(context, '/profile/edit/location');
        break;
      case 'Skills':
        icon = Icons.star;
        onTap = () => Navigator.pushNamed(context, '/profile/skills/add');
        break;
      case 'Work Experience':
        icon = Icons.work;
        onTap = () => Navigator.pushNamed(context, '/profile/experience/add');
        break;
      case 'Education':
        icon = Icons.school;
        onTap = () => Navigator.pushNamed(context, '/profile/education/add');
        break;
      case 'Verification':
        icon = Icons.verified_user;
        onTap = () => Navigator.pushNamed(context, '/profile/verification');
        break;
      case 'Availability':
        icon = Icons.schedule;
        onTap = () => Navigator.pushNamed(context, '/profile/edit/availability');
        break;
      default:
        icon = Icons.add;
        onTap = () => Navigator.pushNamed(context, '/profile/edit');
    }
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: const Color(0xFF3E8728),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                section,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 12,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefit(String emoji, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 12)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getStrengthLabel(double score) {
    if (score >= 0.8) return 'Excellent';
    if (score >= 0.6) return 'Good';
    if (score >= 0.4) return 'Improving';
    return 'Getting Started';
  }

  Color _getStrengthColor(double score) {
    if (score >= 0.8) return Colors.green;
    if (score >= 0.6) return Colors.blue;
    if (score >= 0.4) return Colors.orange;
    return Colors.red;
  }

  void _navigateToProfileEdit(BuildContext context) {
    Navigator.pushNamed(context, '/profile/edit');
  }
}