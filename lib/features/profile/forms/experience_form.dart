import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:workdey_frontend/core/models/profile/experience/experience_model.dart';

class ExperienceForm extends ConsumerStatefulWidget {
  final Experience? initialData;
  const ExperienceForm({super.key, this.initialData});

  @override
  ConsumerState<ExperienceForm> createState() => _ExperienceFormState();
}

class _ExperienceFormState extends ConsumerState<ExperienceForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _companyController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isCurrent = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _titleController.text = widget.initialData!.title;
      _companyController.text = widget.initialData!.company ?? '';
      _descriptionController.text = widget.initialData!.description ?? '';
      _startDate = widget.initialData!.startDate;
      _endDate = widget.initialData!.endDate;
      _isCurrent = widget.initialData!.isCurrent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initialData == null ? 'Add Experience' : 'Edit Experience'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title*',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _companyController,
                decoration: const InputDecoration(
                  labelText: 'Company',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              _buildDateRangePicker(),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
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
          title: const Text('I currently work here'),
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
    _titleController.dispose();
    _companyController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}