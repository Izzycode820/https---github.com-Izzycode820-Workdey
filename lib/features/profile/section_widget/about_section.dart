// lib/features/profile/widgets/about_section.dart
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
      color: Colors.white,
      padding: const EdgeInsets.all(16),
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
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              if (isOwnProfile)
                InkWell(
                  onTap: onEdit,
                  borderRadius: BorderRadius.circular(4),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      Icons.edit_outlined,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Bio Content
          if (profile.bio.isNotEmpty)
            Text(
              profile.bio,
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
                color: Colors.black87,
              ),
            )
          else if (isOwnProfile)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.edit_note,
                    size: 24,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Add a bio to tell others about yourself',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: onEdit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3E8728),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      elevation: 0,
                    ),
                    child: const Text('Add Bio', style: TextStyle(fontSize: 11)),
                  ),
                ],
              ),
            ),

          // Key Information
          if (profile.bio.isNotEmpty) ...[
            const SizedBox(height: 16),
            _buildInfoGrid(),
          ],
          
          // Verification Status
          if (profile.verificationBadgesList.isNotEmpty) ...[
            const SizedBox(height: 16),
            _buildVerificationSection(),
          ],
          
          // Languages
          if (profile.languagesSpoken != null && profile.languagesSpoken!.isNotEmpty) ...[
            const SizedBox(height: 16),
            _buildLanguagesSection(),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoGrid() {
    final infoItems = <Map<String, dynamic>>[];
    
    if (profile.totalYearsExperience > 0) {
      infoItems.add({
        'icon': Icons.work_history_outlined,
        'label': 'Experience',
        'value': '${profile.totalYearsExperience} years (${profile.experienceLevel})',
      });
    }
    
    if (profile.availability.isNotEmpty) {
      infoItems.add({
        'icon': Icons.schedule_outlined,
        'label': 'Availability',
        'value': profile.availabilityDisplay,
      });
    }
    
    if (profile.willingToLearn) {
      infoItems.add({
        'icon': Icons.school_outlined,
        'label': 'Learning',
        'value': 'Open to learning new skills',
      });
    }
    
    if (profile.transport != null && profile.transport!.isNotEmpty) {
      infoItems.add({
        'icon': Icons.directions_bus_outlined,
        'label': 'Transport',
        'value': _getTransportDisplay(profile.transport!),
      });
    }
    
    if (profile.city != null || profile.district != null) {
      infoItems.add({
        'icon': Icons.location_on_outlined,
        'label': 'Location',
        'value': profile.displayLocation,
      });
    }
    
    if (profile.hourlyRateMin != null && profile.hourlyRateMax != null) {
      infoItems.add({
        'icon': Icons.attach_money_outlined,
        'label': 'Rate',
        'value': '${profile.hourlyRateMin!.toInt()} - ${profile.hourlyRateMax!.toInt()} FCFA/hr',
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
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 16,
            color: const Color(0xFF3E8728),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13,
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
              size: 14,
              color: Colors.blue[600],
            ),
            const SizedBox(width: 6),
            Text(
              'Verified',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: profile.verificationBadgesList.map((badge) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green[200]!),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 10,
                    color: Colors.green[600],
                  ),
                  const SizedBox(width: 3),
                  Text(
                    badge,
                    style: TextStyle(
                      fontSize: 10,
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
              size: 14,
              color: Color(0xFF3E8728),
            ),
            const SizedBox(width: 6),
            Text(
              'Languages',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: profile.languagesSpoken!.map((language) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF3E8728).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF3E8728).withOpacity(0.3)),
              ),
              child: Text(
                language,
                style: const TextStyle(
                  fontSize: 10,
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