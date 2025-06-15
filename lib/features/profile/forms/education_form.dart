import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:workdey_frontend/core/models/profile/education/education_model.dart';

class EducationForm extends ConsumerStatefulWidget {
  final Education? initialData;
  const EducationForm({super.key, this.initialData});

  @override
  ConsumerState<EducationForm> createState() => _EducationFormState();
}

class _EducationFormState extends ConsumerState<EducationForm> {
  final _formKey = GlobalKey<FormState>();
  final _institutionController = TextEditingController();
  final _levelController = TextEditingController();
  final _fieldController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isCurrent = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _institutionController.text = widget.initialData!.institution;
      _levelController.text = widget.initialData!.level;
      _fieldController.text = widget.initialData!.fieldOfStudy ?? '';
      _startDate = widget.initialData!.startDate;
      _endDate = widget.initialData!.endDate;
      _isCurrent = widget.initialData!.isCurrent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initialData == null ? 'Add Education' : 'Edit Education'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _institutionController,
                decoration: const InputDecoration(
                  labelText: 'Institution*',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _levelController,
                decoration: const InputDecoration(
                  labelText: 'Level/Degree*',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _fieldController,
                decoration: const InputDecoration(
                  labelText: 'Field of Study',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              _buildDateRangePicker(),
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

  Widget _buildDateRangePicker() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _startDate ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    setState(() => _startDate = date);
                  }
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Start Date*',
                    border: OutlineInputBorder(),
                  ),
                  child: Text(
                    _startDate != null
                        ? DateFormat('yyyy-MM-dd').format(_startDate!)
                        : 'Select date',
                  ),
                ),
              ),
            ),
            if (!_isCurrent) ...[
              const SizedBox(width: 16),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _endDate ?? (_startDate ?? DateTime.now()),
                      firstDate: _startDate ?? DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (date != null) {
                      setState(() => _endDate = date);
                    }
                  },
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'End Date',
                      border: OutlineInputBorder(),
                    ),
                    child: Text(
                      _endDate != null
                          ? DateFormat('yyyy-MM-dd').format(_endDate!)
                          : 'Select date',
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
        CheckboxListTile(
          title: const Text('I currently study here'),
          value: _isCurrent,
          onChanged: (value) => setState(() => _isCurrent = value ?? false),
          controlAffinity: ListTileControlAffinity.leading,
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
    _institutionController.dispose();
    _levelController.dispose();
    _fieldController.dispose();
    super.dispose();
  }
}