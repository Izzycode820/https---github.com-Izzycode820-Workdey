// core/providers/route_provider.dart
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/providers/get_job_provider.dart';

enum AppSection { findJobs, postJobs }

final appSectionProvider = StateProvider<AppSection>((ref) => AppSection.findJobs);

// Add this notifier for handling navigation actions
final sectionNavigationProvider = Provider((ref) {
  return SectionNavigationNotifier(ref);
});

final lastRefreshTimeProvider = StateProvider<DateTime?>((ref) => null);

class SectionNavigationNotifier {
  final Ref _ref;

  SectionNavigationNotifier(this._ref);

  void navigateToFindJobs(BuildContext context) {
    final now = DateTime.now();
    final lastRefresh = _ref.read(lastRefreshTimeProvider);
    
    // Only refresh if more than 5 minutes passed or first load
    if (lastRefresh == null || now.difference(lastRefresh).inMinutes > 5) {
      _ref.read(jobsNotifierProvider.notifier).loadInitialJobs();
      _ref.read(lastRefreshTimeProvider.notifier).state = now;
    }
    
    _ref.read(appSectionProvider.notifier).state = AppSection.findJobs;
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void navigateToPostJobs(BuildContext context) {
    _ref.read(appSectionProvider.notifier).state = AppSection.postJobs;
    Navigator.pushNamed(context, '/post-jobs');
  }
}