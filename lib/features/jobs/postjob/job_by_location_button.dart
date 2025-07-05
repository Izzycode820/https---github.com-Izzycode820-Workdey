import 'package:flutter/material.dart';

class LocationSearchButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LocationSearchButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.location_on, size: 18),
      label: const Text(
        'Search Jobs in Location',
        style: TextStyle(fontSize: 13),
      ),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8),
      ),
    );
  }
}