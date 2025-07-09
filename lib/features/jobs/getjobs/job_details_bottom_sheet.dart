import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';
import 'package:workdey_frontend/features/application/application_form_screen.dart';

class JobDetailsBottomSheet extends ConsumerStatefulWidget {
  final Job job;

  const JobDetailsBottomSheet({
    super.key,
    required this.job,
  });

  @override
  ConsumerState<JobDetailsBottomSheet> createState() => _JobDetailsBottomSheetState();
}

class _JobDetailsBottomSheetState extends ConsumerState<JobDetailsBottomSheet> {
  bool _showFullDescription = false;
  bool _showFullRoles = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final bottomSheetHeight = screenHeight * 0.6; // 60% height - consistent with posted jobs

    return Container(
      height: bottomSheetHeight,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              _buildHandle(),
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildJobStatus(),
                      const SizedBox(height: 20),
                      _buildJobInfo(),
                      const SizedBox(height: 20),
                      _buildLocationDetails(),
                      const SizedBox(height: 20),
                      _buildDescription(),
                      if (widget.job.rolesDescription?.isNotEmpty == true) ...[
                        const SizedBox(height: 20),
                        _buildRolesDescription(),
                      ],
                      const SizedBox(height: 20),
                      _buildRequirements(),
                      const SizedBox(height: 20),
                      _buildWorkingDays(),
                      const SizedBox(height: 20),
                      _buildSkills(),
                      const SizedBox(height: 20),
                      _buildPosterInfo(),
                      const SizedBox(height: 100), // Space for floating button
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Floating Apply Button
          _FloatingApplyButton(job: widget.job),
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

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.job.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      widget.job.posterName ?? 'Anonymous',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '• ${widget.job.category}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              _buildJobTypeChip(),
              const SizedBox(width: 8),
              _buildHeaderButton(
                icon: Icons.close,
                color: Colors.grey,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildJobTypeChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getJobTypeColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        _getJobTypeLabel(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: _getJobTypeColor(),
        ),
      ),
    );
  }

  Widget _buildHeaderButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 16, color: color),
      ),
    );
  }

  Widget _buildJobStatus() {
    final hasApplied = widget.job.hasApplied;
    final isExpired = widget.job.expiresIn == 'Expired';
    
    Color statusColor;
    IconData statusIcon;
    String statusText;
    String statusSubtext;
    
    if (hasApplied) {
      statusColor = Colors.blue;
      statusIcon = Icons.check_circle;
      statusText = 'Application Submitted';
      statusSubtext = 'Your application is being reviewed';
    } else if (isExpired) {
      statusColor = Colors.red;
      statusIcon = Icons.cancel;
      statusText = 'Application Closed';
      statusSubtext = 'This job is no longer accepting applications';
    } else {
      statusColor = Colors.green;
      statusIcon = Icons.work;
      statusText = 'Open for Applications';
      statusSubtext = widget.job.expiresIn ?? 'Apply now to be considered';
    }
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: statusColor.withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          Icon(
            statusIcon,
            color: Colors.green[600],
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  statusText,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.green[700],
                  ),
                ),
                Text(
                  statusSubtext,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobInfo() {
    return _buildSection(
      title: 'Job Information',
      icon: Icons.info_outline,
      child: Column(
        children: [
          _buildInfoRow('Job Nature', widget.job.jobNature ?? 'Not specified'),
          _buildInfoRow('Category', widget.job.category),
          _buildInfoRow('Posted', widget.job.postTime ?? 'Recently'),
          if (widget.job.dueDate != null)
            _buildInfoRow('Deadline', _formatDate(widget.job.dueDate!)),
          if (widget.job.salaryDisplay != null)
            _buildInfoRow('Salary', widget.job.salaryDisplay!),
        ],
      ),
    );
  }

  Widget _buildLocationDetails() {
    return _buildSection(
      title: 'Location Details',
      icon: Icons.location_on,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow('Location', widget.job.locationDisplayText),
          if (widget.job.distanceText.isNotEmpty)
            _buildInfoRow('Distance', widget.job.distanceText),
          if (widget.job.transportInfo != null) ...[
            const SizedBox(height: 8),
            _buildTransportInfo(),
          ],
        ],
      ),
    );
  }

  Widget _buildTransportInfo() {
    final transport = widget.job.transportInfo!;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: widget.job.isAffordableForUser ? Colors.green[50] : Colors.orange[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: widget.job.isAffordableForUser ? Colors.green[200]! : Colors.orange[200]!,
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transport Information',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: widget.job.isAffordableForUser ? Colors.green[700] : Colors.orange[700],
            ),
          ),
          const SizedBox(height: 6),
          if (transport['duration_minutes'] != null)
            _buildInfoRow('Travel Time', '${transport['duration_minutes']} minutes'),
          if (transport['cost_fcfa'] != null)
            _buildInfoRow('Transport Cost', '${transport['cost_fcfa']} FCFA'),
          if (transport['transport_type'] != null)
            _buildInfoRow('Method', transport['transport_type']),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return _buildSection(
      title: 'Job Description',
      icon: Icons.description,
      child: _buildExpandableText(
        widget.job.description,
        _showFullDescription,
        () => setState(() => _showFullDescription = !_showFullDescription),
      ),
    );
  }

  Widget _buildRolesDescription() {
    return _buildSection(
      title: 'Roles & Responsibilities',
      icon: Icons.assignment,
      child: _buildExpandableText(
        widget.job.rolesDescription!,
        _showFullRoles,
        () => setState(() => _showFullRoles = !_showFullRoles),
      ),
    );
  }

  Widget _buildRequirements() {
    if (widget.job.requirements?.isEmpty != false) return const SizedBox.shrink();
    
    return _buildSection(
      title: 'Requirements',
      icon: Icons.checklist,
      child: Wrap(
        spacing: 6,
        runSpacing: 4,
        children: widget.job.requirements!
            .map((req) => _buildChip(req, Colors.blue))
            .toList(),
      ),
    );
  }

  Widget _buildWorkingDays() {
    if (widget.job.workingDays?.isEmpty != false) return const SizedBox.shrink();
    
    return _buildSection(
      title: 'Working Days',
      icon: Icons.calendar_today,
      child: Wrap(
        spacing: 6,
        runSpacing: 4,
        children: widget.job.workingDays!
            .map((day) => _buildChip(day, Colors.orange))
            .toList(),
      ),
    );
  }

  Widget _buildSkills() {
    final hasRequired = widget.job.requiredSkills?.isNotEmpty == true;
    final hasOptional = widget.job.optionalSkills?.isNotEmpty == true;
    
    if (!hasRequired && !hasOptional) return const SizedBox.shrink();
    
    return _buildSection(
      title: 'Skills Required',
      icon: Icons.psychology,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasRequired) ...[
            const Text(
              'Required Skills',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: widget.job.requiredSkills!
                  .map((skill) => _buildChip(skill, Colors.red))
                  .toList(),
            ),
          ],
          if (hasRequired && hasOptional) const SizedBox(height: 12),
          if (hasOptional) ...[
            const Text(
              'Nice to Have',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: widget.job.optionalSkills!
                  .map((skill) => _buildChip(skill, Colors.green))
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPosterInfo() {
    return _buildSection(
      title: 'Posted By',
      icon: Icons.person,
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[200],
            backgroundImage: widget.job.posterPicture != null 
                ? NetworkImage(widget.job.posterPicture!) 
                : null,
            child: widget.job.posterPicture == null 
                ? Icon(Icons.person, size: 20, color: Colors.grey[600])
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.job.posterName ?? 'Anonymous',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                _buildVerificationStatus(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationStatus() {
    if (widget.job.verificationBadges == null) {
      return Text(
        'No verification info',
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
        ),
      );
    }
    
    final badges = widget.job.verificationBadges!;
    final verifications = <String>[];
    
    if (badges['email'] == true) verifications.add('Email');
    if (badges['phone'] == true) verifications.add('Phone');
    if (badges['id'] == true) verifications.add('ID');
    
    if (verifications.isEmpty) {
      return Text(
        'Not verified',
        style: TextStyle(
          fontSize: 12,
          color: Colors.red[600],
        ),
      );
    }
    
    return Row(
      children: [
        Icon(
          Icons.verified,
          size: 14,
          color: verifications.length == 3 ? Colors.green[600] : Colors.blue[600],
        ),
        const SizedBox(width: 4),
        Text(
          'Verified: ${verifications.join(', ')}',
          style: TextStyle(
            fontSize: 12,
            color: verifications.length == 3 ? Colors.green[600] : Colors.blue[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
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
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  Widget _buildExpandableText(String text, bool isExpanded, VoidCallback onToggle) {
    const maxLines = 3;
    final shouldShowExpand = text.split('\n').length > maxLines || text.length > 150;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            height: 1.4,
          ),
          maxLines: isExpanded ? null : maxLines,
          overflow: isExpanded ? null : TextOverflow.ellipsis,
        ),
        if (shouldShowExpand) ...[
          const SizedBox(height: 6),
          GestureDetector(
            onTap: onToggle,
            child: Text(
              isExpanded ? 'Show Less' : 'Read More',
              style: const TextStyle(
                color: Color(0xFF3E8728),
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
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
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.3), width: 0.5),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // Helper methods
  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  Color _getJobTypeColor() {
    switch (widget.job.jobType.toUpperCase()) {
      case 'PRO':
        return const Color(0xFF1976D2); // Blue
      case 'INT':
        return const Color(0xFF7B1FA2); // Purple
      case 'VOL':
        return const Color(0xFFF57C00); // Orange
      case 'LOC':
        return const Color(0xFF388E3C); // Green
      default:
        return Colors.grey[600]!;
    }
  }

  String _getJobTypeLabel() {
    switch (widget.job.jobType.toUpperCase()) {
      case 'PRO':
        return 'Professional';
      case 'INT':
        return 'Internship';
      case 'VOL':
        return 'Volunteer';
      case 'LOC':
        return 'Local';
      default:
        return widget.job.jobType;
    }
  }
}

// Add floating apply button at the bottom
class _FloatingApplyButton extends StatelessWidget {
  final Job job;

  const _FloatingApplyButton({required this.job});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16,
      left: 16,
      right: 16,
      child: ElevatedButton(
        onPressed: job.hasApplied 
            ? null 
            : () {
                Navigator.pop(context); // Close bottom sheet
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ApplicationFormScreen(job: job),
                  ),
                );
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: job.hasApplied ? Colors.grey : const Color(0xFF3E8728),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 2,
        ),
        child: Text(
          job.hasApplied ? 'ALREADY APPLIED' : 'APPLY NOW',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}