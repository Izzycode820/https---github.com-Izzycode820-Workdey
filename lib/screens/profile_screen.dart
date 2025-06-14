import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/profile/profile_model.dart';
import 'package:workdey_frontend/core/providers/profile_provider.dart';
import 'package:workdey_frontend/features/profile/education_section.dart';
import 'package:workdey_frontend/features/profile/experience_section.dart';
import 'package:workdey_frontend/features/profile/profile_header.dart';
import 'package:workdey_frontend/features/profile/skills_section.dart';


class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);

    return Scaffold(
      body: profileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: ${e.toString()}')),
        data: (profile) => _buildProfileContent(profile),
      ),
    );
  }

  Widget _buildProfileContent(UserProfile profile) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProfileHeader(profile: profile),
          SkillsSection(skills: profile.skills),
          ExperienceSection(experiences: profile.experiences),
          EducationSection(educations: profile.educations),
        ],
      ),
    );
  }
}