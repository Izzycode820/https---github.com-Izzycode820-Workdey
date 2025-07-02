// application_form_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';
import 'package:workdey_frontend/core/providers/applicantion_provider.dart';
import 'package:workdey_frontend/core/routes/routes.dart';

class ApplicationFormScreen extends ConsumerStatefulWidget {
  final Job job;

  const ApplicationFormScreen({required this.job});

  @override
  ConsumerState<ApplicationFormScreen> createState() => _ApplicationFormScreenState();
}

class _ApplicationFormScreenState extends ConsumerState<ApplicationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();
  final List<String> _selectedSkills = [];
  final List<String> _selectedOptionalSkills = [];

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Apply for ${widget.job.title}')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.job.requiredSkills.isNotEmpty) ...[
                const Text(
                  'Required Skills (Select all that apply)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...widget.job.requiredSkills.map((skill) => CheckboxListTile(
                  title: Text(skill),
                  value: _selectedSkills.contains(skill),
                  onChanged: (value) {
                    setState(() {
                      if (value == true) {
                        _selectedSkills.add(skill);
                      } else {
                        _selectedSkills.remove(skill);
                      }
                    });
                  },
                )),
                const SizedBox(height: 16),
              ],
              if (widget.job.optionalSkills.isNotEmpty) ...[
                const Text(
                  'Bonus Skills (Optional)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...widget.job.optionalSkills.map((skill) => CheckboxListTile(
                  title: Text(skill),
                  value: _selectedOptionalSkills.contains(skill),
                  onChanged: (value) {
                    setState(() {
                      if (value == true) {
                        _selectedOptionalSkills.add(skill);
                      } else {
                        _selectedOptionalSkills.remove(skill);
                      }
                    });
                  },
                )),
                const SizedBox(height: 16),
              ],
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Additional Notes',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: _submitApplication,
                  child: const Text('Submit Application'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitApplication() async {
    if (!_formKey.currentState!.validate()) return;

    final applicationData = {
      'response': {
        'skills_met': _selectedSkills,
        'optional_skills_met': _selectedOptionalSkills,
        'notes': _notesController.text,
      }
    };

    try {
      await ref.read(applicationServiceProvider).applyToJob(
        widget.job.id,
        applicationData,
      );
      if (mounted) {
        Navigator.pushNamed(
            context,
            AppRoutes.apply,
            arguments: widget.job, // Pass Job object as argument
          );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Application submitted successfully')),
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