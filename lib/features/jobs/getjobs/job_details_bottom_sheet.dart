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
    final bottomSheetHeight = screenHeight * 0.65;

    return Container(
    height: bottomSheetHeight,
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    child: Stack( // Changed from Column to Stack
      children: [
        Column(
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: _buildHeader(),
            ),
            
            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
        
        // ADD: Floating Apply Button
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: ElevatedButton(
            onPressed: widget.job.hasApplied 
                ? null 
                : () {
                    Navigator.pop(context); // Close bottom sheet
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ApplicationFormScreen(job: widget.job),
                      ),
                    );
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.job.hasApplied ? Colors.grey : const Color(0xFF3E8728),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              widget.job.hasApplied ? 'ALREADY APPLIED' : 'APPLY NOW',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                widget.job.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
            ),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close),
              style: IconButton.styleFrom(
                backgroundColor: Colors.grey[100],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        
        // Job meta info chips
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildInfoChip(
              widget.job.jobType,
              _getJobTypeColor(widget.job.jobType),
              Icons.work,
            ),
            _buildInfoChip(
              widget.job.category,
              Colors.blue[100]!,
              Icons.category,
            ),
            if (widget.job.salaryDisplay != null)
              _buildInfoChip(
                widget.job.salaryDisplay!,
                Colors.green[100]!,
                Icons.attach_money,
              ),
            if (widget.job.expiresIn != null)
              _buildInfoChip(
                widget.job.expiresIn!,
                widget.job.expiresIn == 'Expired' 
                    ? Colors.red[100]! 
                    : Colors.orange[100]!,
                Icons.schedule,
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoChip(String label, Color backgroundColor, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.grey[700]),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow('Job Nature', widget.job.jobNature ?? 'Not specified'),
          const SizedBox(height: 8),
          _buildInfoRow('Category', widget.job.category),
          const SizedBox(height: 8),
          _buildInfoRow('Posted', widget.job.postTime ?? 'Recently'),
          if (widget.job.dueDate != null) ...[
            const SizedBox(height: 8),
            _buildInfoRow('Due Date', _formatDate(widget.job.dueDate!)),
          ],
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
          if (widget.job.distanceText.isNotEmpty) ...[
            const SizedBox(height: 8),
            _buildInfoRow('Distance', widget.job.distanceText),
          ],
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
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transport Options',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: widget.job.isAffordableForUser ? Colors.green[700] : Colors.orange[700],
            ),
          ),
          const SizedBox(height: 8),
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
        spacing: 8,
        runSpacing: 8,
        children: widget.job.requirements!
            .map((req) => _buildRequirementChip(req))
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
        spacing: 8,
        runSpacing: 8,
        children: widget.job.workingDays!
            .map((day) => _buildDayChip(day))
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
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.job.requiredSkills!
                  .map((skill) => _buildSkillChip(skill, isRequired: true))
                  .toList(),
            ),
          ],
          if (hasRequired && hasOptional) const SizedBox(height: 16),
          if (hasOptional) ...[
            const Text(
              'Nice to Have',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.job.optionalSkills!
                  .map((skill) => _buildSkillChip(skill, isRequired: false))
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
            radius: 24,
            backgroundImage: widget.job.posterPicture != null 
                ? NetworkImage(widget.job.posterPicture!) 
                : null,
            child: widget.job.posterPicture == null 
                ? const Icon(Icons.person, size: 24)
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
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
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
      return const Text('No verification info');
    }
    
    final badges = widget.job.verificationBadges!;
    final verifications = <String>[];
    
    if (badges['email'] == true) verifications.add('Email');
    if (badges['phone'] == true) verifications.add('Phone');
    if (badges['id'] == true) verifications.add('ID');
    
    if (verifications.isEmpty) {
      return Text(
        'Not verified',
        style: TextStyle(color: Colors.red[600]),
      );
    }
    
    return Row(
      children: [
        Icon(
          Icons.verified,
          size: 16,
          color: verifications.length == 3 ? Colors.green : Colors.blue,
        ),
        const SizedBox(width: 4),
        Text(
          'Verified: ${verifications.join(', ')}',
          style: TextStyle(
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
            Icon(icon, size: 20, color: Colors.grey[600]),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
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
            fontSize: 16,
            height: 1.5,
          ),
          maxLines: isExpanded ? null : maxLines,
          overflow: isExpanded ? null : TextOverflow.ellipsis,
        ),
        if (shouldShowExpand) ...[
          const SizedBox(height: 8),
          GestureDetector(
            onTap: onToggle,
            child: Text(
              isExpanded ? 'Show Less' : 'Read More',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _buildRequirementChip(String requirement) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Text(
        requirement,
        style: TextStyle(
          fontSize: 12,
          color: Colors.blue[700],
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildDayChip(String day) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange[200]!),
      ),
      child: Text(
        day,
        style: TextStyle(
          fontSize: 12,
          color: Colors.orange[700],
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildSkillChip(String skill, {required bool isRequired}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isRequired ? Colors.red[50] : Colors.green[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isRequired ? Colors.red[200]! : Colors.green[200]!,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isRequired ? Icons.star : Icons.add,
            size: 12,
            color: isRequired ? Colors.red[700] : Colors.green[700],
          ),
          const SizedBox(width: 4),
          Text(
            skill,
            style: TextStyle(
              fontSize: 12,
              color: isRequired ? Colors.red[700] : Colors.green[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  Color _getJobTypeColor(String type) {
    switch (type.toUpperCase()) {
      case 'PRO':
        return Colors.blue[100]!;
      case 'INT':
        return Colors.purple[100]!;
      case 'VOL':
        return Colors.orange[100]!;
      case 'LOC':
        return Colors.teal[100]!;
      default:
        return Colors.grey[100]!;
    }
  }
}



// // Add floating apply button
// class _FloatingApplyButton extends StatelessWidget {
//   final Job job;

//   const _FloatingApplyButton({required this.job});

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       bottom: 16,
//       left: 16,
//       right: 16,
//       child: ElevatedButton(
//         onPressed: job.hasApplied 
//             ? null 
//             : () {
//                 Navigator.pop(context); // Close bottom sheet
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => ApplicationFormScreen(job: job),
//                   ),
//                 );
//               },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: job.hasApplied ? Colors.grey : const Color(0xFF3E8728),
//           padding: const EdgeInsets.symmetric(vertical: 16),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//         child: Text(
//           job.hasApplied ? 'ALREADY APPLIED' : 'APPLY NOW',
//           style: const TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 16,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }