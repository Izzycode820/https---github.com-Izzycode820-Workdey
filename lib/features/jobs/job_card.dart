import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';
import 'package:workdey_frontend/core/providers/saved_jobs_provider.dart';
import 'package:workdey_frontend/features/jobs/job_bookmark.dart';
import 'package:workdey_frontend/features/jobs/job_detailes.dart';

class JobCard extends ConsumerWidget {
  final Job job;
  final Function(int)? onBookmarkPressed;

  const JobCard({
    super.key,
    required this.job,
    this.onBookmarkPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
     // Get the current saved status from provider
    final isSaved = ref.watch(savedJobsProvider).maybeWhen(
      data: (data) => data.results.any((j) => j.id == job.id),
      orElse: () => job.isSaved,
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
          MaterialPageRoute(builder: (context) => JobDetailsScreen(job: job)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLocationHeader(context, job),
              // Top Header Row
              Row(
                children: [
                  // Post Time
                  Text(
                    job.postTime ?? 'Recently',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[400],
                    ),
                  ),
                  const Spacer(),
                  // Bookmark Icon
                  JobBookmarkWidget(
                    jobId: job.id,
                    isSaved: isSaved,
                  )
                ],
              ),
              const SizedBox(height: 1),
              
              // Job Title and Type
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      job.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 1),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getJobTypeColor(job.jobType),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      job.jobType,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              
              // Poster and Verification
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  children: [
                    Text(
                      'Posted by: ${job.posterName}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (job.verificationBadges != null) ...[
                      Icon(Icons.verified, size: 16, color: Colors.blue),
                      if (job.verificationBadges!['email'] == true)
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Icon(Icons.email, size: 16, color: Colors.green),
                        ),
                      if (job.verificationBadges!['phone'] == true)
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Icon(Icons.phone, size: 16, color: Colors.green),
                        ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 2),
              
              // Location & Category
              Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: Colors.red[700]),
                  const SizedBox(width: 4),
                  Text(job.locationDisplay ?? job.location, // Fallback to 'location' if null
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.red[700],
                      ),
                    ),
                  const SizedBox(width: 16),
                  Text(
                    job.category,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              
              // Salary & Job Nature
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: [
                  if (job.salaryDisplay != null)
                    _InfoChip(label: job.salaryDisplay!, color: Colors.green[100]!),
                  _InfoChip(label: job.jobNature ?? 'Flexible', color: Colors.blue[100]!),
                ],
              ),
              const SizedBox(height: 0.5),
              
              // Working Days
              if (job.workingDays != null && job.workingDays!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Working Days:',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Wrap(
                      spacing: 2,
                      children: job.workingDays!
                          .map((day) => _InfoChip(label: day, color: Colors.orange[100]!))
                          .toList(),
                    ),
                    const SizedBox(height: 2),
                  ],
                ),
              
              // Requirements (Full List)
              if (job.requirements != null && job.requirements!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Requirements:',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 0.25),
                    Wrap(
                      spacing: 4,
                      runSpacing: 2,
                      children: job.requirements!
                          .map((req) => _InfoChip(
                                label: req,
                                color: Colors.lightGreen[100]!,
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 2),
                  ],
                ),
              
              // Footer Status
              Padding(
                padding: const EdgeInsets.only(top: 1),
                child: Row(
                  children: [
                    if (job.hasApplied)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Applied',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    const Spacer(),
                    if (job.expiresIn != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: job.expiresIn == 'Expired'
                              ? Colors.red[100]
                              : Colors.amber[100],
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                        child: Text(
                          job.expiresIn!,
                          style: TextStyle(
                            color: job.expiresIn == 'Expired'
                                ? Colors.red
                                : Colors.amber[800],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getJobTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'professional':
        return Colors.blue;
      case 'internship':
        return Colors.purple;
      case 'contract':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}

// NEW: Location badge widget
  Widget _buildLocationHeader(BuildContext context, Job job) {
  return Row(
    children: [
      if (job.isPrecise ?? false)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.green[50],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.place, size: 14, color: Colors.green),
              const SizedBox(width: 4),
              Text(
                'Local Match',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.green[800],
                ),
              ),
            ],
          ),
        ),
      if (job.isPrecise == false && job.city != null)
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              'Showing results near ${job.city}',
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: Colors.orange[800],
              ),
            ),
          ),
        ),
    ],
  );
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