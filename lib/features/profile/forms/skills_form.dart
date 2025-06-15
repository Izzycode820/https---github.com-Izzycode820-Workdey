import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SkillsForm extends ConsumerStatefulWidget {
  const SkillsForm({super.key});

  @override
  ConsumerState<SkillsForm> createState() => _SkillsFormState();
}

class _SkillsFormState extends ConsumerState<SkillsForm> {
  final _formKey = GlobalKey<FormState>();
  final _skillController = TextEditingController();
  String _proficiency = 'Beginner';
  bool _willingToLearn = true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Skill'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _skillController,
                decoration: const InputDecoration(
                  labelText: 'Skill Name*',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _proficiency,
                decoration: const InputDecoration(
                  labelText: 'Proficiency Level',
                  border: OutlineInputBorder(),
                ),
                items: ['Beginner', 'Intermediate', 'Advanced', 'Expert']
                    .map((level) => DropdownMenuItem(
                          value: level,
                          child: Text(level),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _proficiency = value ?? 'Beginner'),
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                title: const Text('Willing to learn/improve'),
                value: _willingToLearn,
                onChanged: (value) => setState(() => _willingToLearn = value ?? true),
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3E8728),
          ),
          onPressed: _submitForm,
          child: const Text('Save'),
        ),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Save logic here
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _skillController.dispose();
    super.dispose();
  }
}