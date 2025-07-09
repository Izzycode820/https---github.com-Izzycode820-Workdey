class AppRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String messages = '/messages';
  static const String workers = '/workers';
  static const String savedJobs = '/saved-jobs';
  static const String profile = '/profile';
  static const String findJobs = '/find-jobs';
  static const String postJobs = '/post-jobs';
  static const String postWorker = '/post-worker';
  static const String settings = '/settings';
  static const String myApplication = '/my-application';
  static const String applicants = '/applicants/:jobId';
  static const String apply = '/apply/:jobId';

  // Profile Management Routes
  static const String editProfile = '/profile/edit';
  static const String editAbout = '/profile/edit/about';
  
  // Skills Routes
  static const String addSkill = '/profile/skills/add';
  static const String editSkill = '/profile/skills/edit';
  
  // Experience Routes
  static const String addExperience = '/profile/experience/add';
  static const String editExperience = '/profile/experience/edit';
  
  // Education Routes
  static const String addEducation = '/profile/education/add';
  static const String editEducation = '/profile/education/edit';
  static const String reviews = '/reviews';
}