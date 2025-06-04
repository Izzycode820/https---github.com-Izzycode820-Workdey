import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:workdey_frontend/core/models/post_job_model.dart';
import 'package:workdey_frontend/core/providers/post_job_provider.dart';

class PostJobForm extends ConsumerStatefulWidget {
  const PostJobForm({super.key});

  @override
  ConsumerState<PostJobForm> createState() => _PostJobFormState();
}

class _PostJobFormState extends ConsumerState<PostJobForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _rolesController = TextEditingController();
  final _locationController = TextEditingController();
  final _requirementController = TextEditingController();
  final _dueDateController = TextEditingController();
  Map<String, String> _errors = {};

  @override
  void initState() {
    super.initState();
    _setupControllers();
  }

  void _setupControllers() {
    final job = ref.read(postJobNotifierProvider);
    _titleController.text = job.title;
    _descriptionController.text = job.description;
    _rolesController.text = job.rolesDescription ?? '';
    _locationController.text = job.location;
    _dueDateController.text = job.dueDate ?? 'Select deadline (yyyy-mm-dd)';
  }

  void _clearError(String field) {
    setState(() => _errors.remove(field));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _rolesController.dispose();
    _locationController.dispose();
    _requirementController.dispose();
    _dueDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final job = ref.watch(postJobNotifierProvider);
    final notifier = ref.read(postJobNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post a Job'),
        actions: [
          TextButton(
            onPressed: _submitForm,
            child: const Text('Post'),
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
            labelText: 'Location',
            border: const OutlineInputBorder(),
            errorText: _errors['location'],
          ),
          onChanged: (value) {
            notifier.updateField('location', value);
            _clearError('location');
          },
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          value: job.jobNature ?? 'FT',
          decoration: const InputDecoration(
            labelText: 'Job Nature',
            border: OutlineInputBorder(),
          ),
          items: const [
            DropdownMenuItem(value: 'FT', child: Text('Full-time')),
            DropdownMenuItem(value: 'PT', child: Text('Part-time')),
            DropdownMenuItem(value: 'CN', child: Text('Contract')),
            DropdownMenuItem(value: 'FL', child: Text('Freelance')),
          ],
          onChanged: (value) {
            if (value != null) notifier.updateField('jobNature', value);
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
              prefixText: '₦',
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

  Future<void> _submitForm() async {
    final errors = ref.read(postJobNotifierProvider.notifier).state.validate();
    if (errors != null) {
      setState(() => _errors = errors);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fix the errors')),
      );
      return;
    }

    try {
      final success = await ref.read(postJobNotifierProvider.notifier).submitJob();
      if (success && context.mounted) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Job posted successfully!')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
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