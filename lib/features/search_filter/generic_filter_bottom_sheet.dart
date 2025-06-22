import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/features/search_filter/generic_filter_bottom_sheet.dart' as worker_sheets;
import 'package:workdey_frontend/features/search_filter/generic_filter_bottom_sheet.dart' as job_sheets;

//  bottom sheet decoration
const _bottomSheetDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  boxShadow: [
    BoxShadow(
      color: Colors.black,
      blurRadius: 4,
      offset: Offset(0, -4),
    ),
  ],
);

const _headerTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
  color: Colors.black87,
);

const _categoryTextStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
);

const _buttonTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: Colors.white,
);

// Worker filter sheets
void showWorkerCategoryBottomSheet(BuildContext context, WidgetRef ref) {
  worker_sheets.showWorkerCategoryBottomSheet(context, ref);
}

void showWorkerAvailabilityBottomSheet(BuildContext context, WidgetRef ref) {
  worker_sheets.showWorkerAvailabilityBottomSheet(context, ref);
}

// Job filter sheets
void showJobCategoryBottomSheet(BuildContext context, WidgetRef ref) {
  job_sheets.showJobCategoryBottomSheet(context, ref);
}

void showJobTypeBottomSheet(BuildContext context, WidgetRef ref) {
  job_sheets.showJobTypeBottomSheet(context, ref);
}