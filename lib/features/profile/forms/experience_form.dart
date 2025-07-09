// lib/features/profile/forms/experience_form.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:workdey_frontend/core/models/profile/experience/experience_model.dart';
import 'package:workdey_frontend/core/providers/profile_provider.dart';

class EnhancedExperienceForm extends ConsumerStatefulWidget {
  final Experience? initialData;
  final bool isEdit;

  const EnhancedExperienceForm({
    super.key,
    this.initialData,
    this.isEdit = false,
  });

  @override
  ConsumerState<EnhancedExperienceForm> createState() => _EnhancedExperienceFormState();
}

class _EnhancedExperienceFormState extends ConsumerState<EnhancedExperienceForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _companyController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  String _selectedJobType = 'full-time';
  String _selectedCategory = 'IT';
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isCurrent = false;
  bool _isLoading = false;

  final List<String> _jobTypes = [
    'full-time',
    'part-time',
    'contract',
    'freelance',
    'internship',
    'volunteer',
  ];

  final List<String> _categories = [
    'IT',
    'HEALTH',
    'FINANCE',
    'CONSTRUCTION',
    'EDUCATION',
    'DESIGN',
    'OTHER',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _populateFields(widget.initialData!);
    }
  }

  void _populateFields(Experience experience) {
    _titleController.text = experience.title;
    _companyController.text = experience.company ?? '';
    _descriptionController.text = experience.description ?? '';
    _selectedJobType = experience.jobType ?? 'full-time';
    _selectedCategory = experience.category ?? 'IT';
    _startDate = experience.startDate;
    _endDate = experience.endDate;
    _isCurrent = experience.isCurrent ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Edit Experience' : 'Add Experience'),
        backgroundColor: const Color(0xFF3E8728),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          if (widget.isEdit && widget.initialData != null)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: _showDeleteDialog,
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildForm(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Job Title
            _buildSectionTitle('Position Details'),
            _buildTextField(
              controller: _titleController,
              label: 'Job Title',
              hint: 'e.g. Senior Software Developer',
              icon: Icons.work_outline,
              validator: (value) => value?.isEmpty ?? true ? 'Job title is required' : null,
            ),
            
            const SizedBox(height: 16),
            
            // Company
            _buildTextField(
              controller: _companyController,
              label: 'Company',
              hint: 'e.g. Google, Microsoft',
              icon: Icons.business_outlined,
            ),
            
            const SizedBox(height: 16),
            
            // Job Type Dropdown
            _buildDropdown(
              value: _selectedJobType,
              label: 'Employment Type',
              icon: Icons.schedule_outlined,
              items: _jobTypes.map((type) => DropdownMenuItem(
                value: type,
                child: Text(_formatJobType(type)),
              )).toList(),
              onChanged: (value) => setState(() => _selectedJobType = value!),
            ),
            
            const SizedBox(height: 16),
            
            // Category Dropdown
            _buildDropdown(
              value: _selectedCategory,
              label: 'Industry',
              icon: Icons.category_outlined,
              items: _categories.map((category) => DropdownMenuItem(
                value: category,
                child: Text(_formatCategory(category)),
              )).toList(),
              onChanged: (value) => setState(() => _selectedCategory = value!),
            ),
            
            const SizedBox(height: 24),
            
            // Duration Section
            _buildSectionTitle('Duration'),
            
            // Current Position Toggle
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.work_history, color: Colors.grey[600], size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'I currently work here',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  Switch.adaptive(
                    value: _isCurrent,
                    onChanged: (value) {
                      setState(() {
                        _isCurrent = value;
                        if (value) _endDate = null;
                      });
                    },
                    activeColor: const Color(0xFF3E8728),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Date Pickers
            Row(
              children: [
                Expanded(
                  child: _buildDatePicker(
                    label: 'Start Date',
                    date: _startDate,
                    onTap: () => _selectStartDate(),
                    isRequired: true,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDatePicker(
                    label: 'End Date',
                    date: _endDate,
                    onTap: _isCurrent ? null : () => _selectEndDate(),
                    isRequired: !_isCurrent,
                    isDisabled: _isCurrent,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Description
            _buildSectionTitle('Description (Optional)'),
            _buildTextField(
              controller: _descriptionController,
              label: 'Job Description',
              hint: 'Describe your responsibilities and achievements...',
              icon: Icons.description_outlined,
              maxLines: 4,
            ),
            
            const SizedBox(height: 100), // Space for bottom bar
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Color(0xFF3E8728)),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Color(0xFF3E8728)),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3E8728),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 0,
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(widget.isEdit ? 'Update Experience' : 'Add Experience'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    IconData? icon,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: icon != null ? Icon(icon, color: Colors.grey[600]) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF3E8728), width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }

  Widget _buildDropdown<T>({
    required T value,
    required String label,
    required IconData icon,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey[600]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF3E8728), width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }

  Widget _buildDatePicker({
    required String label,
    required DateTime? date,
    required VoidCallback? onTap,
    bool isRequired = false,
    bool isDisabled = false,
  }) {
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDisabled ? Colors.grey[100] : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDisabled ? Colors.grey[200]! : Colors.grey[300]!,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 16,
                  color: isDisabled ? Colors.grey[400] : Colors.grey[600],
                ),
                const SizedBox(width: 8),
                Text(
                  label + (isRequired ? ' *' : ''),
                  style: TextStyle(
                    fontSize: 12,
                    color: isDisabled ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              date != null
                  ? DateFormat('MMM yyyy').format(date)
                  : isDisabled
                      ? 'Present'
                      : 'Select date',
              style: TextStyle(
                fontSize: 16,
                color: isDisabled
                    ? Colors.grey[500]
                    : date != null
                        ? Colors.black87
                        : Colors.grey[500],
                fontWeight: date != null ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper methods
  String _formatJobType(String type) {
    switch (type) {
      case 'full-time':
        return 'Full-time';
      case 'part-time':
        return 'Part-time';
      case 'contract':
        return 'Contract';
      case 'freelance':
        return 'Freelance';
      case 'internship':
        return 'Internship';
      case 'volunteer':
        return 'Volunteer';
      default:
        return type;
    }
  }

  String _formatCategory(String category) {
    switch (category) {
      case 'IT':
        return 'Information Technology';
      case 'HEALTH':
        return 'Healthcare';
      case 'FINANCE':
        return 'Finance';
      case 'CONSTRUCTION':
        return 'Construction';
      case 'EDUCATION':
        return 'Education';
      case 'DESIGN':
        return 'Design';
      case 'OTHER':
        return 'Other';
      default:
        return category;
    }
  }

  // Date selection methods
  Future<void> _selectStartDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      setState(() => _startDate = date);
    }
  }

  Future<void> _selectEndDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _endDate ?? DateTime.now(),
      firstDate: _startDate ?? DateTime(1990),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      setState(() => _endDate = date);
    }
  }

  // Form submission
  Future<void> _submitForm() async {
  if (!_formKey.currentState!.validate()) return;
  if (_startDate == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please select a start date')),
    );
    return;
  }

  setState(() => _isLoading = true);

  try {
    final experienceData = {
      'title': _titleController.text.trim(),
      'company': _companyController.text.trim(),
      'description': _descriptionController.text.trim(),
      'job_type': _selectedJobType,
      'category': _selectedCategory,
      'start_date': _startDate!.toIso8601String().split('T')[0], // YYYY-MM-DD format
      'end_date': _isCurrent ? null : _endDate?.toIso8601String().split('T')[0],
      'is_current': _isCurrent,
    };

    if (widget.isEdit && widget.initialData != null) {
      // Update existing experience
      await ref.read(experienceProvider.notifier).updateExperience(
        widget.initialData!.id,
        experienceData,
      );
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Experience updated successfully'),
            backgroundColor: Color(0xFF3E8728),
          ),
        );
      }
    } else {
      // Add new experience
      await ref.read(experienceProvider.notifier).addExperience(experienceData);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Experience added successfully'),
            backgroundColor: Color(0xFF3E8728),
          ),
        );
      }
    }

    // Refresh the main profile
    ref.read(profileProvider.notifier).refresh();
    
    if (mounted) {
      Navigator.pop(context, true);
    }
  } catch (e) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('❌ Error: ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  } finally {
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }
}

// Experience Delete Dialog
Future<void> _showDeleteDialog() async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Delete Experience'),
      content: Text('Are you sure you want to delete "${widget.initialData?.title}"?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          style: TextButton.styleFrom(foregroundColor: Colors.red),
          child: const Text('Delete'),
        ),
      ],
    ),
  );

  if (confirmed == true && widget.initialData?.id != null) {
    setState(() => _isLoading = true);
    try {
      await ref.read(experienceProvider.notifier).deleteExperience(widget.initialData!.id);
      ref.read(profileProvider.notifier).refresh();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Experience deleted successfully'),
            backgroundColor: Color(0xFF3E8728),
          ),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Error deleting experience: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}

  @override
  void dispose() {
    _titleController.dispose();
    _companyController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}