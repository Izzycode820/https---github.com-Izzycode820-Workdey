// lib/features/profile/forms/skills_form.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/profile/skills/skill_model.dart';
import 'package:workdey_frontend/core/providers/profile_provider.dart';

class EnhancedSkillsForm extends ConsumerStatefulWidget {
  final Skill? initialData;
  final bool isEdit;

  const EnhancedSkillsForm({
    super.key,
    this.initialData,
    this.isEdit = false,
  });

  @override
  ConsumerState<EnhancedSkillsForm> createState() => _EnhancedSkillsFormState();
}

class _EnhancedSkillsFormState extends ConsumerState<EnhancedSkillsForm> {
  final _formKey = GlobalKey<FormState>();
  final _skillController = TextEditingController();
  
  String _selectedProficiency = 'beginner';
  bool _willingToLearn = false;
  bool _isLoading = false;

  final List<String> _proficiencyLevels = [
    'beginner',
    'intermediate',
    'advanced',
  ];

  final List<String> _commonSkills = [
    // Technical Skills
    'JavaScript', 'Python', 'Java', 'React', 'Flutter', 'Node.js',
    'HTML/CSS', 'SQL', 'Git', 'AWS', 'Docker',
    
    // Construction Skills
    'Carpentry', 'Plumbing', 'Electrical Work', 'Masonry', 'Painting',
    'Roofing', 'Welding', 'HVAC', 'Tile Installation',
    
    // Healthcare Skills
    'Patient Care', 'First Aid', 'CPR', 'Medical Records', 'Laboratory Skills',
    'Pharmacy', 'Nursing', 'Physical Therapy',
    
    // General Skills
    'Project Management', 'Leadership', 'Communication', 'Customer Service',
    'Data Analysis', 'Marketing', 'Sales', 'Accounting', 'Teaching',
    'Graphic Design', 'Photography', 'Video Editing', 'Writing',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _populateFields(widget.initialData!);
    }
  }

  void _populateFields(Skill skill) {
    _skillController.text = skill.name;
    _selectedProficiency = skill.proficiency;
    _willingToLearn = skill.isWillingToLearn ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Edit Skill' : 'Add Skill'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF181A1F),
        elevation: 0,
        actions: [
          if (widget.isEdit && widget.initialData != null)
            TextButton(
              onPressed: _showDeleteDialog,
              child: Text(
                'Delete',
                style: TextStyle(
                  color: Colors.red[600],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF3E8728)))
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Skill Name Section
                          _buildSection(
                            title: 'Skill',
                            subtitle: 'What skill would you like to add?',
                            child: Column(
                              children: [
                                _buildSkillInput(),
                                if (_skillController.text.isNotEmpty)
                                  _buildSuggestions(),
                              ],
                            ),
                          ),
                          
                          // Proficiency Level Section
                          _buildSection(
                            title: 'Proficiency Level',
                            subtitle: 'How would you rate your skill level?',
                            child: _buildProficiencySelector(),
                          ),
                          
                          // Learning Attitude Section
                          _buildSection(
                            title: 'Learning Mindset',
                            subtitle: 'Show employers you\'re open to growth',
                            child: _buildLearningToggle(),
                          ),
                          
                          // Tips Section
                          _buildTipsSection(),
                          
                          const SizedBox(height: 100), // Space for bottom bar
                        ],
                      ),
                    ),
                  ),
                ),
                _buildBottomActions(),
              ],
            ),
    );
  }

  Widget _buildSection({
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 1),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF181A1F),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }

  Widget _buildSkillInput() {
    final filteredSkills = _commonSkills
        .where((skill) => skill.toLowerCase().contains(_skillController.text.toLowerCase()))
        .take(5)
        .toList();

    return TextFormField(
      controller: _skillController,
      validator: (value) => value?.isEmpty ?? true ? 'Skill name is required' : null,
      onChanged: (value) => setState(() {}),
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: 'e.g. JavaScript, Plumbing, Photography',
        hintStyle: TextStyle(color: Colors.grey[500]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF3E8728), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  Widget _buildSuggestions() {
    final filteredSkills = _commonSkills
        .where((skill) => skill.toLowerCase().contains(_skillController.text.toLowerCase()))
        .take(5)
        .toList();

    if (filteredSkills.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Suggestions',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: filteredSkills.map((skill) {
              return GestureDetector(
                onTap: () {
                  _skillController.text = skill;
                  setState(() {});
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3E8728).withOpacity(0.08),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFF3E8728).withOpacity(0.2),
                    ),
                  ),
                  child: Text(
                    skill,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF3E8728),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildProficiencySelector() {
    return Column(
      children: _proficiencyLevels.map((level) {
        final isSelected = _selectedProficiency == level;
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: () => setState(() => _selectedProficiency = level),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF3E8728).withOpacity(0.08) : Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected ? const Color(0xFF3E8728) : Colors.grey[300]!,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? const Color(0xFF3E8728) : Colors.transparent,
                      border: Border.all(
                        color: isSelected ? const Color(0xFF3E8728) : Colors.grey[400]!,
                        width: 2,
                      ),
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, size: 12, color: Colors.white)
                        : null,
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    _getProficiencyIcon(level),
                    color: isSelected ? const Color(0xFF3E8728) : Colors.grey[600],
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getProficiencyTitle(level),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? const Color(0xFF3E8728) : const Color(0xFF181A1F),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _getProficiencyDescription(level),
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLearningToggle() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF3E8728).withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              Icons.school_outlined,
              color: const Color(0xFF3E8728),
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Willing to Learn',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF181A1F),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Show that you\'re open to improving this skill',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: _willingToLearn,
            onChanged: (value) => setState(() => _willingToLearn = value),
            activeColor: const Color(0xFF3E8728),
          ),
        ],
      ),
    );
  }

  Widget _buildTipsSection() {
    return Container(
      width: double.infinity,
      color: Colors.blue[50],
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline, size: 18, color: Colors.blue[700]),
              const SizedBox(width: 8),
              Text(
                'Tips for Better Skills',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildTip('Be specific (e.g., "React.js" instead of "Programming")'),
          _buildTip('Include both technical and soft skills'),
          _buildTip('Be honest about your proficiency level'),
          _buildTip('Add skills that employers are looking for'),
        ],
      ),
    );
  }

  Widget _buildTip(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.blue[600],
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue[700],
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: BorderSide(color: Colors.grey[400]!),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF181A1F),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3E8728),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        widget.isEdit ? 'Update Skill' : 'Add Skill',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper methods
  String _getProficiencyTitle(String level) {
    switch (level) {
      case 'beginner':
        return 'Beginner';
      case 'intermediate':
        return 'Intermediate';
      case 'advanced':
        return 'Advanced';
      default:
        return level;
    }
  }

  String _getProficiencyDescription(String level) {
    switch (level) {
      case 'beginner':
        return 'Basic understanding, still learning';
      case 'intermediate':
        return 'Good knowledge, can work independently';
      case 'advanced':
        return 'Expert level, can teach others';
      default:
        return '';
    }
  }

  IconData _getProficiencyIcon(String level) {
    switch (level) {
      case 'beginner':
        return Icons.play_circle_outline;
      case 'intermediate':
        return Icons.trending_up;
      case 'advanced':
        return Icons.star;
      default:
        return Icons.help_outline;
    }
  }

  // Form submission
  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final skillData = {
        'name': _skillController.text.trim(),
        'proficiency': _selectedProficiency,
        'is_willing_to_learn': _willingToLearn,
      };

      if (widget.isEdit && widget.initialData != null) {
        await ref.read(skillsProvider.notifier).updateSkill(
          widget.initialData!.id!,
          skillData,
        );
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('✅ Skill updated successfully'),
              backgroundColor: Color(0xFF3E8728),
            ),
          );
        }
      } else {
        await ref.read(skillsProvider.notifier).addSkill(skillData);
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('✅ Skill added successfully'),
              backgroundColor: Color(0xFF3E8728),
            ),
          );
        }
      }

      ref.read(profileProvider.notifier).refresh();
      
      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Error: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _showDeleteDialog() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Skill'),
        content: Text('Are you sure you want to delete "${widget.initialData?.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && widget.initialData?.id != null) {
      setState(() => _isLoading = true);
      try {
        await ref.read(skillsProvider.notifier).deleteSkill(widget.initialData!.id);
        ref.read(profileProvider.notifier).refresh();
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('✅ Skill deleted successfully'),
              backgroundColor: Color(0xFF3E8728),
            ),
          );
          Navigator.pop(context, true);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('❌ Error deleting skill: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  void dispose() {
    _skillController.dispose();
    super.dispose();
  }
}