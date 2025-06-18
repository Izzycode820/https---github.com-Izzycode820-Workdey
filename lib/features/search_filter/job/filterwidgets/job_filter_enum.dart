enum JobType {
  internship('Internship'),
  professional('Professional'),
  volunteer('Volunteer'),
  local('Local');

  final String displayName;
  const JobType(this.displayName);
}

//impl later (modify generic, job/worker searchbar )
enum JobNature {
  fullTime('Full-time'),
  partTime('Part-time'),
  contract('Contract'),
  internship('Internship');

  final String displayName;
  const JobNature(this.displayName);
}

enum JobCategory {
  it('IT'),
  healthcare('Healthcare'),
  construction('Construction'),
  education('Education');

  final String displayName;
  const JobCategory(this.displayName);
}