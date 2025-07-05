import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/applicant/applicant_model.dart';
import 'package:workdey_frontend/core/providers/providers.dart';

// Application counts state
class ApplicationCounts {
  final int total;
  final int pending;
  final int approved;
  final int rejected;
  final int newApplications; // Applications from last 24 hours

  ApplicationCounts({
    required this.total,
    required this.pending,
    required this.approved,
    required this.rejected,
    required this.newApplications,
  });
}

// Provider for application counts
final applicationCountsProvider = FutureProvider.family<ApplicationCounts, int>((ref, jobId) async {
  try {
    final applications = await ref.read(applicantServiceProvider).getJobApplicants(jobId);
    
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(hours: 24));
    
    int pending = 0;
    int approved = 0;
    int rejected = 0;
    int newApps = 0;
    
    for (final app in applications) {
      // Count by status
      switch (app.status) {
        case 'PENDING':
          pending++;
          break;
        case 'APPROVED':
          approved++;
          break;
        case 'REJECTED':
          rejected++;
          break;
      }
      
      // Count new applications (last 24 hours)
      if (app.appliedAt.isAfter(yesterday)) {
        newApps++;
      }
    }
    
    return ApplicationCounts(
      total: applications.length,
      pending: pending,
      approved: approved,
      rejected: rejected,
      newApplications: newApps,
    );
  } catch (e) {
    return ApplicationCounts(
      total: 0,
      pending: 0,
      approved: 0,
      rejected: 0,
      newApplications: 0,
    );
  }
});

// Provider for applications list
final applicationsProvider = FutureProvider.family<List<Application>, int>((ref, jobId) {
  return ref.read(applicantServiceProvider).getJobApplicants(jobId);
});