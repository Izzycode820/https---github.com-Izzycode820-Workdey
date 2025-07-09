// lib/features/profile/forms/education_form.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:workdey_frontend/core/models/profile/education/education_model.dart';
import 'package:workdey_frontend/core/providers/profile_provider.dart';

class EnhancedEducationForm extends ConsumerStatefulWidget {
  final Education? initialData;
  final bool isEdit;

  const EnhancedEducationForm({
    super.key,
    this.initialData,
    this.isEdit = false,
  });

  @override
  ConsumerState<EnhancedEducationForm> createState() => _EnhancedEducationFormState();
}

class _EnhancedEducationFormState extends ConsumerState<EnhancedEducationForm> {
  final _formKey = GlobalKey<FormState>();
  final _institutionController = TextEditingController();
  final _fieldController = TextEditingController();
  
  String _selectedLevel = 'secondary';
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isCurrent = false;
  bool _isLoading = false;

  final List<String> _educationLevels = [
    'secondary',
    'high',
    'undergraduate',
    'graduate',
    'other',
  ];

  final List<String> _commonInstitutions = [
    // Cameroon Universities
    'University of Buea', 'University of Yaoundé I', 'University of Yaoundé II',
    'University of Douala', 'University of Dschang', 'University of Ngaoundéré',
    'University of Maroua', 'University of Bamenda',
    
    // Technical Institutes
    'National Advanced School of Engineering', 'Higher Technical Teacher Training College',
    'Advanced Teacher Training College', 'National Polytechnic',
    
    // International
    'Harvard University', 'MIT', 'Stanford University', 'Oxford University',
    'Cambridge University', 'Sorbonne University',
  ];

  final Map<String, List<String>> _fieldsByLevel = {
    'secondary': [
      'General Education', 'Science', 'Arts', 'Commercial', 'Technical',
    ],
    'high': [
      'Science', 'Arts', 'Commercial', 'Technical', 'General Studies',
    ],
    'undergraduate': [
      'Computer Science', 'Engineering', 'Medicine', 'Law', 'Business Administration',
      'Economics', 'Psychology', 'Education', 'Agriculture', 'Architecture',
      'Fine Arts', 'Mass Communication', 'International Relations',
    ],
    'graduate': [
      'MBA', 'MSc Computer Science', 'MSc Engineering', 'MA Education',
      'MSc Economics', 'LLM', 'PhD', 'Master of Public Health',
    ],
    'other': [
      'Professional Certificate', 'Trade Certificate', 'Diploma',
      'Short Course', 'Online Course', 'Bootcamp',
    ],
  };

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _populateFields(widget.initialData!);
    }
  }

  void _populateFields(Education education) {
    _institutionController.text = education.institution;
    _fieldController.text = education.fieldOfStudy ?? '';
    _selectedLevel = education.level;
    _startDate = education.startDate;
    _endDate = education.endDate;
    _isCurrent = education.isCurrent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Edit Education' : 'Add Education'),
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
    final filteredInstitutions = _commonInstitutions
        .where((inst) => inst.toLowerCase().contains(_institutionController.text.toLowerCase()))
        .take(5)
        .toList();

    final fieldsForLevel = _fieldsByLevel[_selectedLevel] ?? [];
    final filteredFields = fieldsForLevel
        .where((field) => field.toLowerCase().contains(_fieldController.text.toLowerCase()))
        .take(5)
        .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Institution Section
            _buildSectionTitle('Institution Details'),
            
            // Institution Input with Autocomplete
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _institutionController,
                  validator: (value) => value?.isEmpty ?? true ? 'Institution name is required' : null,
                  onChanged: (value) => setState(() {}),
                  decoration: InputDecoration(
                    labelText: 'Institution Name',
                    hintText: 'e.g. University of Buea',
                    prefixIcon: Icon(Icons.school_outlined, color: Colors.grey[600]),
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
                ),
                
                // Institution Suggestions
                if (_institutionController.text.isNotEmpty && filteredInstitutions.isNotEmpty)
                  _buildSuggestions(filteredInstitutions, (institution) {
                    _institutionController.text = institution;
                    setState(() {});
                  }),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Education Level Dropdown
            DropdownButtonFormField<String>(
              value: _selectedLevel,
              items: _educationLevels.map((level) => DropdownMenuItem(
                value: level,
                child: Text(_formatEducationLevel(level)),
              )).toList(),
              onChanged: (value) => setState(() {
                _selectedLevel = value!;
                _fieldController.clear(); // Clear field when level changes
              }),
              decoration: InputDecoration(
                labelText: 'Education Level',
                prefixIcon: Icon(Icons.school, color: Colors.grey[600]),
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
            ),
            
            const SizedBox(height: 16),
            
            // Field of Study with Autocomplete
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _fieldController,
                  onChanged: (value) => setState(() {}),
                  decoration: InputDecoration(
                    labelText: 'Field of Study (Optional)',
                    hintText: 'e.g. Computer Science, Medicine',
                    prefixIcon: Icon(Icons.menu_book_outlined, color: Colors.grey[600]),
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
                ),
                
                // Field Suggestions
                if (_fieldController.text.isNotEmpty && filteredFields.isNotEmpty)
                  _buildSuggestions(filteredFields, (field) {
                    _fieldController.text = field;
                    setState(() {});
                  }),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Duration Section
            _buildSectionTitle('Duration'),
            
            // Current Study Toggle
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.school_outlined, color: Colors.grey[600], size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'I currently study here',
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
            
            // Tips Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lightbulb_outline, size: 16, color: Colors.blue[600]),
                      const SizedBox(width: 8),
                      Text(
                        'Education Tips',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '• Include relevant certifications and courses\n'
                    '• Add technical training and bootcamps\n'
                    '• Mention honors, awards, or achievements\n'
                    '• Include online courses from recognized platforms',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue[600],
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 100), // Space for bottom bar
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestions(List<String> suggestions, Function(String) onTap) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Suggestions:',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          ...suggestions.map((suggestion) {
            return GestureDetector(
              onTap: () => onTap(suggestion),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                margin: const EdgeInsets.only(bottom: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  suggestion,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF3E8728),
                  ),
                ),
              ),
            );
          }).toList(),
        ],
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
                    : Text(widget.isEdit ? 'Update Education' : 'Add Education'),
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

  // Helper methods
  String _formatEducationLevel(String level) {
    switch (level) {
      case 'secondary':
        return 'Secondary School';
      case 'high':
        return 'High School';
      case 'undergraduate':
        return 'Undergraduate';
      case 'graduate':
        return 'Graduate';
      case 'other':
        return 'Other';
      default:
        return level;
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
    final educationData = {
      'institution': _institutionController.text.trim(),
      'field_of_study': _fieldController.text.trim(),
      'level': _selectedLevel,
      'start_date': _startDate!.toIso8601String().split('T')[0],
      'end_date': _isCurrent ? null : _endDate?.toIso8601String().split('T')[0],
      'is_current': _isCurrent,
    };

    if (widget.isEdit && widget.initialData != null) {
      // Update existing education
      await ref.read(educationProvider.notifier).updateEducation(
        widget.initialData!.id,
        educationData,
      );
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Education updated successfully'),
            backgroundColor: Color(0xFF3E8728),
          ),
        );
      }
    } else {
      // Add new education
      await ref.read(educationProvider.notifier).addEducation(educationData);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Education added successfully'),
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

// Education Delete Dialog
Future<void> _showDeleteDialog() async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Delete Education'),
      content: Text('Are you sure you want to delete "${widget.initialData?.institution}"?'),
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
      await ref.read(educationProvider.notifier).deleteEducation(widget.initialData!.id);
      ref.read(profileProvider.notifier).refresh();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Education deleted successfully'),
            backgroundColor: Color(0xFF3E8728),
          ),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Error deleting education: ${e.toString()}'),
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
    _institutionController.dispose();
    _fieldController.dispose();
    super.dispose();
  }
}