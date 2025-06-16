// screens/post_worker_form.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/getworkers/get_workers_model.dart';
import 'package:workdey_frontend/core/models/postworker/post_worker_model.dart';
import 'package:workdey_frontend/core/providers/post_worker_provider.dart';

class PostWorkerForm extends ConsumerStatefulWidget {
  final Worker? initialData;
  const PostWorkerForm({super.key, this.initialData});

  @override
  ConsumerState<PostWorkerForm> createState() => _PostWorkerFormState();
}

class _PostWorkerFormState extends ConsumerState<PostWorkerForm> {
  final _formKey = GlobalKey<FormState>();
  // Initialize controllers with empty strings
  final _titleController = TextEditingController(text: '');
  final _bioController = TextEditingController(text: '');
  final _locationController = TextEditingController(text: '');
  final _experienceController = TextEditingController(text: '0'); // Default to 0
  final _portfolioController = TextEditingController(text: '');
  final _skillController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _initializeWithWorkerData(widget.initialData!);
    }
  }

  void _initializeWithWorkerData(Worker worker) {
    final notifier = ref.read(postWorkerNotifierProvider.notifier);
    final postWorker = worker.toPostWorker();
    
    // Handle null values with defaults
    notifier.updateField('title', worker.title ?? '');
    notifier.updateField('category', worker.category ?? 'CONSTRUCTION');
    notifier.updateField('location', worker.location ?? '');
    notifier.updateField('bio', worker.bio ?? '');
    notifier.updateField('availability', worker.availability ?? 'FT');
    notifier.updateField('experienceYears', worker.experienceYears ?? 0);
    notifier.updateField('portfolioLink', worker.portfolioLink);
    
    // Set controller values with null checks
    _titleController.text = worker.title ?? '';
    _bioController.text = worker.bio ?? '';
    _locationController.text = worker.location ?? '';
    _experienceController.text = (worker.experienceYears ?? 0).toString();
    _portfolioController.text = worker.portfolioLink ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final worker = ref.watch(postWorkerNotifierProvider);
    final notifier = ref.read(postWorkerNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.initialData != null ? 'Edit Worker Profile' : 'Create Worker Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _submitForm,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title (e.g. Electrician)'),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                onChanged: (value) => notifier.updateField('title', value),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: worker.category,
                items: const [
                  DropdownMenuItem(value: 'CONSTRUCTION', child: Text('Construction')),
                  DropdownMenuItem(value: 'IT', child: Text('IT')),
                  DropdownMenuItem(value: 'HEALTH', child: Text('Health')),
                  DropdownMenuItem(value: 'DESIGN', child: Text('Design')),
                ],
                onChanged: (value) => notifier.updateField('category', value),
                decoration: const InputDecoration(labelText: 'Category'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                onChanged: (value) => notifier.updateField('location', value),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _bioController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Bio'),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                onChanged: (value) => notifier.updateField('bio', value),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: worker.availability,
                items: const [
                  DropdownMenuItem(value: 'FT', child: Text('Full-time')),
                  DropdownMenuItem(value: 'PT', child: Text('Part-time')),
                  DropdownMenuItem(value: 'CN', child: Text('Contract')),
                  DropdownMenuItem(value: 'FL', child: Text('Freelance')),
                ],
                onChanged: (value) => notifier.updateField('availability', value),
                decoration: const InputDecoration(labelText: 'Availability'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _experienceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Years of Experience'),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                onChanged: (value) => notifier.updateField('experienceYears', int.tryParse(value) ?? 0),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _portfolioController,
                decoration: const InputDecoration(labelText: 'Portfolio Link (optional)'),
                onChanged: (value) => notifier.updateField('portfolioLink', value),
              ),
              const SizedBox(height: 16),
              _buildSkillsSection(worker, notifier),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkillsSection(PostWorker worker, PostWorkerNotifier notifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Skills', style: TextStyle(fontSize: 16)),
        Wrap(
          spacing: 8,
          children: worker.skills.map((skill) => Chip(
            label: Text(skill),
            onDeleted: () => notifier.removeSkill(skill),
          )).toList(),
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _skillController,
                decoration: const InputDecoration(labelText: 'Add skill'),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                if (_skillController.text.isNotEmpty) {
                  notifier.addSkill(_skillController.text);
                  _skillController.clear();
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        await ref.read(postWorkerNotifierProvider.notifier).submitWorker(
          workerId: widget.initialData?.id,
        );
        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Worker profile saved successfully')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${e.toString()}')),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bioController.dispose();
    _locationController.dispose();
    _experienceController.dispose();
    _portfolioController.dispose();
    _skillController.dispose();
    super.dispose();
  }
}