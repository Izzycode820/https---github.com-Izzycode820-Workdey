import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';
import 'package:workdey_frontend/core/providers/applicantion_provider.dart';

class ApplicationFormScreen extends ConsumerStatefulWidget {
  final Job job;

  const ApplicationFormScreen({super.key, required this.job});

  @override
  ConsumerState<ApplicationFormScreen> createState() => _ApplicationFormScreenState();
}

class _ApplicationFormScreenState extends ConsumerState<ApplicationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();
  final List<String> _selectedSkills = [];
  final List<String> _selectedOptionalSkills = [];
  bool _isSubmitting = false;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Apply for Job',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          _buildJobHeaderCard(),
          Expanded(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSkillsSection(),
                    const SizedBox(height: 20),
                    _buildOptionalSkillsSection(),
                    const SizedBox(height: 20),
                    _buildNotesSection(),
                    const SizedBox(height: 100), // Space for floating button
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _buildSubmitButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildJobHeaderCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!, width: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _getJobTypeColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  _getJobTypeLabel(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getJobTypeColor(),
                  ),
                ),
              ),
              const Spacer(),
              if (widget.job.salaryDisplay != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    widget.job.salaryDisplay!,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.green[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            widget.job.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              if (widget.job.posterName?.isNotEmpty == true) ...[
                Text(
                  widget.job.posterName!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
              ],
              Icon(
                Icons.location_on,
                size: 12,
                color: Colors.grey[500],
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  widget.job.locationDisplayText,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsSection() {
    if (widget.job.requiredSkills?.isEmpty != false) return const SizedBox.shrink();
    
    return _buildSection(
      title: 'Required Skills',
      subtitle: 'Select the skills you have that match this job',
      icon: Icons.star,
      isRequired: true,
      child: _buildSkillsGrid(
        widget.job.requiredSkills!,
        _selectedSkills,
        isRequired: true,
      ),
    );
  }

  Widget _buildOptionalSkillsSection() {
    if (widget.job.optionalSkills?.isEmpty != false) return const SizedBox.shrink();
    
    return _buildSection(
      title: 'Bonus Skills',
      subtitle: 'Additional skills that could strengthen your application',
      icon: Icons.star_border,
      isRequired: false,
      child: _buildSkillsGrid(
        widget.job.optionalSkills!,
        _selectedOptionalSkills,
        isRequired: false,
      ),
    );
  }

  Widget _buildSkillsGrid(List<String> skills, List<String> selectedSkills, {required bool isRequired}) {
    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: skills.map((skill) {
        final isSelected = selectedSkills.contains(skill);
        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                selectedSkills.remove(skill);
              } else {
                selectedSkills.add(skill);
              }
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected 
                  ? (isRequired ? Colors.orange[600] : const Color(0xFF3E8728))
                  : Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected 
                    ? (isRequired ? Colors.orange[600]! : const Color(0xFF3E8728))
                    : Colors.grey[300]!,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isSelected) ...[
                  Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 14,
                  ),
                  const SizedBox(width: 6),
                ],
                Text(
                  skill,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildNotesSection() {
    return _buildSection(
      title: 'Application Notes',
      subtitle: 'Tell the employer why you\'re the right person for this job',
      icon: Icons.note_alt,
      isRequired: false,
      child: TextFormField(
        controller: _notesController,
        maxLines: 5,
        decoration: InputDecoration(
          hintText: 'Share your relevant experience, availability, or any questions about the job...',
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.grey[500],
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF3E8728), width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(12),
        ),
        style: const TextStyle(
          fontSize: 14,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isRequired,
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
                  color: isRequired ? Colors.orange[50] : const Color(0xFF3E8728).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  icon,
                  size: 16,
                  color: isRequired ? Colors.orange[600] : const Color(0xFF3E8728),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (isRequired) ...[
                          const SizedBox(width: 4),
                          Text(
                            '*',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red[600],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
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

  Widget _buildSubmitButton() {
    final canSubmit = _selectedSkills.isNotEmpty && !_isSubmitting;
    
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: canSubmit ? _submitApplication : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: canSubmit ? const Color(0xFF3E8728) : Colors.grey[400],
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: canSubmit ? 2 : 0,
        ),
        child: _isSubmitting
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
                    'Submitting Application...',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.send, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    canSubmit ? 'Submit Application' : 'Select Required Skills',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Future<void> _submitApplication() async {
    if (!_formKey.currentState!.validate() || _selectedSkills.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select at least one required skill'),
          backgroundColor: Colors.red[600],
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final applicationData = {
        'skills_met': _selectedSkills,
        'optional_skills_met': _selectedOptionalSkills,
        'notes': _notesController.text.trim(),
      };

      await ref.read(applicantServiceProvider).applyToJob(
        widget.job.id,
        applicationData,
      );

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Application submitted successfully!'),
            backgroundColor: const Color(0xFF3E8728),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to submit application: ${e.toString()}'),
            backgroundColor: Colors.red[600],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  Color _getJobTypeColor() {
    switch (widget.job.jobType.toUpperCase()) {
      case 'PRO':
        return const Color(0xFF1976D2); // Blue
      case 'LOC':
        return const Color(0xFF388E3C); // Green
      case 'INT':
        return const Color(0xFF7B1FA2); // Purple
      case 'VOL':
        return const Color(0xFFF57C00); // Orange
      default:
        return Colors.grey[600]!;
    }
  }

  String _getJobTypeLabel() {
    switch (widget.job.jobType.toUpperCase()) {
      case 'PRO':
        return 'Professional';
      case 'LOC':
        return 'Local';
      case 'INT':
        return 'Internship';
      case 'VOL':
        return 'Volunteer';
      default:
        return widget.job.jobType;
    }
  }
}