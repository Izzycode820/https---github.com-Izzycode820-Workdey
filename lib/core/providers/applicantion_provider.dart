import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/applicant/applicant_model.dart';
import 'package:workdey_frontend/core/providers/providers.dart';
import 'package:workdey_frontend/core/services/applicant_service.dart';

final applicationServiceProvider = Provider((ref) {
  final dio = ref.read(dioProvider);
  return ApplicantService(dio);
});

final applicantServiceProvider = Provider((ref) {
  final dio = ref.read(dioProvider);
  return ApplicantService(dio);
});

final myApplicationsProvider = FutureProvider<List<Application>>((ref) {
  return ref.read(applicationServiceProvider).getMyApplications();
});

final jobApplicantsProvider = FutureProvider.family<List<Application>, int>((ref, jobId) {
  return ref.read(applicantServiceProvider).getJobApplicants(jobId);
});