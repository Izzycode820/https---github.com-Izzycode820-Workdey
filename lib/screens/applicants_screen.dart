// applicants_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/providers/applicantion_provider.dart';
import 'package:workdey_frontend/features/application/application_card.dart';

class ApplicantsScreen extends ConsumerWidget {
  final int jobId;

  const ApplicantsScreen({super.key, required this.jobId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applicantsAsync = ref.watch(jobApplicantsProvider(jobId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Applicants'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.refresh(jobApplicantsProvider(jobId)),
          ),
        ],
      ),
      body: applicantsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (applicants) {
          if (applicants.isEmpty) {
            return const Center(child: Text('No applicants yet'));
          }
          return RefreshIndicator(
            onRefresh: () async {
              // Explicitly return a Future<void> by awaiting the refresh
              await ref.refresh(jobApplicantsProvider(jobId).future);
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: applicants.length,
              itemBuilder: (context, index) {
                return ApplicantCard(
                  application: applicants[index],
                  isEmployerView: true,
                  onStatusChanged: (status) => _updateStatus(
                    context,
                    ref,
                    applicants[index].id,
                    status,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Future<void> _updateStatus(
    BuildContext context,
    WidgetRef ref,
    int applicationId,
    String status,
  ) async {
    try {
      await ref
          .read(applicationServiceProvider)
          .updateApplicationStatus(applicationId, status);
      ref.invalidate(jobApplicantsProvider(jobId));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update status: ${e.toString()}')),
      );
    }
  }
}