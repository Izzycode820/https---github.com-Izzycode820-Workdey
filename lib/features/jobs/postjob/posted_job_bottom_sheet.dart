import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';
import 'package:workdey_frontend/core/providers/location/applicants_provider.dart';
import 'package:workdey_frontend/screens/applicants_screen.dart';
import 'package:workdey_frontend/screens/edit_job_screen.dart';

class PostedJobDetailsBottomSheet extends ConsumerStatefulWidget {
  final Job job;

  const PostedJobDetailsBottomSheet({
    super.key,
    required this.job,
  });

  @override
  ConsumerState<PostedJobDetailsBottomSheet> createState() => _PostedJobDetailsBottomSheetState();
}

class _PostedJobDetailsBottomSheetState extends ConsumerState<PostedJobDetailsBottomSheet> {
  bool _showFullDescription = false;
  bool _showFullRoles = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final bottomSheetHeight = screenHeight * 0.75; // Slightly taller for management options

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
            
            // Header with management actions
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
                    _buildJobStatus(),
                    const SizedBox(height: 20),
                    _buildApplicationsOverview(),
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
                    _buildSalaryDetails(),
                    const SizedBox(height: 100), // Space for floating buttons
                  ],
                ),
              ),
            ),
          ],
        ),
        
        // ADD: Floating Action Buttons
        _FloatingActionButtons(job: widget.job),
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
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditJobScreen(job: widget.job),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.blue[50],
                    foregroundColor: Colors.blue[700],
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.grey[100],
                  ),
                ),
              ],
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
            if (widget.job.postTime != null)
              _buildInfoChip(
                'Posted ${widget.job.postTime}',
                Colors.grey[100]!,
                Icons.schedule,
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildJobStatus() {
    final isActive = widget.job.dueDate?.isAfter(DateTime.now()) ?? true;
    final daysLeft = widget.job.dueDate?.difference(DateTime.now()).inDays ?? 0;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isActive ? Colors.green[50] : Colors.red[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isActive ? Colors.green[200]! : Colors.red[200]!,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isActive ? Icons.check_circle : Icons.cancel,
            color: isActive ? Colors.green[700] : Colors.red[700],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isActive ? 'Job is Active' : 'Job Expired',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
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
          error: (error, stack) => Text('Error loading counts: $error'),
          data: (counts) => Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'Total Applications',
                      '${counts.total}',
                      Icons.people_outline,
                      Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      'New (24h)',
                      '${counts.newApplications}',
                      Icons.notification_important,
                      Colors.orange,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
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
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildStatCard(
                      'Approved',
                      '${counts.approved}',
                      Icons.check_circle,
                      Colors.green,
                    ),
                  ),
                  const SizedBox(width: 8),
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
            ],
          ),
        );
      },
    ),
  );
}

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
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
          const SizedBox(height: 8),
          _buildInfoRow('Category', widget.job.category),
          if (widget.job.dueDate != null) ...[
            const SizedBox(height: 8),
            _buildInfoRow('Application Deadline', _formatDate(widget.job.dueDate!)),
          ],
        ],
      ),
    );
  }

  Widget _buildLocationDetails() {
    return _buildSection(
      title: 'Location',
      icon: Icons.location_on,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow('Location', widget.job.locationDisplayText),
          if (widget.job.city != null) ...[
            const SizedBox(height: 8),
            _buildInfoRow('City', widget.job.city!),
          ],
          if (widget.job.district != null) ...[
            const SizedBox(height: 8),
            _buildInfoRow('District', widget.job.district!),
          ],
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
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
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
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
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

  Widget _buildSalaryDetails() {
    if (widget.job.jobType != 'PRO' && widget.job.jobType != 'LOC') {
      // Show compensation info for non-paid jobs
      if (widget.job.typeSpecific['compensation_toggle'] == true) {
        return _buildSection(
          title: 'Compensation',
          icon: Icons.card_giftcard,
          child: Text(
            widget.job.typeSpecific['bonus_supplementary']?['details'] ?? 'Other benefits included',
            style: const TextStyle(fontSize: 16),
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
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.green[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.green[200]!),
        ),
        child: Row(
          children: [
            Icon(Icons.payments, color: Colors.green[700], size: 32),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'FCFA ${NumberFormat().format(salary)}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
                Text(
                  'Per ${_getSalaryPeriodText(period)}',
                  style: TextStyle(
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

  // Helper widgets (same as before but adapted for posted jobs)
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
          style: const TextStyle(fontSize: 16, height: 1.5),
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

 String _getSalaryPeriodText(String? period) {
   switch (period) {
     case 'd': return 'Day';
     case 'w': return 'Week';
     case 'm': return 'Month';
     default: return 'Period';
   }
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

// Add floating action buttons at the bottom
class _FloatingActionButtons extends StatelessWidget {
 final Job job;

 const _FloatingActionButtons({required this.job});

 @override
 Widget build(BuildContext context) {
   return Positioned(
     bottom: 16,
     left: 16,
     right: 16,
     child: Row(
       children: [
         Expanded(
           child: ElevatedButton.icon(
             onPressed: () {
               Navigator.pop(context);
               Navigator.push(
                 context,
                 MaterialPageRoute(
                   builder: (context) => ApplicantsScreen(jobId: job.id),
                 ),
               );
             },
             icon: const Icon(Icons.people),
             label: const Text('View Applicants'),
             style: ElevatedButton.styleFrom(
               backgroundColor: Colors.blue[600],
               foregroundColor: Colors.white,
               padding: const EdgeInsets.symmetric(vertical: 12),
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(12),
               ),
             ),
           ),
         ),
         const SizedBox(width: 12),
         Expanded(
           child: ElevatedButton.icon(
             onPressed: () {
               Navigator.pop(context);
               Navigator.push(
                 context,
                 MaterialPageRoute(
                   builder: (context) => EditJobScreen(job: job),
                 ),
               );
             },
             icon: const Icon(Icons.edit),
             label: const Text('Edit Job'),
             style: ElevatedButton.styleFrom(
               backgroundColor: const Color(0xFF3E8728),
               foregroundColor: Colors.white,
               padding: const EdgeInsets.symmetric(vertical: 12),
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(12),
               ),
             ),
           ),
         ),
       ],
     ),
   );
 }
}