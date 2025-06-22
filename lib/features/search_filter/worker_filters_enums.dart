// Define your worker-specific filter options
enum WorkerCategory {
  it('Information Technology'),
  health('Healthcare'),
  finance('Finance'),
  construction('Construction'),
  education('Education'),
  design('Design'),
  other('Other');

  final String displayName;
  const WorkerCategory(this.displayName);
}

enum WorkerAvailability {
  ft('Full-time'),
  pt('Part-time'),
  cn('Contract'),
  fl('Freelance');

  final String displayName;
  const WorkerAvailability(this.displayName);

  String get apiValue => name.toUpperCase(); // Converts to 'FT', 'PT' etc
}

/* // job_filter_enum.dart
enum JobType {
  pro('Professional'),
  int('Internship'),
  vol('Volunteer'),
  loc('Local');

  final String displayName;
  const JobType(this.displayName);

  String get apiValue => name.toUpperCase(); // 'PRO', 'INT' etc
}
*/

// enum JobNature {
//   freelance('Freelance'),
//   fullTime('Full-time'),
//   partTime('Part-time'),
//   contract('Contract');

//   final String displayName;
//   const JobNature(this.displayName);
// }


List<Map<String, dynamic>> workerFilterOptions = [
  {
    'type': 'category',
    'title': 'Category',
    'options': WorkerCategory.values,
  },
];