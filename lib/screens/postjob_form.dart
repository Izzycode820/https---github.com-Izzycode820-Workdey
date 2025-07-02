import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:workdey_frontend/core/enums/form_mode.dart';
import 'package:workdey_frontend/core/models/postjob/post_job_model.dart';
import 'package:workdey_frontend/core/providers/post_job_provider.dart';

class PostJobForm extends ConsumerStatefulWidget {
  final FormMode mode;
  final PostJob? initialData;
  const PostJobForm({
    super.key,
    this.mode = FormMode.create,
    this.initialData,
  });

  @override
  ConsumerState<PostJobForm> createState() => _PostJobFormState();
}

class _PostJobFormState extends ConsumerState<PostJobForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _rolesController = TextEditingController();
  final _locationController = TextEditingController();
  final _cityController = TextEditingController();
  final _districtController = TextEditingController();
  final _requirementController = TextEditingController();
  final _requiredSkillController = TextEditingController();
  final _optionalSkillController = TextEditingController();
  final _dueDateController = TextEditingController();
  
  Map<String, String> _errors = {};
  bool _initialized = false;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _setupControllers();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized && widget.mode == FormMode.edit && widget.initialData != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _initializeWithPostJobData(widget.initialData!);
      });
      _initialized = true;
    }
  }

  Future<void> _initializeWithPostJobData(PostJob postjob) async {
    try { 
      final notifier = ref.read(postJobNotifierProvider.notifier);
      
      // Reset to default state first
      notifier.updateJobType(postjob.jobType);

      // Batch updates to minimize rebuilds
      notifier.updateField('title', postjob.title);
      notifier.updateField('location', postjob.location);
      notifier.updateField('city', postjob.city);
      notifier.updateField('district', postjob.district);
      notifier.updateField('job_nature', postjob.job_nature ?? 'Full time');
      notifier.updateField('category', postjob.category);
      notifier.updateField('description', postjob.description);
      notifier.updateField('rolesDescription', postjob.rolesDescription ?? '');
      notifier.updateField('requirements', postjob.requirements);
      notifier.updateField('workingDays', postjob.workingDays);
      notifier.updateField('dueDate', postjob.dueDate?.toString());
      notifier.updateField('requiredSkills', postjob.requiredSkills);
      notifier.updateField('optionalSkills', postjob.optionalSkills);

      // Special handling for salary fields
      if (postjob.jobType == 'PRO' || postjob.jobType == 'LOC') {
        notifier.updateTypeSpecific('salary', postjob.typeSpecific['salary']);
        notifier.updateTypeSpecific('salary_period', 
            postjob.typeSpecific['salary_period'] ?? 'd');
      }

      // Update controllers
      _titleController.text = postjob.title;
      _descriptionController.text = postjob.description;
      _rolesController.text = postjob.rolesDescription ?? '';
      _locationController.text = postjob.location ?? '';
      _cityController.text = postjob.city ?? '';
      _districtController.text = postjob.district ?? '';
      _dueDateController.text = postjob.dueDate ?? 'Select deadline (yyyy-mm-dd)';
    } catch (e, stack) {
      debugPrint('Initialization error: $e\n$stack');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Failed to load job data'),
            backgroundColor: Colors.red,
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () => _initializeWithPostJobData(postjob),
            ),
          ),
        );
      }
    }
  }

  void _setupControllers() {
    final job = ref.read(postJobNotifierProvider);
    _titleController.text = job.title;
    _descriptionController.text = job.description;
    _rolesController.text = job.rolesDescription ?? '';
    _locationController.text = job.location ?? '';
    _cityController.text = job.city ?? '';
    _districtController.text = job.district ?? '';
    _dueDateController.text = job.dueDate ?? 'Select deadline (yyyy-mm-dd)';
  }

  void _clearError(String field) {
    if (_errors.containsKey(field)) {
      setState(() => _errors.remove(field));
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _rolesController.dispose();
    _locationController.dispose();
    _cityController.dispose();
    _districtController.dispose();
    _requirementController.dispose();
    _requiredSkillController.dispose();
    _optionalSkillController.dispose();
    _dueDateController.dispose();
    if (widget.mode == FormMode.edit) {
      Future.microtask(() => ref.invalidate(postJobNotifierProvider));
    }
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_isSubmitting) return;
    
    setState(() => _isSubmitting = true);
    
    try {
      final notifier = ref.read(postJobNotifierProvider.notifier);
      debugPrint('Submitting with ID: ${widget.initialData?.id}');
      
      final success = await notifier.submitJob(
        mode: widget.mode,
        jobId: widget.initialData?.id,
      );
      
      if (mounted && success) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Job ${widget.mode == FormMode.edit ? 'updated' : 'posted'} successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final job = ref.watch(postJobNotifierProvider);
    final notifier = ref.read(postJobNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mode == FormMode.edit ? 'Edit Job' : 'Post a Job'),
        actions: [
          TextButton(
            onPressed: _isSubmitting ? null : _submitForm,
            child: _isSubmitting
                ? const CircularProgressIndicator()
                : Text(widget.mode == FormMode.edit ? 'Update' : 'Post'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildJobTypeSelector(job, notifier),
              const SizedBox(height: 24),
              _buildBasicInfoSection(job, notifier),
              const SizedBox(height: 24),
              _buildDynamicFields(job, notifier),
              const SizedBox(height: 24),
              _buildRequirementsSection(job, notifier),
              const SizedBox(height: 24),
              _buildSkillsSection(job, notifier),
              const SizedBox(height: 24),
              _buildWorkingDaysSection(job, notifier),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildJobTypeSelector(PostJob job, PostJobNotifier notifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Job Type',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            _JobTypeChip(
              label: 'Local',
              value: 'LOC',
              selected: job.jobType == 'LOC',
              onSelected: (val) => notifier.updateJobType('LOC'),
            ),
            _JobTypeChip(
              label: 'Professional',
              value: 'PRO',
              selected: job.jobType == 'PRO',
              onSelected: (val) => notifier.updateJobType('PRO'),
            ),
            _JobTypeChip(
              label: 'Internship',
              value: 'INT',
              selected: job.jobType == 'INT',
              onSelected: (val) => notifier.updateJobType('INT'),
            ),
            _JobTypeChip(
              label: 'Volunteer',
              value: 'VOL',
              selected: job.jobType == 'VOL',
              onSelected: (val) => notifier.updateJobType('VOL'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBasicInfoSection(PostJob job, PostJobNotifier notifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Basic Information',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _titleController,
          decoration: InputDecoration(
            labelText: 'Job Title',
            border: const OutlineInputBorder(),
            errorText: _errors['title'],
          ),
          onChanged: (value) {
            notifier.updateField('title', value);
            _clearError('title');
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _locationController,
          decoration: InputDecoration(
            labelText: 'Location (Street/Area)',
            border: const OutlineInputBorder(),
            errorText: _errors['location'],
          ),
          onChanged: (value) {
            notifier.updateField('location', value);
            _clearError('location');
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _cityController,
          decoration: InputDecoration(
            labelText: 'City',
            border: const OutlineInputBorder(),
            errorText: _errors['city'],
          ),
          onChanged: (value) {
            notifier.updateField('city', value);
            _clearError('city');
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _districtController,
          decoration: InputDecoration(
            labelText: 'District/Neighborhood',
            border: const OutlineInputBorder(),
            errorText: _errors['district'],
          ),
          onChanged: (value) {
            notifier.updateField('district', value);
            _clearError('district');
          },
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          value: job.job_nature ?? 'Full time',
          decoration: const InputDecoration(
            labelText: 'Job Nature',
            border: OutlineInputBorder(),
          ),
          items: const [
            DropdownMenuItem(value: 'Full time', child: Text('Full-time')),
            DropdownMenuItem(value: 'Part time', child: Text('Part-time')),
            DropdownMenuItem(value: 'Contract', child: Text('Contract')),
            DropdownMenuItem(value: 'Freelance', child: Text('Freelance')),
          ],
          onChanged: (value) {
            if (value != null) notifier.updateField('job_nature', value);
          },
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          value: job.category,
          decoration: const InputDecoration(
            labelText: 'Category',
            border: OutlineInputBorder(),
          ),
          items: const [
            DropdownMenuItem(value: 'IT', child: Text('Information Technology')),
            DropdownMenuItem(value: 'HEALTH', child: Text('Health')),
            DropdownMenuItem(value: 'FINANCE', child: Text('Finance')),
          ],
          onChanged: (value) {
            if (value != null) notifier.updateField('category', value);
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _descriptionController,
          maxLines: 5,
          decoration: InputDecoration(
            labelText: 'Description',
            border: const OutlineInputBorder(),
            errorText: _errors['description'],
          ),
          onChanged: (value) {
            notifier.updateField('description', value);
            _clearError('description');
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _rolesController,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Roles & Responsibilities',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => notifier.updateField('rolesDescription', value),
        ),
      ],
    );
  }

  Widget _buildDynamicFields(PostJob job, PostJobNotifier notifier) {
    final isPaidJob = job.jobType == 'PRO' || job.jobType == 'LOC';
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isPaidJob) ...[
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Salary Amount',
              border: const OutlineInputBorder(),
              prefixText: 'FCFA',
              errorText: _errors['salary'],
            ),
            onChanged: (value) {
              notifier.updateTypeSpecific(
                'salary', 
                value.isEmpty ? null : int.tryParse(value),
              );
              _clearError('salary');
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: job.typeSpecific['salary_period'] ?? 'd',
            decoration: const InputDecoration(
              labelText: 'Salary Period',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: 'd', child: Text('Daily')),
              DropdownMenuItem(value: 'w', child: Text('Weekly')),
              DropdownMenuItem(value: 'm', child: Text('Monthly')),
            ],
            onChanged: (value) => notifier.updateTypeSpecific('salary_period', value),
          ),
        ] else ...[
          SwitchListTile(
            title: const Text('Includes Compensation'),
            value: job.typeSpecific['compensation_toggle'] ?? false,
            onChanged: (value) => notifier.updateTypeSpecific('compensation_toggle', value),
          ),
          if (job.typeSpecific['compensation_toggle'] == true) ...[
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Compensation Details',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => notifier.updateTypeSpecific(
                'bonus_supplementary', 
                {'details': value},
              ),
            ),
          ],
        ],
        const SizedBox(height: 24),
        TextFormField(
          readOnly: true,
          controller: _dueDateController,
          decoration: InputDecoration(
            labelText: 'Due Date',
            border: const OutlineInputBorder(),
            errorText: _errors['dueDate'],
          ),
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now().add(const Duration(days: 7)),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (date != null) {
              notifier.updateField(
                'dueDate', 
                DateFormat('yyyy-MM-dd').format(date),
              );
              _dueDateController.text = DateFormat('yyyy-MM-dd').format(date);
              _clearError('dueDate');
            }
          },
        ),
      ],
    );
  }

  Widget _buildRequirementsSection(PostJob job, PostJobNotifier notifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Requirements', style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 8,
          children: [
            ...job.requirements.map((req) => Chip(
              label: Text(req),
              onDeleted: () => notifier.updateField(
                'requirements',
                job.requirements.where((r) => r != req).toList(),
              ),
            )),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 100),
              child: TextFormField(
                controller: _requirementController,
                decoration: InputDecoration(
                  labelText: 'Add requirement',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      if (_requirementController.text.isNotEmpty) {
                        notifier.updateField(
                          'requirements',
                          [...job.requirements, _requirementController.text],
                        );
                        _requirementController.clear();
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSkillsSection(PostJob job, PostJobNotifier notifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Skills Required',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 16),
        
        // Required Skills
        _buildSkillInputField(
          controller: _requiredSkillController,
          label: 'Required Skills (Must Have)',
          skills: job.requiredSkills,
          onAdd: (skill) => notifier.updateField('requiredSkills', [...job.requiredSkills, skill]),
          onRemove: (skill) => notifier.updateField(
            'requiredSkills', 
            job.requiredSkills.where((s) => s != skill).toList(),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Optional Skills
        _buildSkillInputField(
          controller: _optionalSkillController,
          label: 'Bonus Skills (Nice to Have)',
          skills: job.optionalSkills,
          onAdd: (skill) => notifier.updateField('optionalSkills', [...job.optionalSkills, skill]),
          onRemove: (skill) => notifier.updateField(
            'optionalSkills', 
            job.optionalSkills.where((s) => s != skill).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSkillInputField({
    required TextEditingController controller,
    required String label,
    required List<String> skills,
    required Function(String) onAdd,
    required Function(String) onRemove,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ...skills.map((skill) => Chip(
              label: Text(skill),
              onDeleted: () => onRemove(skill),
            )),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width - 100,
              ),
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: 'Add skill',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      if (controller.text.trim().isNotEmpty) {
                        onAdd(controller.text.trim());
                        controller.clear();
                      }
                    },
                  ),
                ),
                onFieldSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    onAdd(value.trim());
                    controller.clear();
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWorkingDaysSection(PostJob job, PostJobNotifier notifier) {
    const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Working Days',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: days.map((day) => FilterChip(
            label: Text(day),
            selected: job.workingDays.contains(day),
            onSelected: (selected) {
              final newDays = List<String>.from(job.workingDays);
              if (selected) {
                newDays.add(day);
              } else {
                newDays.remove(day);
              }
              notifier.updateField('workingDays', newDays);
            },
          )).toList(),
        ),
      ],
    );
  }
}

class _JobTypeChip extends StatelessWidget {
  final String label;
  final String value;
  final bool selected;
  final Function(bool) onSelected;

  const _JobTypeChip({
    required this.label,
    required this.value,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
      selectedColor: Theme.of(context).primaryColor,
      labelStyle: TextStyle(
        color: selected ? Colors.white : Colors.black,
      ),
    );
  }
}