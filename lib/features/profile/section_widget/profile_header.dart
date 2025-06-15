import 'package:flutter/material.dart';
import 'package:workdey_frontend/core/models/profile/profile_model.dart';

class ProfileHeader extends StatelessWidget {
  final UserProfile profile;
  final VoidCallback onEditPressed;
  final VoidCallback onSettingsPressed;

  const ProfileHeader({
    super.key,
    required this.profile,
    required this.onEditPressed,
    required this.onSettingsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      transform: Matrix4.translationValues(0, -50, 0),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[200],
                child: profile.user.profilePicture != null
                    ? ClipOval(
                        child: Image.network(
                          profile.user.profilePicture!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Icon(Icons.person, size: 50, color: Colors.white),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Edit button
                    IconButton(
                      icon: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.edit, size: 18, color: Color(0xFF3E8728)),
                      ),
                      onPressed: onEditPressed,
                    ),
                    // Settings button
                    IconButton(
                      icon: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                        )],
                        ),
                        child: const Icon(Icons.settings, size: 18, color: Colors.grey),
                      ),
                      onPressed: onSettingsPressed,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            profile.user.fullName ?? 'No name',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            profile.bio,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildInfoChip(Icons.location_on, profile.location ?? 'Unknown'),
              const SizedBox(width: 12),
              _buildInfoChip(Icons.work_outline, '${profile.jobsCompleted} jobs'),
              const SizedBox(width: 12),
              _buildInfoChip(Icons.star, '${profile.rating}/5'),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Chip(
      avatar: Icon(icon, size: 16, color: const Color(0xFF3E8728)),
      label: Text(text),
      backgroundColor: Colors.grey[100],
      labelStyle: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 13,
        color: Colors.black87,
      ),
    );
  }
}