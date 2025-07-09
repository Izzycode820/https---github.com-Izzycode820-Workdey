import 'package:flutter/material.dart';
import 'package:workdey_frontend/app.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';
import 'package:workdey_frontend/core/models/profile/education/education_model.dart';
import 'package:workdey_frontend/core/models/profile/experience/experience_model.dart';
import 'package:workdey_frontend/core/models/profile/profile_model.dart';
import 'package:workdey_frontend/core/models/profile/skills/skill_model.dart';
import 'package:workdey_frontend/core/routes/routes.dart';
import 'package:workdey_frontend/features/application/application_form_screen.dart';
import 'package:workdey_frontend/features/profile/forms/edit_profile_screen.dart';
import 'package:workdey_frontend/features/profile/forms/education_form.dart';
import 'package:workdey_frontend/features/profile/forms/experience_form.dart';
import 'package:workdey_frontend/features/profile/forms/skills_form.dart';
import 'package:workdey_frontend/screens/applicants_screen.dart';
import 'package:workdey_frontend/screens/findjob_home_screen.dart';
import 'package:workdey_frontend/screens/login_screen.dart';
import 'package:workdey_frontend/screens/messaging_screen.dart';
import 'package:workdey_frontend/screens/my_applicant_screen.dart';
import 'package:workdey_frontend/screens/post_woker_screen.dart';
import 'package:workdey_frontend/screens/postjob_home_screen.dart';
import 'package:workdey_frontend/screens/profile_screen.dart';
import 'package:workdey_frontend/screens/reviews_screen.dart';
import 'package:workdey_frontend/screens/saves_screen.dart';
import 'package:workdey_frontend/screens/settings_screen.dart';
import 'package:workdey_frontend/screens/signup_screen.dart';
import 'package:workdey_frontend/screens/workers_screen.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {

return MaterialPageRoute(
      builder: (context) {
        // Set the search context before building the widget

return switch (settings.name) {
       AppRoutes.findJobs => const EnhancedHomeScreen(),
       AppRoutes.postJobs => const UpdatedPostedJobsScreen(),
       AppRoutes.postWorker => const PostedWorkersScreen(),
       AppRoutes.login => const LoginScreen(),
       AppRoutes.signup => const SignupScreen(),
       AppRoutes.home => const MainApp(),
       AppRoutes.messages => const MessagesScreen(),
       AppRoutes.workers => const WorkersScreen(),
       AppRoutes.savedJobs => const SavedJobsPage(),
       AppRoutes.profile => const ProfileScreen(),
       AppRoutes.settings => const SettingsScreen(),
       AppRoutes.myApplication => const MyApplicationsScreen(),
       AppRoutes.reviews => const ReviewsScreen(),
       AppRoutes.applicants => ApplicantsScreen(jobId: settings.arguments as int,),
       AppRoutes.apply => ApplicationFormScreen(job: settings.arguments as Job,),

       // Profile Management Routes
          AppRoutes.editProfile => EditProfileForm(
            profile: settings.arguments as UserProfile,
          ),
          AppRoutes.editAbout => EditProfileForm(
            profile: settings.arguments as UserProfile,
          ),
          
          // Skills Routes
          AppRoutes.addSkill => const EnhancedSkillsForm(isEdit: false),
          AppRoutes.editSkill => EnhancedSkillsForm(
            initialData: settings.arguments as Skill,
            isEdit: true,
          ),
          
          // Experience Routes
          AppRoutes.addExperience => const EnhancedExperienceForm(isEdit: false),
          AppRoutes.editExperience => EnhancedExperienceForm(
            initialData: settings.arguments as Experience,
            isEdit: true,
          ),
          
          // Education Routes
          AppRoutes.addEducation => const EnhancedEducationForm(isEdit: false),
          AppRoutes.editEducation => EnhancedEducationForm(
            initialData: settings.arguments as Education,
            isEdit: true,
          ),
          
          _ => const Scaffold(body: Center(child: Text('Route not found'))),
        };
      },
    );
  }

 
}