import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/getworkers/get_workers_model.dart';
import 'package:workdey_frontend/core/providers/post_worker_provider.dart';

// ============================================================================
// CLEAN WORKER FORM - No more primitive branching or manual controllers
// ============================================================================

class PostWorkerForm extends ConsumerStatefulWidget {
  final Worker? existingWorker; // Clean - just pass the worker if editing, null if creating
  
  const PostWorkerForm({
    super.key,
    this.existingWorker,
  });

  @override
  ConsumerState<PostWorkerForm> createState() => _PostWorkerFormState();
}

class _PostWorkerFormState extends ConsumerState<PostWorkerForm> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();
  
  // Clean controller management - only what we actually need
  final _skillController = TextEditingController();
  
  // Focus nodes for keyboard handling
  final _skillFocus = FocusNode();
  
  @override
  void initState() {
    super.initState();
    _setupForm();
    _setupKeyboardHandling();
  }

  // Clean initialization - no more primitive branching
  void _setupForm() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = ref.read(workerFormNotifierProvider.notifier);
      
      if (widget.existingWorker != null) {
        // Clean edit initialization - no extensions or manual conversions
        notifier.initializeForEdit(widget.existingWorker!);
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
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(workerFormNotifierProvider);
    final isEditing = widget.existingWorker != null;
    
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
              _buildBasicInfoSection(formState),
              const SizedBox(height: 20),
              _buildLocationSection(formState),
              const SizedBox(height: 20),
              _buildProfessionalSection(formState),
              const SizedBox(height: 20),
              _buildSkillsSection(formState),
              const SizedBox(height: 20),
              _buildAdditionalSection(formState),
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
        isEditing ? 'Edit Worker Profile' : 'Create Worker Profile',
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
  Widget _buildProgressIndicator(WorkerFormState formState) {
    final progress = _calculateProgress(formState.worker);
    
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

  // Clean basic info section
  Widget _buildBasicInfoSection(WorkerFormState formState) {
    return _buildSection(
      title: 'Basic Information',
      icon: Icons.info_outline,
      child: Column(
        children: [
          _buildTextField(
            label: 'Service Title',
            hint: 'e.g., Professional Electrician Services',
            value: formState.worker.title,
            error: formState.errors['title'],
            onChanged: (value) => ref.read(workerFormNotifierProvider.notifier)
                .updateWorkerData(title: value),
          ),
          const SizedBox(height: 16),
          _buildDropdown(
            label: 'Category',
            value: formState.worker.category.isEmpty ? null : formState.worker.category,
            items: const [
              DropdownMenuItem(value: 'CONSTRUCTION', child: Text('Construction')),
              DropdownMenuItem(value: 'IT', child: Text('Technology')),
              DropdownMenuItem(value: 'HEALTH', child: Text('Healthcare')),
              DropdownMenuItem(value: 'DESIGN', child: Text('Design')),
              DropdownMenuItem(value: 'BEAUTY', child: Text('Beauty')),
              DropdownMenuItem(value: 'EDUCATION', child: Text('Education')),
              DropdownMenuItem(value: 'OTHER', child: Text('Other')),
            ],
            onChanged: (value) => ref.read(workerFormNotifierProvider.notifier)
                .updateWorkerData(category: value),
            error: formState.errors['category'],
          ),
        ],
      ),
    );
  }

  // Clean location section
  Widget _buildLocationSection(WorkerFormState formState) {
    return _buildSection(
      title: 'Location',
      icon: Icons.location_on,
      child: _buildTextField(
        label: 'Service Location',
        hint: 'e.g., Douala, Cameroon',
        value: formState.worker.location,
        error: formState.errors['location'],
        onChanged: (value) => ref.read(workerFormNotifierProvider.notifier)
            .updateWorkerData(location: value),
      ),
    );
  }

  // Clean professional section
  Widget _buildProfessionalSection(WorkerFormState formState) {
    return _buildSection(
      title: 'Professional Details',
      icon: Icons.work,
      child: Column(
        children: [
          _buildTextField(
            label: 'Bio/Description',
            hint: 'Describe your services and experience...',
            value: formState.worker.bio ?? '',
            error: formState.errors['bio'],
            maxLines: 4,
            onChanged: (value) => ref.read(workerFormNotifierProvider.notifier)
                .updateWorkerData(bio: value),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  label: 'Years of Experience',
                  hint: '0',
                  value: formState.worker.experienceYears?.toString() ?? '0',
                  error: formState.errors['experienceYears'],
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    final years = int.tryParse(value) ?? 0;
                    ref.read(workerFormNotifierProvider.notifier)
                        .updateWorkerData(experienceYears: years);
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDropdown(
                  label: 'Availability',
                  value: formState.worker.availability,
                  items: const [
                    DropdownMenuItem(value: 'FT', child: Text('Full-time')),
                    DropdownMenuItem(value: 'PT', child: Text('Part-time')),
                    DropdownMenuItem(value: 'CN', child: Text('Contract')),
                    DropdownMenuItem(value: 'FL', child: Text('Freelance')),
                  ],
                  onChanged: (value) => ref.read(workerFormNotifierProvider.notifier)
                      .updateWorkerData(availability: value),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Clean skills section
  Widget _buildSkillsSection(WorkerFormState formState) {
    return _buildSection(
      title: 'Skills & Expertise',
      icon: Icons.psychology,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (formState.errors['skills'] != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                formState.errors['skills']!,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
          _buildSkillChips(formState.worker.skills),
          const SizedBox(height: 12),
          _buildSkillInput(),
        ],
      ),
    );
  }

  Widget _buildSkillChips(List<String> skills) {
    if (skills.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(
          'No skills added yet',
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
          ref.read(workerFormNotifierProvider.notifier).removeSkill(skill);
        },
        backgroundColor: Colors.blue[50],
        side: BorderSide(
          color: Colors.blue[200]!,
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

  // Clean additional section
  Widget _buildAdditionalSection(WorkerFormState formState) {
    return _buildSection(
      title: 'Additional Information',
      icon: Icons.link,
      child: _buildTextField(
        label: 'Portfolio Link',
        hint: 'https://myportfolio.com (optional)',
        value: formState.worker.portfolioLink ?? '',
        onChanged: (value) => ref.read(workerFormNotifierProvider.notifier)
            .updateWorkerData(portfolioLink: value),
      ),
    );
  }

  // Helper methods
  void _addSkill() {
    final skill = _skillController.text.trim();
    if (skill.isNotEmpty) {
      ref.read(workerFormNotifierProvider.notifier).addSkill(skill);
      _skillController.clear();
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

  Widget _buildSubmitButton(WorkerFormState formState, bool isEditing) {
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
                isEditing ? 'Update Profile' : 'Create Profile',
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
    final success = await ref.read(workerFormNotifierProvider.notifier).submitWorker();
    
    if (success && mounted) {
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.existingWorker != null 
                ? 'Worker profile updated successfully!' 
                : 'Worker profile created successfully!',
          ),
          backgroundColor: const Color(0xFF3E8728),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    } else if (mounted) {
      final formState = ref.read(workerFormNotifierProvider);
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

  double _calculateProgress(worker) {
    int completed = 0;
    const int totalSections = 5;
    
    // Basic Info
    if (worker.title.isNotEmpty && worker.category.isNotEmpty) completed++;
    
    // Location
    if (worker.location.isNotEmpty) completed++;
    
    // Professional Details
    if ((worker.bio?.isNotEmpty == true) && (worker.experienceYears ?? 0) >= 0) completed++;
    
    // Skills
    if (worker.skills.isNotEmpty) completed++;
    
    // Additional (optional, auto-complete)
    completed++;
    
    return completed / totalSections;
  }

  @override
  void dispose() {
    _skillController.dispose();
    _skillFocus.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}