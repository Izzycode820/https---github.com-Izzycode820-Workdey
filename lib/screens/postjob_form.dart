import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';
import 'package:workdey_frontend/core/models/postjob/post_job_model.dart';
import 'package:workdey_frontend/core/providers/post_job_provider.dart';

// ============================================================================
// CLEAN JOB FORM - No more primitive branching or manual controllers
// ============================================================================

class CleanJobForm extends ConsumerStatefulWidget {
  final Job? existingJob; // Clean - just pass the job if editing, null if creating
  
  const CleanJobForm({
    super.key,
    this.existingJob,
  });

  @override
  ConsumerState<CleanJobForm> createState() => _CleanJobFormState();
}

class _CleanJobFormState extends ConsumerState<CleanJobForm> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();
  
  // Clean controller management - only what we actually need
  final _skillController = TextEditingController();
  final _requirementController = TextEditingController();
  
  // Focus nodes for keyboard handling
  final _skillFocus = FocusNode();
  final _requirementFocus = FocusNode();
  
  @override
  void initState() {
    super.initState();
    _setupForm();
    _setupKeyboardHandling();
  }

  // Clean initialization - no more primitive branching
  void _setupForm() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = ref.read(jobFormNotifierProvider.notifier);
      
      if (widget.existingJob != null) {
        // Clean edit initialization - no extensions or manual conversions
        notifier.initializeForEdit(widget.existingJob!);
      } else {
        // Clean create initialization
        notifier.initializeForCreate();
      }
    });
  }

  void _setupKeyboardHandling() {
    _skillFocus.addListener(() {
      if (!_skillFocus.hasFocus && _skillController.text.isNotEmpty) {
        _addSkill();
      }
    });
    
    _requirementFocus.addListener(() {
      if (!_requirementFocus.hasFocus && _requirementController.text.isNotEmpty) {
        _addRequirement();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(jobFormNotifierProvider);
    final isEditing = widget.existingJob != null;
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildCleanAppBar(isEditing, formState.isLoading),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProgressIndicator(formState),
              const SizedBox(height: 20),
              _buildJobTypeSection(formState),
              const SizedBox(height: 20),
              _buildBasicInfoSection(formState),
              const SizedBox(height: 20),
              _buildLocationSection(formState),
              const SizedBox(height: 20),
              _buildJobDetailsSection(formState),
              const SizedBox(height: 20),
              _buildCompensationSection(formState),
              const SizedBox(height: 20),
              _buildSkillsSection(formState),
              const SizedBox(height: 20),
              _buildRequirementsSection(formState),
              const SizedBox(height: 20),
              _buildWorkingDaysSection(formState),
              const SizedBox(height: 80), // Space for floating button
            ],
          ),
        ),
      ),
      floatingActionButton: _buildSubmitButton(formState, isEditing),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // Clean app bar - no complex branching
  PreferredSizeWidget _buildCleanAppBar(bool isEditing, bool isLoading) {
    return AppBar(
      title: Text(
        isEditing ? 'Edit Job' : 'Post New Job',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0.5,
      actions: [
        if (!isLoading)
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
      ],
    );
  }

  // Clean progress indicator
  Widget _buildProgressIndicator(JobFormState formState) {
    final progress = _calculateProgress(formState.job);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Progress',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
              const Spacer(),
              Text(
                '${(progress * 100).toInt()}%',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF3E8728),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF3E8728)),
            minHeight: 6,
          ),
        ],
      ),
    );
  }

  // Clean job type section
  Widget _buildJobTypeSection(JobFormState formState) {
    return _buildSection(
      title: 'Job Type',
      icon: Icons.work_outline,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What type of job are you posting?',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              _buildJobTypeChip('PRO', 'Professional', Icons.business_center, formState),
              _buildJobTypeChip('LOC', 'Local Job', Icons.location_city, formState),
              _buildJobTypeChip('INT', 'Internship', Icons.school, formState),
              _buildJobTypeChip('VOL', 'Volunteer', Icons.volunteer_activism, formState),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildJobTypeChip(String type, String label, IconData icon, JobFormState formState) {
    final isSelected = formState.job.jobType == type;
    
    return GestureDetector(
      onTap: () => ref.read(jobFormNotifierProvider.notifier).updateJobType(type),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3E8728).withOpacity(0.1) : Colors.grey[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFF3E8728) : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? const Color(0xFF3E8728) : Colors.grey[600],
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: isSelected ? const Color(0xFF3E8728) : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Clean basic info section
  Widget _buildBasicInfoSection(JobFormState formState) {
    return _buildSection(
      title: 'Basic Information',
      icon: Icons.info_outline,
      child: Column(
        children: [
          _buildTextField(
            label: 'Job Title',
            hint: 'e.g., Senior Flutter Developer',
            value: formState.job.title,
            error: formState.errors['title'],
            onChanged: (value) => ref.read(jobFormNotifierProvider.notifier)
                .updateJobData(title: value),
          ),
          const SizedBox(height: 16),
          _buildDropdown(
            label: 'Category',
            value: formState.job.category.isEmpty ? null : formState.job.category,
            items: const [
              DropdownMenuItem(value: 'IT', child: Text('Technology')),
              DropdownMenuItem(value: 'HEALTH', child: Text('Healthcare')),
              DropdownMenuItem(value: 'FINANCE', child: Text('Finance')),
              DropdownMenuItem(value: 'CONSTRUCTION', child: Text('Construction')),
              DropdownMenuItem(value: 'EDUCATION', child: Text('Education')),
              DropdownMenuItem(value: 'DESIGN', child: Text('Design')),
              DropdownMenuItem(value: 'OTHER', child: Text('Other')),
            ],
            onChanged: (value) => ref.read(jobFormNotifierProvider.notifier)
                .updateJobData(category: value),
            error: formState.errors['category'],
          ),
          const SizedBox(height: 16),
          _buildDropdown(
            label: 'Job Nature',
            value: formState.job.job_nature?.isEmpty == true ? null : formState.job.job_nature,
            items: const [
              DropdownMenuItem(value: 'Full time', child: Text('Full-time')),
              DropdownMenuItem(value: 'Part time', child: Text('Part-time')),
              DropdownMenuItem(value: 'Contract', child: Text('Contract')),
              DropdownMenuItem(value: 'Freelance', child: Text('Freelance')),
            ],
            onChanged: (value) => ref.read(jobFormNotifierProvider.notifier)
                .updateJobData(jobNature: value),
          ),
        ],
      ),
    );
  }

  // Clean location section
  Widget _buildLocationSection(JobFormState formState) {
    return _buildSection(
      title: 'Location',
      icon: Icons.location_on,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  label: 'City',
                  hint: 'e.g., Douala',
                  value: formState.job.city ?? '',
                  error: formState.errors['location'],
                  onChanged: (value) => ref.read(jobFormNotifierProvider.notifier)
                      .updateJobData(city: value),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildTextField(
                  label: 'District/Area',
                  hint: 'e.g., Bonaberi',
                  value: formState.job.district ?? '',
                  onChanged: (value) => ref.read(jobFormNotifierProvider.notifier)
                      .updateJobData(district: value),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTextField(
            label: 'Specific Location',
            hint: 'e.g., Near University of Buea',
            value: formState.job.location ?? '',
            onChanged: (value) => ref.read(jobFormNotifierProvider.notifier)
                .updateJobData(location: value),
          ),
        ],
      ),
    );
  }

  // Clean job details section
  Widget _buildJobDetailsSection(JobFormState formState) {
    return _buildSection(
      title: 'Job Details',
      icon: Icons.description,
      child: Column(
        children: [
          _buildTextField(
            label: 'Job Description',
            hint: 'Describe what this job involves...',
            value: formState.job.description,
            error: formState.errors['description'],
            maxLines: 4,
            onChanged: (value) => ref.read(jobFormNotifierProvider.notifier)
                .updateJobData(description: value),
          ),
          const SizedBox(height: 16),
          _buildTextField(
            label: 'Roles & Responsibilities',
            hint: 'What will the person be doing?',
            value: formState.job.rolesDescription ?? '',
            maxLines: 3,
            onChanged: (value) => ref.read(jobFormNotifierProvider.notifier)
                .updateJobData(rolesDescription: value),
          ),
          const SizedBox(height: 16),
          _buildDateField(
            label: 'Application Deadline',
            value: formState.job.dueDate ?? '',
            error: formState.errors['dueDate'],
            onChanged: (date) => ref.read(jobFormNotifierProvider.notifier)
                .updateJobData(dueDate: date),
          ),
        ],
      ),
    );
  }

  // Clean compensation section
  Widget _buildCompensationSection(JobFormState formState) {
    final isPaidJob = formState.job.jobType == 'PRO' || formState.job.jobType == 'LOC';
    
    return _buildSection(
      title: 'Compensation',
      icon: Icons.payments,
      child: isPaidJob ? _buildSalaryFields(formState) : _buildCompensationToggle(formState),
    );
  }

  Widget _buildSalaryFields(JobFormState formState) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: _buildTextField(
            label: 'Amount',
            hint: '50000',
            value: formState.job.typeSpecific['salary']?.toString() ?? '',
            prefixText: 'FCFA ',
            keyboardType: TextInputType.number,
            error: formState.errors['salary'],
            onChanged: (value) {
              final amount = int.tryParse(value);
              ref.read(jobFormNotifierProvider.notifier)
                  .updateTypeSpecificField('salary', amount);
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildDropdown(
            label: 'Period',
            value: formState.job.typeSpecific['salary_period']?.toString(),
            items: const [
              DropdownMenuItem(value: 'd', child: Text('Daily')),
              DropdownMenuItem(value: 'w', child: Text('Weekly')),
              DropdownMenuItem(value: 'm', child: Text('Monthly')),
            ],
            onChanged: (value) => ref.read(jobFormNotifierProvider.notifier)
                .updateTypeSpecificField('salary_period', value),
          ),
        ),
      ],
    );
  }

  Widget _buildCompensationToggle(JobFormState formState) {
    return Column(
      children: [
        SwitchListTile(
          title: const Text('Includes Other Benefits'),
          subtitle: const Text('Transport, meals, certificates, etc.'),
          value: formState.job.typeSpecific['compensation_toggle'] ?? false,
          onChanged: (value) => ref.read(jobFormNotifierProvider.notifier)
              .updateTypeSpecificField('compensation_toggle', value),
        ),
        if (formState.job.typeSpecific['compensation_toggle'] == true) ...[
          const SizedBox(height: 12),
          _buildTextField(
            label: 'Benefit Details',
            hint: 'e.g., Transport allowance + lunch + certificate',
            value: formState.job.typeSpecific['bonus_supplementary']?['details'] ?? '',
            maxLines: 2,
            onChanged: (value) => ref.read(jobFormNotifierProvider.notifier)
                .updateTypeSpecificField('bonus_supplementary', {'details': value}),
          ),
        ],
      ],
    );
  }

  // Clean skills section
  Widget _buildSkillsSection(JobFormState formState) {
    return _buildSection(
      title: 'Required Skills',
      icon: Icons.psychology,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (formState.errors['requiredSkills'] != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                formState.errors['requiredSkills']!,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
          _buildSkillChips(formState.job.requiredSkills, isRequired: true),
          const SizedBox(height: 12),
          _buildSkillInput(),
          const SizedBox(height: 16),
          Text(
            'Nice to Have Skills (Optional)',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          _buildSkillChips(formState.job.optionalSkills, isRequired: false),
        ],
      ),
    );
  }

  Widget _buildSkillChips(List<String> skills, {required bool isRequired}) {
    if (skills.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(
          isRequired ? 'No required skills added yet' : 'No optional skills added yet',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[500],
            fontStyle: FontStyle.italic,
          ),
        ),
      );
    }
    
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: skills.map((skill) => Chip(
        label: Text(
          skill,
          style: const TextStyle(fontSize: 12),
        ),
        deleteIcon: const Icon(Icons.close, size: 16),
        onDeleted: () {
          if (isRequired) {
            ref.read(jobFormNotifierProvider.notifier).removeRequiredSkill(skill);
          } else {
            ref.read(jobFormNotifierProvider.notifier).removeOptionalSkill(skill);
          }
        },
        backgroundColor: isRequired ? Colors.red[50] : Colors.green[50],
        side: BorderSide(
          color: isRequired ? Colors.red[200]! : Colors.green[200]!,
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      )).toList(),
    );
  }

  Widget _buildSkillInput() {
    return TextFormField(
      controller: _skillController,
      focusNode: _skillFocus,
      decoration: InputDecoration(
        hintText: 'Type a skill and press Done',
        suffixIcon: IconButton(
          icon: const Icon(Icons.add, size: 20),
          onPressed: _addSkill,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        isDense: true,
      ),
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) => _addSkill(),
    );
  }

  // Clean requirements section
  Widget _buildRequirementsSection(JobFormState formState) {
    return _buildSection(
      title: 'Other Requirements',
      icon: Icons.checklist,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Additional requirements or qualifications',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 12),
          if (formState.job.requirements.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: formState.job.requirements.map((req) => Chip(
                label: Text(req, style: const TextStyle(fontSize: 12)),
                deleteIcon: const Icon(Icons.close, size: 16),
                onDeleted: () => ref.read(jobFormNotifierProvider.notifier)
                    .removeRequirement(req),
                backgroundColor: Colors.blue[50],
                side: BorderSide(color: Colors.blue[200]!),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              )).toList(),
            ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _requirementController,
            focusNode: _requirementFocus,
            decoration: InputDecoration(
              hintText: 'Type a requirement and press Done',
              suffixIcon: IconButton(
                icon: const Icon(Icons.add, size: 20),
                onPressed: _addRequirement,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              isDense: true,
            ),
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _addRequirement(),
          ),
        ],
      ),
    );
  }

  // Clean working days section
  Widget _buildWorkingDaysSection(JobFormState formState) {
    const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    
    return _buildSection(
      title: 'Working Days',
      icon: Icons.calendar_today,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select the working days for this position',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: days.map((day) {
              final isSelected = formState.job.workingDays.contains(day);
              return FilterChip(
                label: Text(
                  day,
                  style: const TextStyle(fontSize: 12),
                ),
                selected: isSelected,
                onSelected: (selected) {
                  final newDays = List<String>.from(formState.job.workingDays);
                  if (selected) {
                    newDays.add(day);
                  } else {
                    newDays.remove(day);
                  }
                  ref.read(jobFormNotifierProvider.notifier)
                      .updateJobData(workingDays: newDays);
                },
                selectedColor: const Color(0xFF3E8728).withOpacity(0.2),
                checkmarkColor: const Color(0xFF3E8728),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Helper methods
  void _addSkill() {
    final skill = _skillController.text.trim();
    if (skill.isNotEmpty) {
      ref.read(jobFormNotifierProvider.notifier).addRequiredSkill(skill);
      _skillController.clear();
    }
  }

  void _addRequirement() {
    final requirement = _requirementController.text.trim();
    if (requirement.isNotEmpty) {
      ref.read(jobFormNotifierProvider.notifier).addRequirement(requirement);
      _requirementController.clear();
    }
  }

  // Clean helper widgets
  Widget _buildSection({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFF3E8728).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  icon,
                  size: 16,
                  color: const Color(0xFF3E8728),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    String? hint,
    required String value,
    String? error,
    String? prefixText,
    int maxLines = 1,
    TextInputType? keyboardType,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          initialValue: value,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            prefixText: prefixText,
            errorText: error,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            isDense: true,
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<DropdownMenuItem<String>> items,
    required Function(String?) onChanged,
    String? error,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        errorText: error,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        isDense: true,
      ),
      items: items,
      onChanged: onChanged,
    );
  }

  Widget _buildDateField({
    required String label,
    required String value,
    String? error,
    required Function(String) onChanged,
  }) {
    return TextFormField(
      readOnly: true,
      controller: TextEditingController(text: value),
      decoration: InputDecoration(
        labelText: label,
        errorText: error,
        suffixIcon: const Icon(Icons.calendar_today, size: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        isDense: true,
      ),
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime.now().add(const Duration(days: 7)),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (date != null) {
          onChanged(DateFormat('yyyy-MM-dd').format(date));
        }
      },
    );
  }

  Widget _buildSubmitButton(JobFormState formState, bool isEditing) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: formState.isLoading ? null : _submitForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3E8728),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 2,
        ),
        child: formState.isLoading
            ? const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Submitting...',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            : Text(
                isEditing ? 'Update Job' : 'Post Job',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  Future<void> _submitForm() async {
    final success = await ref.read(jobFormNotifierProvider.notifier).submitJob();
    
    if (success && mounted) {
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.existingJob != null ? 'Job updated successfully!' : 'Job posted successfully!',
          ),
          backgroundColor: const Color(0xFF3E8728),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    } else if (mounted) {
      final formState = ref.read(jobFormNotifierProvider);
      final errorMessage = formState.errors['submit'] ?? 'Please check all required fields';
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }
  }

  double _calculateProgress(PostJob job) {
    int completed = 0;
    const int totalSections = 7;
    
    // Job Type
    if (job.jobType.isNotEmpty) completed++;
    
    // Basic Info
    if (job.title.isNotEmpty && job.category.isNotEmpty) completed++;
    
    // Location
    if ((job.city?.isNotEmpty == true) || (job.location?.isNotEmpty == true)) completed++;
    
    // Job Details
    if (job.description.isNotEmpty && job.dueDate?.isNotEmpty == true) completed++;
    
    // Compensation
    final isPaidJob = job.jobType == 'PRO' || job.jobType == 'LOC';
    if (isPaidJob) {
      if (job.typeSpecific['salary'] != null) completed++;
    } else {
      completed++; // Non-paid jobs auto-complete this section
    }
    
    // Skills
    if (job.requiredSkills.isNotEmpty) completed++;
    
    // Working Days
    if (job.workingDays.isNotEmpty) completed++;
    
    return completed / totalSections;
  }

  @override
  void dispose() {
    _skillController.dispose();
    _requirementController.dispose();
    _skillFocus.dispose();
    _requirementFocus.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}