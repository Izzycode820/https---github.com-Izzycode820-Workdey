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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF3E8728),
            const Color(0xFF3E8728).withOpacity(0.8),
          ],
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 60), // Space for status bar
          
          // Profile Picture and Basic Info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                // Profile Picture
                Stack(
                  children: [
                    Hero(
                      tag: 'profile_picture_${profile.user.id}',
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 4,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey[300],
                          backgroundImage: profile.user.profilePicture != null
                              ? NetworkImage(profile.user.profilePicture!)
                              : null,
                          child: profile.user.profilePicture == null
                              ? Text(
                                  (profile.user.firstName?[0] ?? 'U').toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                )
                              : null,
                        ),
                      ),
                    ),
                    
                    // Verification Badge
                    if (profile.user.verificationLevel >= 3)
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.verified,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    
                    // Trust Level Badge
                    if (profile.trustScore != null)
                      Positioned(
                        bottom: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getTrustLevelColor(profile.trustScore!.trustLevel),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Text(
                            profile.trustScore!.trustLevelEmoji,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Name and Title
                Text(
                  profile.fullName,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 4),
                
                if (profile.professionalSummary.isNotEmpty)
                  Text(
                    profile.professionalSummary,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    textAlign: TextAlign.center,
                  ),
                
                const SizedBox(height: 8),
                
                // Location and Availability
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      profile.displayLocation,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.schedule,
                      size: 16,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      profile.availabilityDisplay,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Stats Row
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatItem(
                        label: 'Jobs Completed',
                        value: profile.jobsCompleted.toString(),
                        icon: Icons.work_outline,
                      ),
                      _buildVerticalDivider(),
                      _buildStatItem(
                        label: 'Trust Score',
                        value: profile.trustScore?.overallScore.toStringAsFixed(1) ?? '0.0',
                        icon: Icons.star_outline,
                      ),
                      _buildVerticalDivider(),
                      _buildStatItem(
                        label: 'Reviews',
                        value: profile.reviews.length.toString(),
                        icon: Icons.rate_review_outlined,
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Action Buttons
                Row(
                  children: [
                    if (isOwnProfile)
                      Expanded(
                        child: _buildActionButton(
                          label: 'Edit Profile',
                          icon: Icons.edit_outlined,
                          onPressed: onEditPressed,
                          isPrimary: false,
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
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildActionButton(
                          label: 'Save',
                          icon: Icons.bookmark_border,
                          onPressed: () {
                            // Implement save profile
                          },
                          isPrimary: false,
                        ),
                      ),
                    ],
                  ],
                ),
                
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: Colors.white.withOpacity(0.9),
          size: 20,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.8),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.white.withOpacity(0.3),
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
        size: 18,
        color: isPrimary ? const Color(0xFF3E8728) : Colors.white,
      ),
      label: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: isPrimary ? const Color(0xFF3E8728) : Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? Colors.white : Colors.transparent,
        foregroundColor: isPrimary ? const Color(0xFF3E8728) : Colors.white,
        side: isPrimary ? null : const BorderSide(color: Colors.white, width: 1),
        elevation: isPrimary ? 2 : 0,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Color _getTrustLevelColor(String trustLevel) {
    switch (trustLevel) {
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