// lib/features/profile/widgets/profile_trust_section.dart
import 'package:flutter/material.dart';
import 'package:workdey_frontend/core/models/trustscore/trust_score_model.dart';

class ProfileTrustSection extends StatelessWidget {
  final TrustScore trustScore;
  final bool isOwnProfile;

  const ProfileTrustSection({
    super.key,
    required this.trustScore,
    required this.isOwnProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Trust Level
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getTrustLevelColor(trustScore.trustLevel),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getTrustLevelIcon(trustScore.trustLevel),
                      size: 12,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      trustScore.trustLevelDisplay,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.amber[50],
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.amber[200]!),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, size: 12, color: Colors.amber),
                    const SizedBox(width: 3),
                    Text(
                      trustScore.overallScore.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Trust Metrics Grid
          Row(
            children: [
              Expanded(
                child: _buildTrustMetric(
                  label: 'Jobs',
                  value: trustScore.completedJobs.toString(),
                  icon: Icons.work_outline,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildTrustMetric(
                  label: 'Reviews',
                  value: trustScore.totalReviews.toString(),
                  icon: Icons.star_outline,
                  color: Colors.amber,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildTrustMetric(
                  label: 'Services',
                  value: trustScore.completedServices.toString(),
                  icon: Icons.handyman_outlined,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildTrustMetric(
                  label: 'Performance',
                  value: '${(trustScore.jobPerformanceScore * 20).toInt()}%',
                  icon: Icons.trending_up,
                  color: Colors.purple,
                ),
              ),
            ],
          ),
          
          // Detailed Scores (only for own profile)
          if (isOwnProfile) ...[
            const SizedBox(height: 16),
            _buildDetailedScores(),
          ],
          
          // Trust Tips for Own Profile
          if (isOwnProfile && !_isHighlyTrusted()) ...[
            const SizedBox(height: 12),
            _buildTrustTips(),
          ],
        ],
      ),
    );
  }

  Widget _buildTrustMetric({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(height: 3),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedScores() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Detailed Scores',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 8),
        _buildScoreBar('Job Performance', trustScore.jobPerformanceScore, Colors.blue),
        const SizedBox(height: 6),
        _buildScoreBar('Service Quality', trustScore.serviceQualityScore, Colors.green),
        const SizedBox(height: 6),
        _buildScoreBar('Reliability', trustScore.reliabilityScore, Colors.orange),
        const SizedBox(height: 6),
        _buildScoreBar('Employer Satisfaction', trustScore.employerSatisfactionScore, Colors.purple),
      ],
    );
  }

  Widget _buildScoreBar(String label, double score, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            Text(
              score.toStringAsFixed(1),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        LinearProgressIndicator(
          value: score / 5.0,
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation<Color>(color),
          minHeight: 3,
        ),
      ],
    );
  }

  Widget _buildTrustTips() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Row(
        children: [
          Icon(Icons.lightbulb_outline, size: 14, color: Colors.blue[600]),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              'Complete jobs successfully and get positive reviews to improve your trust level.',
              style: TextStyle(
                fontSize: 11,
                color: Colors.blue[600],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getTrustLevelColor(String trustLevel) {
    switch (trustLevel.toUpperCase()) {
      case 'NEWCOMER':
        return Colors.grey;
      case 'BUILDING':
        return Colors.orange;
      case 'TRUSTED':
        return Colors.blue;
      case 'EXPERT':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _getTrustLevelIcon(String trustLevel) {
    switch (trustLevel.toUpperCase()) {
      case 'NEWCOMER':
        return Icons.person_outline;
      case 'BUILDING':
        return Icons.trending_up;
      case 'TRUSTED':
        return Icons.verified_user;
      case 'EXPERT':
        return Icons.star;
      default:
        return Icons.person_outline;
    }
  }

  bool _isHighlyTrusted() {
    return trustScore.trustLevel.toUpperCase() == 'TRUSTED' || 
           trustScore.trustLevel.toUpperCase() == 'EXPERT';
  }
}