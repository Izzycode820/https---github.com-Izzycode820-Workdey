// worker_details_screen.dart
import 'package:flutter/material.dart';
import 'package:workdey_frontend/core/models/getworkers/get_workers_model.dart';

class WorkerDetailsScreen extends StatefulWidget {
  final Worker worker;
  
  const WorkerDetailsScreen({
    super.key,
    required this.worker,
  });

  @override
  State<WorkerDetailsScreen> createState() => _WorkerDetailsScreenState();
}

class _WorkerDetailsScreenState extends State<WorkerDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final worker = widget.worker;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(worker.title ?? 'Worker Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              worker.title ?? 'No title',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            
            // Category
            Text(
              worker.category ?? 'No category',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            
            const SizedBox(height: 16),
            
            // Location
            Row(
              children: [
                const Icon(Icons.location_on, size: 16),
                const SizedBox(width: 4),
                Text(worker.location ?? 'Location not specified'),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Experience
            Text(
              'Experience: ${worker.experienceYears ?? 0} years',
              style: const TextStyle(fontSize: 16),
            ),
            
            const SizedBox(height: 16),
            
            // Availability
            Text(
              'Availability: ${_getAvailabilityText(worker.availability)}',
              style: const TextStyle(fontSize: 16),
            ),
            
            const SizedBox(height: 16),
            
            // Skills
            const Text('Skills:', style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8,
              children: (worker.skills ?? []).map((skill) => Chip(
                label: Text(skill),
              )).toList(),
            ),
            
            const SizedBox(height: 16),
            
            // Bio
            const Text('Bio:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(worker.bio ?? 'No bio provided'),
            
            // Portfolio Link if exists
            if (worker.portfolioLink != null) ...[
              const SizedBox(height: 16),
              const Text('Portfolio:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(worker.portfolioLink!),
            ],
          ],
        ),
      ),
    );
  }

  String _getAvailabilityText(String? availability) {
    switch (availability) {
      case 'FT': return 'Full-time';
      case 'PT': return 'Part-time';
      case 'CN': return 'Contract';
      case 'FL': return 'Freelance';
      default: return availability ?? 'Not specified';
    }
  }
}