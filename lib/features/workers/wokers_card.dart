import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/getworkers/get_workers_model.dart';
import 'package:workdey_frontend/core/providers/saved_worker_provider.dart';
import 'package:workdey_frontend/features/workers/wokers_detailed.dart';
import 'package:workdey_frontend/features/workers/workers_bookmark.dart';

class WorkerCard extends ConsumerWidget {
  final Worker worker;
  final Function(int)? onBookmarkPressed;

  const WorkerCard({
    super.key,
    required this.worker,
    this.onBookmarkPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the current saved status from provider
    final isSaved = ref.watch(savedWorkersProvider).maybeWhen(
          data: (data) => data.results.any((w) => w.id == worker.id),
          orElse: () => worker.isSaved,
        );

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WorkerDetailsScreen(worker: worker)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Header Row
              Row(
                children: [
                  // Post Time
                  if (worker.postTime != null)
                    Text(
                      worker.postTime!,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[400],
                      ),
                    ),
                  const Spacer(),
                  // Bookmark Icon
                  WorkerBookmarkWidget(
                    workerId: worker.id,
                    isSaved: isSaved,
                  )
                ],
              ),
              
              // Worker Title and Category
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      worker.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getCategoryColor(worker.category),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      worker.categoryDisplay ?? worker.category,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              
              // Worker Name and Verification
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  children: [
                    Text(
                      worker.userName ?? 'Anonymous',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (worker.verificationBadges != null) ...[
                      Icon(Icons.verified, size: 16, color: Colors.blue),
                      if (worker.verificationBadges!['email'] == true)
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Icon(Icons.email, size: 16, color: Colors.green),
                        ),
                      if (worker.verificationBadges!['phone'] == true)
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Icon(Icons.phone, size: 16, color: Colors.green),
                        ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 8),
              
              // Location & Experience
              Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: Colors.red[700]),
                  const SizedBox(width: 4),
                  Text(
                    worker.location,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.red[700],
                    ),
                  ),
                  const SizedBox(width: 16),
                  if (worker.experienceYears != null)
                    Text(
                      '${worker.experienceYears} yrs exp',
                      style: const TextStyle(fontSize: 14),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              
              // Skills
              if (worker.skills != null && worker.skills!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Skills:',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 4,
                      children: worker.skills!
                          .map((skill) => _InfoChip(label: skill, color: Colors.blue[100]!))
                          .toList(),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              
              // Availability & Rate
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: [
                  if (worker.availability != null)
                    _InfoChip(label: worker.availability!, color: Colors.green[100]!),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'plumber':
        return Colors.blue;
      case 'electrician':
        return Colors.orange;
      case 'carpenter':
        return Colors.brown;
      case 'cleaner':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final Color color;
  
  const _InfoChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: color,
      labelStyle: const TextStyle(fontSize: 12),
      visualDensity: VisualDensity.compact,
    );
  }
}