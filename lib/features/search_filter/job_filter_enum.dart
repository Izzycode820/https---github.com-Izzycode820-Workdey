enum JobType {
  internship('INT'),
  professional('PRO'),
  volunteer('VOL'),
  local('LOC');

  final String displayName;
  const JobType(this.displayName);
}

//impl later (modify generic, job/worker searchbar )
enum JobNature {
  fullTime('Full-time'),
  partTime('Part-time'),
  contract('Contract'),
  internship('Internship'),
  errand('Errand'),
  community('Community');

  final String displayName;
  const JobNature(this.displayName);
}

enum JobCategory {
  it('IT'),
  healthcare('Healthcare'),
  construction('Construction'),
  education('Education'),
  design('Design'),
  finance('Finance'),
  other('Other');

  final String displayName;
  const JobCategory(this.displayName);
}

enum WorkingDays {
  monday('Monday'),
  tuesday('Tuesday'),
  wednesday('Wednesday'),
  thursday('Thursday'),
  friday('Friday'),
  saturday('Saturday'),
  sunday('Sunday');

  final String displayName;
  const WorkingDays(this.displayName);

  String get paramValue => displayName;
}
