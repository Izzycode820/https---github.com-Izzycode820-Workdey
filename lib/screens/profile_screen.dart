import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/profile/education/education_model.dart';
import 'package:workdey_frontend/core/models/profile/experience/experience_model.dart';
import 'package:workdey_frontend/core/models/profile/profile_model.dart';
import 'package:workdey_frontend/core/providers/profile_provider.dart';
import 'package:workdey_frontend/core/routes/routes.dart';
import 'package:workdey_frontend/features/profile/forms/edit_profile_screen.dart';
import 'package:workdey_frontend/features/profile/forms/education_form.dart';
import 'package:workdey_frontend/features/profile/forms/experience_form.dart';
import 'package:workdey_frontend/features/profile/forms/skills_form.dart';
import 'package:workdey_frontend/features/profile/section_widget/about_section.dart';
import 'package:workdey_frontend/features/profile/section_widget/education_section.dart';
import 'package:workdey_frontend/features/profile/section_widget/experience_section.dart';
import 'package:workdey_frontend/features/profile/section_widget/profile_header.dart';
import 'package:workdey_frontend/features/profile/section_widget/review_section.dart';
import 'package:workdey_frontend/features/profile/section_widget/skills_section.dart';


class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF3F2EF),
      body: profileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: ${e.toString()}')),
        data: (profile) => _buildProfileContent(context, profile),
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, UserProfile profile) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              color: const Color(0xFF3E8728),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            ProfileHeader(
              profile: profile,
              onEditPressed: () => _showEditProfileDialog(context, profile),
              onSettingsPressed: () { Navigator.pushNamed(context, AppRoutes.settings);},
            ),
            AboutSection(profile: profile),
            ExperienceSection(
              experiences: profile.experiences,
              onAddPressed: () => _showAddExperienceDialog(context),
              onEditPressed: (exp) => _showEditExperienceDialog(context, exp),
            ),
            EducationSection(
              educations: profile.educations,
              onAddPressed: () => _showAddEducationDialog(context),
              onEditPressed: (edu) => _showEditEducationDialog(context, edu),
            ),
            
            SkillsSection(
              skills: profile.skills,
              onAddPressed: () => _showAddSkillsDialog(context),
              onDeletePressed: _deleteSkill,
            ),
            ReviewsSection(reviews: profile.reviews),
          ]),
        ),
      ],
    );
  }

  void _showEditProfileDialog(BuildContext context, UserProfile profile) {
    showDialog(
      context: context,
      builder: (context) => EditProfileForm(profile: profile),
    );
  }

  void _showAddExperienceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const ExperienceForm(),
    );
  }

  void _showEditExperienceDialog(BuildContext context, Experience exp) {
    showDialog(
      context: context,
      builder: (context) => ExperienceForm(initialData: exp),
    );
  }

  void _showAddEducationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const EducationForm(),
    );
  }

  void _showEditEducationDialog(BuildContext context, Education edu) {
    showDialog(
      context: context,
      builder: (context) => EducationForm(initialData: edu),
    );
  }

  void _showAddSkillsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const SkillsForm(),
    );
  }

  void _deleteSkill(int skillId) {
    // Implement skill deletion logic
  }
}