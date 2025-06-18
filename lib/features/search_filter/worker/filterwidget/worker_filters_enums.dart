// Define your worker-specific filter options
enum WorkerCategory {
  electrician('Electrician'),
  plumber('Plumber'),
  carpenter('Carpenter');

  final String displayName;
  const WorkerCategory(this.displayName);
}

List<Map<String, dynamic>> workerFilterOptions = [
  {
    'type': 'category',
    'title': 'Category',
    'options': WorkerCategory.values,
  },
];