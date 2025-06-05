// applicants_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:workdey_frontend/core/models/applicant_model.dart';
import 'package:workdey_frontend/core/providers/providers.dart';

class ApplicantsScreen extends ConsumerWidget {
  final int jobId;

  const ApplicantsScreen({super.key, required this.jobId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Applicants'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, size: 22), // Thin reload icon
            onPressed: () {
              // Add your refresh logic here
              ref.invalidate(jobApplicantsProvider(jobId)); // Example using Riverpod
            },
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final applicantsAsync = ref.watch(jobApplicantsProvider(jobId));
          
          return applicantsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('Error: $error')),
            data: (applicants) {
              if (applicants.isEmpty) {
                return const Center(child: Text('No applicants yet'));
              }
          
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: applicants.length,
            itemBuilder: (context, index) {
              final applicant = applicants[index];
              return _ApplicantCard(applicant: applicant);
            },
          );
        },
          );
        },
      ),
    );
  }
}

class _ApplicantCard extends StatelessWidget {
  final Applicant applicant;

  const _ApplicantCard({required this.applicant});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Text(
                    applicant.details.name[0].toUpperCase(),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        applicant.details.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(applicant.details.email),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
            const SizedBox(height: 16),
            _buildVerifiedBadges(),
            const SizedBox(height: 8),
            Text(
              'Applied on ${DateFormat('MMM d, y').format(applicant.appliedAt)}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerifiedBadges() {
    return Wrap(
      spacing: 8,
      children: [
        if (applicant.badges['email'] == true)
          Chip(
            label: const Text('Email Verified'),
            backgroundColor: Colors.green[100],
            avatar: const Icon(Icons.verified, size: 16, color: Colors.green),
          ),
        if (applicant.badges['phone'] == true)
          Chip(
            label: const Text('Phone Verified'),
            backgroundColor: Colors.green[100],
            avatar: const Icon(Icons.verified, size: 16, color: Colors.green),
          ),
        if (applicant.badges['id'] == true)
          Chip(
            label: const Text('ID Verified'),
            backgroundColor: Colors.green[100],
            avatar: const Icon(Icons.verified, size: 16, color: Colors.green),
          ),
      ],
    );
  }
}