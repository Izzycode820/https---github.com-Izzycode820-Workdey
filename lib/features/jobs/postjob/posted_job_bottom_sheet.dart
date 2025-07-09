import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';
import 'package:workdey_frontend/core/providers/location/applicants_provider.dart';
import 'package:workdey_frontend/screens/applicants_screen.dart';
import 'package:workdey_frontend/screens/postjob_form.dart';

// ============================================================================
// CLEAN POSTED JOB BOTTOM SHEET - 55-65% height, mature design, proper integration
// ============================================================================

class CleanPostedJobBottomSheet extends ConsumerStatefulWidget {
  final Job job;

  const CleanPostedJobBottomSheet({
    super.key,
    required this.job,
  });

  @override
  ConsumerState<CleanPostedJobBottomSheet> createState() => _CleanPostedJobBottomSheetState();
}

class _CleanPostedJobBottomSheetState extends ConsumerState<CleanPostedJobBottomSheet> {
  bool _showFullDescription = false;
  bool _showFullRoles = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final bottomSheetHeight = screenHeight * 0.6; // 60% height - perfect balance

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
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildJobStatus(),
                  const SizedBox(height: 20),
                  _buildApplicationsOverview(),
                  const SizedBox(height: 20),
                  _buildJobInfo(),
                  const SizedBox(height: 20),
                  _buildDescription(),
                  if (widget.job.rolesDescription?.isNotEmpty == true) ...[
                    const SizedBox(height: 20),
                    _buildRolesDescription(),
                  ],
                  const SizedBox(height: 20),
                  _buildRequirements(),
                  const SizedBox(height: 20),
                  _buildSkills(),
                  const SizedBox(height: 20),
                  _buildWorkingDays(),
                  const SizedBox(height: 20),
                  _buildSalaryDetails(),
                  const SizedBox(height: 100), // Space for floating buttons
                ],
              ),
            ),
          ),
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
                Text(
                  '${widget.job.category} • ${widget.job.jobType}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              _buildHeaderButton(
                icon: Icons.edit,
                label: 'Edit',
                color: Colors.blue,
                onPressed: () {
                  Navigator.pop(context);
                  _navigateToEditForm();
                },
              ),
              const SizedBox(width: 8),
              _buildHeaderButton(
                icon: Icons.close,
                label: null,
                color: Colors.grey,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderButton({
    required IconData icon,
    String? label,
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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: color),
            if (label != null) ...[
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildJobStatus() {
    final isActive = widget.job.dueDate?.isAfter(DateTime.now()) ?? true;
    final daysLeft = widget.job.dueDate?.difference(DateTime.now()).inDays ?? 0;
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isActive ? Colors.green[50] : Colors.red[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isActive ? Colors.green[200]! : Colors.red[200]!,
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isActive ? Icons.check_circle : Icons.cancel,
            color: isActive ? Colors.green[600] : Colors.red[600],
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isActive ? 'Job is Active' : 'Job Expired',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isActive ? Colors.green[700] : Colors.red[700],
                  ),
                ),
                Text(
                  isActive 
                      ? daysLeft > 0 
                          ? 'Expires in $daysLeft days' 
                          : 'Expires today'
                      : 'No longer accepting applications',
                  style: TextStyle(
                    fontSize: 12,
                    color: isActive ? Colors.green[600] : Colors.red[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApplicationsOverview() {
    return _buildSection(
      title: 'Applications',
      icon: Icons.people,
      child: Consumer(
        builder: (context, ref, child) {
          final countsAsync = ref.watch(applicationCountsProvider(widget.job.id));
          
          return countsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Text('Error loading applications'),
            data: (counts) => Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        'Total',
                        '${counts.total}',
                        Icons.people_outline,
                        Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildStatCard(
                        'New (24h)',
                        '${counts.newApplications}',
                        Icons.fiber_new,
                        Colors.orange,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        'Pending',
                        '${counts.pending}',
                        Icons.hourglass_empty,
                        Colors.amber,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: _buildStatCard(
                        'Approved',
                        '${counts.approved}',
                        Icons.check_circle,
                        Colors.green,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: _buildStatCard(
                        'Rejected',
                        '${counts.rejected}',
                        Icons.cancel,
                        Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ApplicantsScreen(jobId: widget.job.id),
                        ),
                      );
                    },
                    icon: const Icon(Icons.people, size: 18),
                    label: const Text('View All Applicants'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3E8728),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3), width: 0.5),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
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
          _buildInfoRow('Location', _getLocationText()),
          if (widget.job.dueDate != null)
            _buildInfoRow('Deadline', _formatDate(widget.job.dueDate!)),
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

  Widget _buildSalaryDetails() {
    if (widget.job.jobType != 'PRO' && widget.job.jobType != 'LOC') {
      if (widget.job.typeSpecific['compensation_toggle'] == true) {
        return _buildSection(
          title: 'Compensation',
          icon: Icons.card_giftcard,
          child: Text(
            widget.job.typeSpecific['bonus_supplementary']?['details'] ?? 'Other benefits included',
            style: const TextStyle(fontSize: 14),
          ),
        );
      }
      return const SizedBox.shrink();
    }
    
    final salary = widget.job.typeSpecific['salary'];
    final period = widget.job.typeSpecific['salary_period'];
    
    if (salary == null) return const SizedBox.shrink();
    
    return _buildSection(
      title: 'Salary Details',
      icon: Icons.attach_money,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.green[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.green[200]!, width: 0.5),
        ),
        child: Row(
          children: [
            Icon(Icons.payments, color: Colors.green[600], size: 24),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'FCFA ${NumberFormat().format(salary)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.green[700],
                  ),
                ),
                Text(
                  'Per ${_getSalaryPeriodText(period)}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green[600],
                  ),
                ),
              ],
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
  String _getLocationText() {
    final parts = <String>[];
    if (widget.job.district?.isNotEmpty == true) parts.add(widget.job.district!);
    if (widget.job.city?.isNotEmpty == true) parts.add(widget.job.city!);
    if (parts.isEmpty && widget.job.location?.isNotEmpty == true) {
      parts.add(widget.job.location!);
    }
    return parts.isNotEmpty ? parts.join(', ') : 'Location not specified';
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  String _getSalaryPeriodText(String? period) {
    switch (period) {
      case 'd': return 'Day';
      case 'w': return 'Week';
      case 'm': return 'Month';
      default: return 'Period';
    }
  }

  void _navigateToEditForm() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CleanJobForm(existingJob: widget.job),
      ),
    );
  }
}