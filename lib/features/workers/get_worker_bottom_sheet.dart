// features/workers/worker_details_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:workdey_frontend/core/models/getworkers/get_workers_model.dart';

class WorkerDetailsBottomSheet extends StatelessWidget {
  final Worker worker;

  const WorkerDetailsBottomSheet({
    super.key,
    required this.worker,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final bottomSheetHeight = screenHeight * 0.6; // 60% height

    return Container(
      height: bottomSheetHeight,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          _buildHandle(),
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildWorkerProfile(),
                  const SizedBox(height: 20),
                  if (worker.bio?.isNotEmpty == true) ...[
                    _buildBioSection(),
                    const SizedBox(height: 20),
                  ],
                  if (worker.skills?.isNotEmpty == true) ...[
                    _buildSkillsSection(),
                    const SizedBox(height: 20),
                  ],
                  _buildContactInfo(),
                  const SizedBox(height: 100), // Space for floating buttons
                ],
              ),
            ),
          ),
          _buildFloatingButtons(context),
        ],
      ),
    );
  }

  Widget _buildHandle() {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 8),
      width: 32,
      height: 3,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          // Profile Picture
          CircleAvatar(
            radius: 24,
            backgroundImage: worker.profilePicture != null 
                ? NetworkImage(worker.profilePicture!) 
                : null,
            backgroundColor: _getProfileColor(),
            child: worker.profilePicture == null 
                ? Text(
                    _getInitials(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  worker.userName ?? 'Worker',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  worker.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF3E8728),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '${worker.categoryDisplay ?? worker.category} • ${worker.location}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          _buildVerificationBadges(),
        ],
      ),
    );
  }

  Widget _buildWorkerProfile() {
    return _buildSection(
      title: 'Professional Information',
      icon: Icons.work_outline,
      child: Column(
        children: [
          _buildInfoRow('Specialization', worker.categoryDisplay ?? worker.category),
          _buildInfoRow('Location', worker.location),
          if (worker.experienceYears != null)
            _buildInfoRow('Experience', '${worker.experienceYears} years'),
          if (worker.availability != null)
            _buildInfoRow('Availability', _getAvailabilityText(worker.availability!)),
          if (worker.portfolioLink?.isNotEmpty == true)
            _buildInfoRow('Portfolio', worker.portfolioLink!, isLink: true),
          _buildInfoRow('Posted', worker.postTime ?? 'Recently'),
        ],
      ),
    );
  }

  Widget _buildBioSection() {
    return _buildSection(
      title: 'About ${worker.userName ?? 'Worker'}',
      icon: Icons.person_outline,
      child: Text(
        worker.bio!,
        style: const TextStyle(
          fontSize: 14,
          height: 1.5,
          color: Color(0xFF181A1F),
        ),
      ),
    );
  }

  Widget _buildSkillsSection() {
    return _buildSection(
      title: 'Skills & Expertise',
      icon: Icons.psychology_outlined,
      child: Wrap(
        spacing: 8,
        runSpacing: 6,
        children: worker.skills!
            .map((skill) => _buildSkillChip(skill))
            .toList(),
      ),
    );
  }

  Widget _buildContactInfo() {
    return _buildSection(
      title: 'Contact Information',
      icon: Icons.contact_phone_outlined,
      child: Column(
        children: [
          _buildInfoRow('Profile ID', '#${worker.id}'),
          if (worker.createdAt != null)
            _buildInfoRow('Member since', _formatDate(worker.createdAt)),
          _buildInfoRow('Contact via', 'WhatsApp, Phone, or Social Media'),
        ],
      ),
    );
  }

  Widget _buildFloatingButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey[200]!, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildActionButton(
              icon: Icons.phone,
              label: 'Call',
              color: const Color(0xFF3E8728),
              onPressed: () {
                // TODO: Implement phone call functionality
                _showComingSoon(context, 'Phone Call');
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildActionButton(
              icon: Icons.chat,
              label: 'WhatsApp',
              color: const Color(0xFF25D366),
              onPressed: () {
                // TODO: Implement WhatsApp functionality
                _showComingSoon(context, 'WhatsApp');
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildActionButton(
              icon: Icons.camera_alt,
              label: 'Instagram',
              color: const Color(0xFFE4405F),
              onPressed: () {
                // TODO: Implement Instagram functionality
                _showComingSoon(context, 'Instagram');
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildActionButton(
              icon: Icons.facebook,
              label: 'Facebook',
              color: const Color(0xFF1877F2),
              onPressed: () {
                // TODO: Implement Facebook functionality
                _showComingSoon(context, 'Facebook');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3), width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widgets
  Widget _buildSection({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: Colors.grey[600]),
            const SizedBox(width: 6),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF181A1F),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isLink = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: isLink ? const Color(0xFF3E8728) : const Color(0xFF181A1F),
                decoration: isLink ? TextDecoration.underline : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF3E8728).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF3E8728).withOpacity(0.3), width: 0.5),
      ),
      child: Text(
        skill,
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFF3E8728),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildVerificationBadges() {
    if (worker.verificationBadges == null) return const SizedBox.shrink();
    
    final badges = worker.verificationBadges!;
    final verifiedCount = [
      badges['email'] == true,
      badges['phone'] == true,
      badges['id'] == true,
    ].where((v) => v).length;

    if (verifiedCount == 0) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: verifiedCount == 3 ? Colors.green[50] : Colors.orange[50],
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: verifiedCount == 3 ? Colors.green[300]! : Colors.orange[300]!,
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.verified,
            size: 14,
            color: verifiedCount == 3 ? Colors.green[600] : Colors.orange[600],
          ),
          const SizedBox(width: 4),
          Text(
            'Verified',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: verifiedCount == 3 ? Colors.green[600] : Colors.orange[600],
            ),
          ),
        ],
      ),
    );
  }

  // Helper methods
  Color _getProfileColor() {
    switch (worker.category.toLowerCase()) {
      case 'plumber':
        return Colors.blue;
      case 'electrician':
        return Colors.orange;
      case 'carpenter':
        return Colors.brown;
      case 'cleaner':
        return Colors.green;
      case 'construction':
        return Colors.grey;
      default:
        return const Color(0xFF3E8728);
    }
  }

  String _getInitials() {
    final name = worker.userName ?? worker.title;
    if (name.isEmpty) return '?';
    
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name[0].toUpperCase();
  }

  String _getAvailabilityText(String availability) {
    switch (availability) {
      case 'FT': return 'Full-time';
      case 'PT': return 'Part-time';
      case 'CN': return 'Contract';
      case 'FL': return 'Freelance';
      default: return availability;
    }
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.year}';
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature integration coming soon!'),
        backgroundColor: const Color(0xFF3E8728),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  static void show(BuildContext context, Worker worker) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => WorkerDetailsBottomSheet(worker: worker),
    );
  }
}