// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/profile/education/education_model.dart';
import 'package:workdey_frontend/core/models/profile/experience/experience_model.dart';
import 'package:workdey_frontend/core/models/profile/profile_model.dart';
import 'package:workdey_frontend/core/models/profile/skills/skill_model.dart';
import 'package:workdey_frontend/core/models/trustscore/trust_score_model.dart';
import 'package:workdey_frontend/core/providers/profile_provider.dart';
import 'package:workdey_frontend/core/routes/routes.dart';
import 'package:workdey_frontend/features/profile/section_widget/about_section.dart';
import 'package:workdey_frontend/features/profile/section_widget/education_section.dart';
import 'package:workdey_frontend/features/profile/section_widget/experience_section.dart';
import 'package:workdey_frontend/features/profile/section_widget/profile_completion_card.dart';
import 'package:workdey_frontend/features/profile/section_widget/profile_header.dart';
import 'package:workdey_frontend/features/profile/section_widget/profile_trust_section.dart';
import 'package:workdey_frontend/features/profile/section_widget/review_section.dart';
import 'package:workdey_frontend/features/profile/section_widget/skills_section.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  final int? userId; // null for current user, id for public profile
  
  const ProfileScreen({super.key, this.userId});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final isOwnProfile = widget.userId == null;
    final profileAsyncValue = isOwnProfile 
        ? ref.watch(profileProvider)
        : ref.watch(publicProfileProvider(widget.userId!));

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0.5,
        surfaceTintColor: Colors.white,
        actions: [
          if (isOwnProfile)
            IconButton(
              icon: const Icon(Icons.settings_outlined, size: 20),
              onPressed: () => _navigateToSettings(context),
            )
          else
            IconButton(
              icon: const Icon(Icons.message_outlined, size: 20),
              onPressed: () => _initiateContact(context, profileAsyncValue.value),
            ),
        ],
      ),
      body: profileAsyncValue.when(
        data: (profile) => _buildProfileContent(context, profile, isOwnProfile),
        loading: () => _buildLoadingState(),
        error: (error, stack) => _buildErrorState(error.toString()),
      ),
      floatingActionButton: isOwnProfile ? _buildEditFAB() : null,
    );
  }

  Widget _buildProfileContent(BuildContext context, UserProfile profile, bool isOwnProfile) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Compact Profile Header
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main Profile Info Row
                Row(
                  children: [
                    // Profile Picture
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey[300]!, width: 1),
                      ),
                      child: CircleAvatar(
                        radius: 32,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: profile.user.profilePicture != null
                            ? NetworkImage(profile.user.profilePicture!)
                            : null,
                        child: profile.user.profilePicture == null
                            ? Text(
                                (profile.user.firstName?[0] ?? 'U').toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              )
                            : null,
                      ),
                    ),
                    
                    const SizedBox(width: 16),
                    
                    // Name and Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  profile.fullName,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              // Trust Badge
                              if (profile.trustScore != null)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _getTrustLevelColor(profile.trustScore!.trustLevel).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: _getTrustLevelColor(profile.trustScore!.trustLevel).withOpacity(0.3),
                                    ),
                                  ),
                                  child: Text(
                                    profile.trustScore!.trustLevelEmoji,
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          
                          // Professional Summary
                          if (profile.professionalSummary.isNotEmpty)
                            Text(
                              profile.professionalSummary,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          
                          const SizedBox(height: 6),
                          
                          // Location and Availability
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 12, color: Colors.grey[500]),
                              const SizedBox(width: 2),
                              Text(
                                profile.displayLocation,
                                style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                              ),
                              const SizedBox(width: 12),
                              Icon(Icons.schedule, size: 12, color: Colors.grey[500]),
                              const SizedBox(width: 2),
                              Expanded(
                                child: Text(
                                  profile.availabilityDisplay,
                                  style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Stats Row (Like Applicants Page - No Card Wrapping)
                Row(
                  children: [
                    _buildStatItem(
                      icon: Icons.work_outline,
                      label: 'Jobs',
                      value: profile.jobsCompleted.toString(),
                    ),
                    const SizedBox(width: 24),
                    _buildStatItem(
                      icon: Icons.star_outline,
                      label: 'Rating',
                      value: profile.rating > 0 ? profile.rating.toStringAsFixed(1) : '0.0',
                    ),
                    const SizedBox(width: 24),
                    _buildStatItem(
                      icon: Icons.rate_review_outlined,
                      label: 'Reviews',
                      value: profile.reviews.length.toString(),
                    ),
                    if (profile.trustScore != null) ...[
                      const SizedBox(width: 24),
                      _buildStatItem(
                        icon: Icons.verified_user_outlined,
                        label: 'Trust',
                        value: profile.trustScore!.overallScore.toStringAsFixed(1),
                      ),
                    ],
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Action Buttons
                Row(
                  children: [
                    if (isOwnProfile)
                      Expanded(
                        child: _buildActionButton(
                          label: 'Edit Profile',
                          icon: Icons.edit_outlined,
                          onPressed: () => _editProfile(context),
                          isPrimary: true,
                        ),
                      )
                    else ...[
                      Expanded(
                        child: _buildActionButton(
                          label: 'Message',
                          icon: Icons.message_outlined,
                          onPressed: () => _initiateContact(context, profile),
                          isPrimary: true,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildActionButton(
                          label: 'Save',
                          icon: Icons.bookmark_border,
                          onPressed: () {
                            // Implement save profile
                          },
                          isPrimary: false,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Profile Completion Card (only for own profile - subtle)
          if (isOwnProfile && !profile.isProfileComplete)
            ProfileCompletionCard(profile: profile),

          const SizedBox(height: 8),

          // Trust Score Section
          ProfileTrustSection(
          trustScore: profile.trustScore ?? _createDefaultTrustScore(),
          isOwnProfile: isOwnProfile,
        ),

          const SizedBox(height: 8),

          // About Section
          ProfileAboutSection(
            profile: profile,
            isOwnProfile: isOwnProfile,
            onEdit: isOwnProfile ? () => _editAbout(context, profile) : null,
          ),

          const SizedBox(height: 8),

          // Skills Section
          ProfileSkillsSection(
            skills: profile.skills,
            isOwnProfile: isOwnProfile,
            onAdd: isOwnProfile ? () => _addSkill(context) : null,
            onEdit: isOwnProfile ? (skill) => _editSkill(context, skill) : null,
          ),

          const SizedBox(height: 8),

          // Experience Section
          ProfileExperienceSection(
            experiences: profile.experiences,
            isOwnProfile: isOwnProfile,
            onAdd: isOwnProfile ? () => _addExperience(context) : null,
            onEdit: isOwnProfile ? (exp) => _editExperience(context, exp) : null,
          ),

          const SizedBox(height: 8),

          // Education Section
          ProfileEducationSection(
            educations: profile.educations,
            isOwnProfile: isOwnProfile,
            onAdd: isOwnProfile ? () => _addEducation(context) : null,
            onEdit: isOwnProfile ? (edu) => _editEducation(context, edu) : null,
          ),

          const SizedBox(height: 8),

          // Reviews Section
          ProfileReviewsSection(
                reviews: profile.reviews,
                isOwnProfile: isOwnProfile,
              ),

          const SizedBox(height: 100), // Bottom padding for FAB
        ],
      ),
    );
  }

  // Stat Item Builder (Like Applicants Page)
  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF3E8728),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required VoidCallback? onPressed,
    required bool isPrimary,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 14),
      label: Text(
        label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? const Color(0xFF3E8728) : Colors.white,
        foregroundColor: isPrimary ? Colors.white : Colors.grey[700],
        side: isPrimary ? null : BorderSide(color: Colors.grey[300]!),
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Color(0xFF3E8728),
            strokeWidth: 2,
          ),
          SizedBox(height: 12),
          Text(
            'Loading profile...',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.red[300]),
            const SizedBox(height: 12),
            Text(
              'Unable to load profile',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 6),
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                if (widget.userId == null) {
                  ref.read(profileProvider.notifier).refresh();
                } else {
                  ref.read(publicProfileProvider(widget.userId!).notifier).refresh();
                }
              },
              icon: const Icon(Icons.refresh, size: 16),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3E8728),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditFAB() {
    return FloatingActionButton(
      onPressed: () => _showQuickActions(context),
      backgroundColor: const Color(0xFF3E8728),
      mini: true,
      child: const Icon(Icons.edit, color: Colors.white, size: 20),
    );
  }

  // Helper method to get trust level color
  Color _getTrustLevelColor(String trustLevel) {
    switch (trustLevel.toUpperCase()) {
      case 'NEWCOMER':
        return Colors.orange;
      case 'BUILDING':
        return Colors.blue;
      case 'TRUSTED':
        return Colors.green;
      case 'EXPERT':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  // ========== NAVIGATION METHODS ==========

  void _navigateToSettings(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.settings);
  }

  void _editProfile(BuildContext context) async {
    final profile = ref.read(profileProvider).value;
    if (profile != null) {
      final result = await Navigator.pushNamed(
        context, 
        AppRoutes.editProfile, 
        arguments: profile,
      );
      
      if (result == true) {
        ref.read(profileProvider.notifier).refresh();
      }
    }
  }

  void _editAbout(BuildContext context, UserProfile profile) async {
    final result = await Navigator.pushNamed(
      context, 
      AppRoutes.editAbout, 
      arguments: profile,
    );
    
    if (result == true) {
      ref.read(profileProvider.notifier).refresh();
    }
  }

  void _addExperience(BuildContext context) async {
    final result = await Navigator.pushNamed(context, AppRoutes.addExperience);
    
    if (result == true) {
      ref.read(profileProvider.notifier).refresh();
    }
  }

  void _editExperience(BuildContext context, Experience experience) async {
    final result = await Navigator.pushNamed(
      context, 
      AppRoutes.editExperience, 
      arguments: experience,
    );
    
    if (result == true) {
      ref.read(profileProvider.notifier).refresh();
    }
  }

  void _addEducation(BuildContext context) async {
    final result = await Navigator.pushNamed(context, AppRoutes.addEducation);
    
    if (result == true) {
      ref.read(profileProvider.notifier).refresh();
    }
  }

  void _editEducation(BuildContext context, Education education) async {
    final result = await Navigator.pushNamed(
      context, 
      AppRoutes.editEducation, 
      arguments: education,
    );
    
    if (result == true) {
      ref.read(profileProvider.notifier).refresh();
    }
  }

  void _addSkill(BuildContext context) async {
    final result = await Navigator.pushNamed(context, AppRoutes.addSkill);
    
    if (result == true) {
      ref.read(profileProvider.notifier).refresh();
    }
  }

  void _editSkill(BuildContext context, Skill skill) async {
    final result = await Navigator.pushNamed(
      context, 
      AppRoutes.editSkill, 
      arguments: skill,
    );
    
    if (result == true) {
      ref.read(profileProvider.notifier).refresh();
    }
  }

  void _initiateContact(BuildContext context, UserProfile? profile) {
    if (profile == null) return;
    showModalBottomSheet(
      context: context,
      builder: (context) => _buildContactBottomSheet(profile),
    );
  }

  void _showQuickActions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _buildQuickActionsBottomSheet(),
    );
  }

  Widget _buildContactBottomSheet(UserProfile profile) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact ${profile.fullName}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          ListTile(
            leading: const Icon(Icons.message, size: 20),
            title: const Text('Send Message', style: TextStyle(fontSize: 14)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoutes.messages);
            },
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsBottomSheet() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          ListTile(
            leading: const Icon(Icons.edit, size: 20),
            title: const Text('Edit Profile', style: TextStyle(fontSize: 14)),
            onTap: () {
              Navigator.pop(context);
              _editProfile(context);
            },
            contentPadding: EdgeInsets.zero,
          ),
          ListTile(
            leading: const Icon(Icons.star, size: 20),
            title: const Text('Add Skill', style: TextStyle(fontSize: 14)),
            onTap: () {
              Navigator.pop(context);
              _addSkill(context);
            },
            contentPadding: EdgeInsets.zero,
          ),
          ListTile(
            leading: const Icon(Icons.work, size: 20),
            title: const Text('Add Experience', style: TextStyle(fontSize: 14)),
            onTap: () {
              Navigator.pop(context);
              _addExperience(context);
            },
            contentPadding: EdgeInsets.zero,
          ),
          ListTile(
            leading: const Icon(Icons.school, size: 20),
            title: const Text('Add Education', style: TextStyle(fontSize: 14)),
            onTap: () {
              Navigator.pop(context);
              _addEducation(context);
            },
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  TrustScore _createDefaultTrustScore() {
  return TrustScore(
    overallScore: 0.0,
    trustLevel: 'NEWCOMER',
    trustLevelDisplay: 'Newcomer',
   // trustLevelEmoji: '🌱',
    completedJobs: 0,
    totalReviews: 0,
    completedServices: 0,
    jobPerformanceScore: 0.0,
    serviceQualityScore: 0.0,
    reliabilityScore: 0.0,
    employerSatisfactionScore: 0.0,
  );
}
}

