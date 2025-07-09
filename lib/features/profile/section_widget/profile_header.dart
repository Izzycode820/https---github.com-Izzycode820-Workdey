// lib/features/profile/widgets/profile_header.dart
import 'package:flutter/material.dart';
import 'package:workdey_frontend/core/models/profile/profile_model.dart';

class ProfileHeader extends StatelessWidget {
  final UserProfile profile;
  final bool isOwnProfile;
  final VoidCallback? onEditPressed;
  final VoidCallback? onContactPressed;

  const ProfileHeader({
    super.key,
    required this.profile,
    required this.isOwnProfile,
    this.onEditPressed,
    this.onContactPressed,
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
          // Main Profile Row
          Row(
            children: [
              // Profile Picture with Verification Badge
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey[300]!, width: 1.5),
                    ),
                    child: CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: profile.user.profilePicture != null
                          ? NetworkImage(profile.user.profilePicture!)
                          : null,
                      child: profile.user.profilePicture == null
                          ? Text(
                              (profile.user.firstName?[0] ?? 'U').toUpperCase(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            )
                          : null,
                    ),
                  ),
                  
                  // Verification Badge
                  if (profile.user.verificationLevel >= 3)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.verified,
                          color: Colors.white,
                          size: 12,
                        ),
                      ),
                    ),
                ],
              ),
              
              const SizedBox(width: 12),
              
              // Name and Info Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and Trust Badge Row
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            profile.fullName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        // Trust Level Emoji Badge
                        if (profile.trustScore != null)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getTrustLevelColor(profile.trustScore!.trustLevel).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: _getTrustLevelColor(profile.trustScore!.trustLevel).withOpacity(0.3),
                              ),
                            ),
                            child: Text(
                              profile.trustScore!.trustLevelEmoji,
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                      ],
                    ),
                    
                    const SizedBox(height: 2),
                    
                    // Professional Summary (if available)
                    if (profile.professionalSummary.isNotEmpty)
                      Text(
                        profile.professionalSummary,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    
                    const SizedBox(height: 4),
                    
                    // Location and Availability Row
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 12, color: Colors.grey[500]),
                        const SizedBox(width: 2),
                        Text(
                          profile.displayLocation,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(Icons.schedule, size: 12, color: Colors.grey[500]),
                        const SizedBox(width: 2),
                        Expanded(
                          child: Text(
                            profile.availabilityDisplay,
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[600],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Professional Stats Row (No Card Wrapping)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem(
                  icon: Icons.work_outline,
                  label: 'Jobs',
                  value: profile.jobsCompleted.toString(),
                ),
                _buildVerticalDivider(),
                _buildStatItem(
                  icon: Icons.star_outline,
                  label: 'Rating',
                  value: profile.rating > 0 ? profile.rating.toStringAsFixed(1) : '0.0',
                ),
                _buildVerticalDivider(),
                _buildStatItem(
                  icon: Icons.rate_review_outlined,
                  label: 'Reviews',
                  value: profile.reviews.length.toString(),
                ),
                if (profile.trustScore != null) ...[
                  _buildVerticalDivider(),
                  _buildStatItem(
                    icon: Icons.verified_user_outlined,
                    label: 'Trust',
                    value: profile.trustScore!.overallScore.toStringAsFixed(1),
                  ),
                ],
              ],
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Action Buttons
          Row(
            children: [
              if (isOwnProfile)
                Expanded(
                  child: _buildActionButton(
                    label: 'Edit Profile',
                    icon: Icons.edit_outlined,
                    onPressed: onEditPressed,
                    isPrimary: true,
                  ),
                )
              else ...[
                Expanded(
                  child: _buildActionButton(
                    label: 'Message',
                    icon: Icons.message_outlined,
                    onPressed: onContactPressed,
                    isPrimary: true,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildActionButton(
                    label: 'Save',
                    icon: Icons.bookmark_border,
                    onPressed: () {
                      // Implement save profile functionality
                    },
                    isPrimary: false,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: const Color(0xFF3E8728),
          size: 16,
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 32,
      width: 1,
      color: Colors.grey[300],
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required VoidCallback? onPressed,
    required bool isPrimary,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 14,
        color: isPrimary ? Colors.white : Colors.grey[700],
      ),
      label: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: isPrimary ? Colors.white : Colors.grey[700],
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? const Color(0xFF3E8728) : Colors.white,
        side: isPrimary ? null : BorderSide(color: Colors.grey[300]!),
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }

  Color _getTrustLevelColor(String trustLevel) {
    switch (trustLevel.toUpperCase()) {
      case 'NEWCOMER':
        return Colors.orange;
      case 'BUILDING':
        return Colors.blue;
      case 'TRUSTED':
        return Colors.green;
      case 'EXPERT':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}