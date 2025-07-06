// lib/features/profile/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/profile/profile_model.dart';
import 'package:workdey_frontend/core/providers/profile_provider.dart';
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

class _ProfileScreenState extends ConsumerState<ProfileScreen> 
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _animationController;
  late Animation<double> _headerAnimation;
  
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _headerAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final scrolled = _scrollController.offset > 100;
    if (scrolled != _isScrolled) {
      setState(() => _isScrolled = scrolled);
      if (scrolled) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isOwnProfile = widget.userId == null;
    final profileAsyncValue = isOwnProfile 
        ? ref.watch(profileProvider)
        : ref.watch(publicProfileProvider(widget.userId!));

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: profileAsyncValue.when(
        data: (profile) => _buildProfileContent(context, profile, isOwnProfile),
        loading: () => _buildLoadingState(),
        error: (error, stack) => _buildErrorState(error.toString()),
      ),
      floatingActionButton: isOwnProfile ? _buildEditFAB() : null,
    );
  }

  Widget _buildProfileContent(BuildContext context, UserProfile profile, bool isOwnProfile) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        // Animated App Bar
        SliverAppBar(
          expandedHeight: 0,
          floating: true,
          pinned: true,
          elevation: _isScrolled ? 1 : 0,
          backgroundColor: _isScrolled ? Colors.white : Colors.transparent,
          foregroundColor: _isScrolled ? Colors.black87 : Colors.white,
          title: AnimatedBuilder(
            animation: _headerAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: _headerAnimation.value,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: profile.user.profilePicture != null
                          ? NetworkImage(profile.user.profilePicture!)
                          : null,
                      child: profile.user.profilePicture == null
                          ? Text(profile.user.firstName![0])
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            profile.fullName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (profile.trustScore != null)
                            Text(
                              profile.trustScore!.trustLevelDisplay,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          actions: [
            if (isOwnProfile)
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () => _navigateToSettings(context),
              )
            else
              IconButton(
                icon: const Icon(Icons.message),
                onPressed: () => _initiateContact(context, profile),
              ),
          ],
        ),

        // Profile Content
        SliverToBoxAdapter(
          child: Column(
            children: [
              // Profile Header
              ProfileHeader(
                profile: profile,
                isOwnProfile: isOwnProfile,
                onEditPressed: isOwnProfile ? () => _editProfile(context) : null,
                onContactPressed: !isOwnProfile ? () => _initiateContact(context, profile) : null,
              ),
              
              const SizedBox(height: 16),

              // Profile Completion Card (only for own profile)
              if (isOwnProfile && !profile.isProfileComplete)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ProfileCompletionCard(profile: profile),
                ),

              const SizedBox(height: 16),

              // Trust Score Section
              if (profile.trustScore != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ProfileTrustSection(
                    trustScore: profile.trustScore!,
                    isOwnProfile: isOwnProfile,
                  ),
                ),

              const SizedBox(height: 16),

              // About Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ProfileAboutSection(
                  profile: profile,
                  isOwnProfile: isOwnProfile,
                  onEdit: isOwnProfile ? () => _editAbout(context, profile) : null,
                ),
              ),

              const SizedBox(height: 16),

              // Experience Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ProfileExperienceSection(
                  experiences: profile.experiences,
                  isOwnProfile: isOwnProfile,
                  onAdd: isOwnProfile ? () => _addExperience(context) : null,
                  onEdit: isOwnProfile ? (exp) => _editExperience(context, exp) : null,
                ),
              ),

              const SizedBox(height: 16),

              // Education Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ProfileEducationSection(
                  educations: profile.educations,
                  isOwnProfile: isOwnProfile,
                  onAdd: isOwnProfile ? () => _addEducation(context) : null,
                  onEdit: isOwnProfile ? (edu) => _editEducation(context, edu) : null,
                ),
              ),

              const SizedBox(height: 16),

              // Skills Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ProfileSkillsSection(
                  skills: profile.skills,
                  isOwnProfile: isOwnProfile,
                  onAdd: isOwnProfile ? () => _addSkill(context) : null,
                  onEdit: isOwnProfile ? (skill) => _editSkill(context, skill) : null,
                ),
              ),

              const SizedBox(height: 16),

              // Reviews Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ProfileReviewsSection(
                  reviews: profile.reviews,
                  reviewSummary: profile.reviewSummary,
                  isOwnProfile: isOwnProfile,
                ),
              ),

              const SizedBox(height: 100), // Bottom padding for FAB
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Color(0xFF3E8728),
            ),
            SizedBox(height: 16),
            Text(
              'Loading profile...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red[300],
              ),
              const SizedBox(height: 16),
              Text(
                'Unable to load profile',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                error,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  if (widget.userId == null) {
                    ref.read(profileProvider.notifier).refresh();
                  } else {
                    ref.read(publicProfileProvider(widget.userId!).notifier).refresh();
                  }
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3E8728),
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditFAB() {
    return FloatingActionButton(
      onPressed: () => _showQuickActions(context),
      backgroundColor: const Color(0xFF3E8728),
      child: const Icon(Icons.edit, color: Colors.white),
    );
  }

  // ========== NAVIGATION METHODS ==========

  void _navigateToSettings(BuildContext context) {
    Navigator.pushNamed(context, '/settings');
  }

  void _editProfile(BuildContext context) {
    Navigator.pushNamed(context, '/profile/edit');
  }

  void _editAbout(BuildContext context, UserProfile profile) {
    Navigator.pushNamed(context, '/profile/edit/about', arguments: profile);
  }

  void _addExperience(BuildContext context) {
    Navigator.pushNamed(context, '/profile/experience/add');
  }

  void _editExperience(BuildContext context, dynamic experience) {
    Navigator.pushNamed(context, '/profile/experience/edit', arguments: experience);
  }

  void _addEducation(BuildContext context) {
    Navigator.pushNamed(context, '/profile/education/add');
  }

  void _editEducation(BuildContext context, dynamic education) {
    Navigator.pushNamed(context, '/profile/education/edit', arguments: education);
  }

  void _addSkill(BuildContext context) {
    Navigator.pushNamed(context, '/profile/skills/add');
  }

  void _editSkill(BuildContext context, dynamic skill) {
    Navigator.pushNamed(context, '/profile/skills/edit', arguments: skill);
  }

  void _initiateContact(BuildContext context, UserProfile profile) {
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

  // ========== BOTTOM SHEETS ==========

  Widget _buildContactBottomSheet(UserProfile profile) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact ${profile.user.firstName}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          
          ListTile(
            leading: const Icon(Icons.message, color: Color(0xFF3E8728)),
            title: const Text('Send Message'),
            subtitle: const Text('Start a conversation'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to chat
            },
          ),
          
          if (profile.showContactInfo == true)
            ListTile(
              leading: const Icon(Icons.phone, color: Color(0xFF3E8728)),
              title: const Text('Call'),
              subtitle: Text(profile.user.phone ?? 'No phone number'),
              onTap: profile.user.phone != null ? () {
                Navigator.pop(context);
                // Initiate call
              } : null,
            ),
          
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildQuickActionsBottomSheet() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          
          ListTile(
            leading: const Icon(Icons.person_outline, color: Color(0xFF3E8728)),
            title: const Text('Edit Basic Info'),
            onTap: () {
              Navigator.pop(context);
              _editProfile(context);
            },
          ),
          
          ListTile(
            leading: const Icon(Icons.camera_alt_outlined, color: Color(0xFF3E8728)),
            title: const Text('Change Photo'),
            onTap: () {
              Navigator.pop(context);
              _changeProfilePhoto();
            },
          ),
          
          ListTile(
            leading: const Icon(Icons.work_outline, color: Color(0xFF3E8728)),
            title: const Text('Add Experience'),
            onTap: () {
              Navigator.pop(context);
              _addExperience(context);
            },
          ),
          
          ListTile(
            leading: const Icon(Icons.school_outlined, color: Color(0xFF3E8728)),
            title: const Text('Add Education'),
            onTap: () {
              Navigator.pop(context);
              _addEducation(context);
            },
          ),
          
          ListTile(
            leading: const Icon(Icons.star_outline, color: Color(0xFF3E8728)),
            title: const Text('Add Skill'),
            onTap: () {
              Navigator.pop(context);
              _addSkill(context);
            },
          ),
          
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // ========== HELPER METHODS ==========

  void _changeProfilePhoto() {
    // Implement photo picker
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Take Photo'),
            onTap: () {
              Navigator.pop(context);
              // Implement camera capture
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Choose from Gallery'),
            onTap: () {
              Navigator.pop(context);
              // Implement gallery picker
            },
          ),
        ],
      ),
    );
  }
}