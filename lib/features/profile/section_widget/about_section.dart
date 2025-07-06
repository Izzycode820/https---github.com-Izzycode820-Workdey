// lib/features/profile/widgets/profile_about_section.dart
import 'package:flutter/material.dart';
import 'package:workdey_frontend/core/models/profile/profile_model.dart';

class ProfileAboutSection extends StatelessWidget {
  final UserProfile profile;
  final bool isOwnProfile;
  final VoidCallback? onEdit;

  const ProfileAboutSection({
    super.key,
    required this.profile,
    required this.isOwnProfile,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'About',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                if (isOwnProfile)
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, size: 20),
                    onPressed: onEdit,
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.grey[100],
                      foregroundColor: Colors.grey[700],
                    ),
                  ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Bio
            if (profile.bio.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile.bio,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              )
            else if (isOwnProfile)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.edit_note,
                      size: 32,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Add a bio to tell others about yourself',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: onEdit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3E8728),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      ),
                      child: const Text('Add Bio'),
                    ),
                  ],
                ),
              ),

            // Key Information Grid
            _buildInfoGrid(),
            
            // Verification Status
            if (profile.verificationBadgesList.isNotEmpty) ...[
              const SizedBox(height: 20),
              _buildVerificationSection(),
            ],
            
            // Languages and Preferences
            if (profile.languagesSpoken != null && profile.languagesSpoken!.isNotEmpty) ...[
              const SizedBox(height: 20),
              _buildLanguagesSection(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoGrid() {
    final infoItems = <Map<String, dynamic>>[];
    
    // Add experience level
    if (profile.totalYearsExperience > 0) {
      infoItems.add({
        'icon': Icons.work_history_outlined,
        'label': 'Experience Level',
        'value': '${profile.totalYearsExperience} years (${profile.experienceLevel})',
      });
    }
    
    // Add availability
    if (profile.availability.isNotEmpty) {
      infoItems.add({
        'icon': Icons.schedule_outlined,
        'label': 'Availability',
        'value': profile.availabilityDisplay,
      });
    }
    
    // Add willing to learn
    if (profile.willingToLearn) {
      infoItems.add({
        'icon': Icons.school_outlined,
        'label': 'Learning Attitude',
        'value': 'Open to learning new skills',
      });
    }
    
    // Add transport
    if (profile.transport != null && profile.transport!.isNotEmpty) {
      infoItems.add({
        'icon': Icons.directions_bus_outlined,
        'label': 'Transport',
        'value': _getTransportDisplay(profile.transport!),
      });
    }
    
    // Add location details
    if (profile.city != null || profile.district != null) {
      infoItems.add({
        'icon': Icons.location_on_outlined,
        'label': 'Location',
        'value': profile.displayLocation,
      });
    }
    
    // Add hourly rate if available
    if (profile.hourlyRateMin != null && profile.hourlyRateMax != null) {
      infoItems.add({
        'icon': Icons.attach_money_outlined,
        'label': 'Hourly Rate',
        'value': '${profile.hourlyRateMin!.toInt()} - ${profile.hourlyRateMax!.toInt()} FCFA',
      });
    }

    if (infoItems.isEmpty) return const SizedBox.shrink();

    return Column(
      children: infoItems.map((item) => _buildInfoItem(
        icon: item['icon'],
        label: item['label'],
        value: item['value'],
      )).toList(),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF3E8728).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 20,
              color: const Color(0xFF3E8728),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.verified_user,
              size: 18,
              color: Colors.blue[600],
            ),
            const SizedBox(width: 8),
            Text(
              'Verification Status',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: profile.verificationBadgesList.map((badge) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.green[200]!),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 14,
                    color: Colors.green[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '$badge Verified',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.green[700],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildLanguagesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.language,
              size: 18,
              color: Color(0xFF3E8728),
            ),
            const SizedBox(width: 8),
            Text(
              'Languages',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: profile.languagesSpoken!.map((language) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF3E8728).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF3E8728).withOpacity(0.3)),
              ),
              child: Text(
                language,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF3E8728),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  String _getTransportDisplay(String transport) {
    switch (transport.toLowerCase()) {
      case 'walk':
        return 'Walking';
      case 'bicycle':
        return 'Bicycle';
      case 'motorcycle':
        return 'Motorcycle';
      case 'car':
        return 'Car';
      case 'public':
        return 'Public Transport';
      default:
        return transport;
    }
  }
}