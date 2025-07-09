// lib/screens/saves_screen.dart - COMPLETELY REWRITTEN as Activity Center
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/features/activities/activity_center_screen.dart';

// For backward compatibility, you can also export the individual components
// if other parts of your app need them
export 'package:workdey_frontend/features/activities/activity_center_screen.dart';
export 'package:workdey_frontend/core/providers/activity_state_provider.dart';


// This is your main entry point - just delegates to the new Activity Center
class SavedJobsPage extends ConsumerWidget {
  const SavedJobsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const ActivityCenterScreen();
  }
}



