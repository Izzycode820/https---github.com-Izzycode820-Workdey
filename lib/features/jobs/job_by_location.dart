import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocationSearchSheet extends ConsumerStatefulWidget {
  final Function(String city, String? district) onSearch;

  const LocationSearchSheet({super.key, required this.onSearch});

  @override
  ConsumerState<LocationSearchSheet> createState() => _LocationSearchSheetState();
}

class _LocationSearchSheetState extends ConsumerState<LocationSearchSheet> {
  final _formKey = GlobalKey<FormState>();
  final _cityController = TextEditingController();
  final _districtController = TextEditingController();

  @override
  void dispose() {
    _cityController.dispose();
    _districtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'City',
                hintText: 'e.g., Douala',
                border: OutlineInputBorder(),
              ),
              validator: (value) => value?.isEmpty ?? true ? 'City is required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _districtController,
              decoration: const InputDecoration(
                labelText: 'District (Optional)',
                hintText: 'e.g., Bonaberi',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            onPressed: _submit, // Fixed: Moved outside style
            child: const Text('Find Jobs in This Location'), // Fixed: Proper child parameter
          ),],
        ),
      ),
    );
  }

  void _submit() {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();
    final city = _cityController.text.trim();
    final district = _districtController.text.trim();
    
    // This triggers the location search
    widget.onSearch(city, district.isEmpty ? null : district);
    Navigator.pop(context); // Close the bottom sheet
  }
}
}