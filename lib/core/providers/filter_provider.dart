// Job Filter Sheets Provider
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/features/search_filter/bottomsheet/job_bottomsheet.dart';
import 'package:workdey_frontend/features/search_filter/bottomsheet/workers_bottomsheet.dart';

class JobFilterSheets {
  void showMainFilterSheet(BuildContext context, WidgetRef ref) {
    showMainFilterSheet(context, ref);  
    }
  
  void showCategorySheet(BuildContext context, WidgetRef ref) {
    showJobCategoryBottomSheet(context, ref);
    // Show 35% height sheet for category
  }
   void showJobTypeSheet(BuildContext context, WidgetRef ref) {
    showJobTypeBottomSheet(context, ref);
    } 

    void showNatureSheet(BuildContext context, WidgetRef ref) {
      showJobNatureBottomSheet(context, ref);
    }
    void showWorkingDaysSheet(BuildContext context, WidgetRef ref) {
      showJobWorkingDaysBottomSheet(context, ref);
    }
    void showSkillsSheet(BuildContext context, WidgetRef ref) {
    showJobSkillsBottomSheet(context, ref);
    }

    void showLocationSheet(BuildContext context, WidgetRef ref) {
    showJobLocationBottomSheet(context, ref);
    }
  // Other sheet methods...
}


// Worker Filter Sheets Provider
class WorkerFilterSheets {
  void showMainFilterSheet(BuildContext context, WidgetRef ref) {
    // Show 70% height sheet with all worker filters
  }
  
  void showCategorySheet(BuildContext context, WidgetRef ref) {
      showWorkerCategoryBottomSheet(context, ref); 
       }
  void showAvailabilitySheet(BuildContext context, WidgetRef ref) {
    showWorkerAvailabilityBottomSheet(context, ref);
    }

  void showWorkerSkillsSheet(BuildContext context, WidgetRef ref) {
    showWorkerSkillsBottomSheet(context, ref);
    }

    void showLocationSheet(BuildContext context, WidgetRef ref) {
    showWorkerLocationBottomSheet(context, ref);
    }
  // Other sheet methods...
}

