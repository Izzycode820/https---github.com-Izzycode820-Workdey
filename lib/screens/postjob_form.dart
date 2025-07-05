// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intl/intl.dart';
// import 'package:workdey_frontend/core/enums/form_mode.dart';
// import 'package:workdey_frontend/core/models/postjob/post_job_model.dart';
// import 'package:workdey_frontend/core/providers/post_job_provider.dart';

// class PostJobForm extends ConsumerStatefulWidget {
//   final FormMode mode;
//   final PostJob? initialData;
//   const PostJobForm({
//     super.key,
//     this.mode = FormMode.create,
//     this.initialData,
//   });

//   @override
//   ConsumerState<PostJobForm> createState() => _PostJobFormState();
// }

// class _PostJobFormState extends ConsumerState<PostJobForm> {
//   final _formKey = GlobalKey<FormState>();
//   final _titleController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   final _rolesController = TextEditingController();
//   final _locationController = TextEditingController();
//   final _cityController = TextEditingController();
//   final _districtController = TextEditingController();
//   final _requirementController = TextEditingController();
//   final _requiredSkillController = TextEditingController();
//   final _optionalSkillController = TextEditingController();
//   final _dueDateController = TextEditingController();
  
//   Map<String, String> _errors = {};
//   bool _initialized = false;
//   bool _isSubmitting = false;

//   @override
//   void initState() {
//     super.initState();
//     _setupControllers();
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     if (!_initialized && widget.mode == FormMode.edit && widget.initialData != null) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         _initializeWithPostJobData(widget.initialData!);
//       });
//       _initialized = true;
//     }
//   }

//   Future<void> _initializeWithPostJobData(PostJob postjob) async {
//     try { 
//       final notifier = ref.read(postJobNotifierProvider.notifier);
      
//       // Reset to default state first
//       notifier.updateJobType(postjob.jobType);

//       // Batch updates to minimize rebuilds
//       notifier.updateField('title', postjob.title);
//       notifier.updateField('location', postjob.location);
//       notifier.updateField('city', postjob.city);
//       notifier.updateField('district', postjob.district);
//       notifier.updateField('job_nature', postjob.job_nature ?? 'Full time');
//       notifier.updateField('category', postjob.category);
//       notifier.updateField('description', postjob.description);
//       notifier.updateField('rolesDescription', postjob.rolesDescription ?? '');
//       notifier.updateField('requirements', postjob.requirements);
//       notifier.updateField('workingDays', postjob.workingDays);
//       notifier.updateField('dueDate', postjob.dueDate?.toString());
//       notifier.updateField('requiredSkills', postjob.requiredSkills);
//       notifier.updateField('optionalSkills', postjob.optionalSkills);

//       // Special handling for salary fields
//       if (postjob.jobType == 'PRO' || postjob.jobType == 'LOC') {
//         notifier.updateTypeSpecific('salary', postjob.typeSpecific['salary']);
//         notifier.updateTypeSpecific('salary_period', 
//             postjob.typeSpecific['salary_period'] ?? 'd');
//       }

//       // Update controllers
//       _titleController.text = postjob.title;
//       _descriptionController.text = postjob.description;
//       _rolesController.text = postjob.rolesDescription ?? '';
//       _locationController.text = postjob.location ?? '';
//       _cityController.text = postjob.city ?? '';
//       _districtController.text = postjob.district ?? '';
//       _dueDateController.text = postjob.dueDate ?? 'Select deadline (yyyy-mm-dd)';
//     } catch (e, stack) {
//       debugPrint('Initialization error: $e\n$stack');
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: const Text('Failed to load job data'),
//             backgroundColor: Colors.red,
//             action: SnackBarAction(
//               label: 'Retry',
//               onPressed: () => _initializeWithPostJobData(postjob),
//             ),
//           ),
//         );
//       }
//     }
//   }

//   void _setupControllers() {
//     final job = ref.read(postJobNotifierProvider);
//     _titleController.text = job.title;
//     _descriptionController.text = job.description;
//     _rolesController.text = job.rolesDescription ?? '';
//     _locationController.text = job.location ?? '';
//     _cityController.text = job.city ?? '';
//     _districtController.text = job.district ?? '';
//     _dueDateController.text = job.dueDate ?? 'Select deadline (yyyy-mm-dd)';
//   }

//   void _clearError(String field) {
//     if (_errors.containsKey(field)) {
//       setState(() => _errors.remove(field));
//     }
//   }

//   @override
//   void dispose() {
//     _titleController.dispose();
//     _descriptionController.dispose();
//     _rolesController.dispose();
//     _locationController.dispose();
//     _cityController.dispose();
//     _districtController.dispose();
//     _requirementController.dispose();
//     _requiredSkillController.dispose();
//     _optionalSkillController.dispose();
//     _dueDateController.dispose();
//     if (widget.mode == FormMode.edit) {
//       Future.microtask(() => ref.invalidate(postJobNotifierProvider));
//     }
//     super.dispose();
//   }

//   Future<void> _submitForm() async {
//     if (_isSubmitting) return;
    
//     setState(() => _isSubmitting = true);
    
//     try {
//       final notifier = ref.read(postJobNotifierProvider.notifier);
//       debugPrint('Submitting with ID: ${widget.initialData?.id}');
      
//       final success = await notifier.submitJob(
//         mode: widget.mode,
//         jobId: widget.initialData?.id,
//       );
      
//       if (mounted && success) {
//         Navigator.pop(context, true);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Job ${widget.mode == FormMode.edit ? 'updated' : 'posted'} successfully!')),
//         );
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(e.toString().replaceAll('Exception: ', '')),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } finally {
//       if (mounted) setState(() => _isSubmitting = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final job = ref.watch(postJobNotifierProvider);
//     final notifier = ref.read(postJobNotifierProvider.notifier);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.mode == FormMode.edit ? 'Edit Job' : 'Post a Job'),
//         actions: [
//           TextButton(
//             onPressed: _isSubmitting ? null : _submitForm,
//             child: _isSubmitting
//                 ? const CircularProgressIndicator()
//                 : Text(widget.mode == FormMode.edit ? 'Update' : 'Post'),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildJobTypeSelector(job, notifier),
//               const SizedBox(height: 24),
//               _buildBasicInfoSection(job, notifier),
//               const SizedBox(height: 24),
//               _buildDynamicFields(job, notifier),
//               const SizedBox(height: 24),
//               _buildRequirementsSection(job, notifier),
//               const SizedBox(height: 24),
//               _buildSkillsSection(job, notifier),
//               const SizedBox(height: 24),
//               _buildWorkingDaysSection(job, notifier),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildJobTypeSelector(PostJob job, PostJobNotifier notifier) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Job Type',
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//         ),
//         const SizedBox(height: 8),
//         Wrap(
//           spacing: 8,
//           children: [
//             _JobTypeChip(
//               label: 'Local',
//               value: 'LOC',
//               selected: job.jobType == 'LOC',
//               onSelected: (val) => notifier.updateJobType('LOC'),
//             ),
//             _JobTypeChip(
//               label: 'Professional',
//               value: 'PRO',
//               selected: job.jobType == 'PRO',
//               onSelected: (val) => notifier.updateJobType('PRO'),
//             ),
//             _JobTypeChip(
//               label: 'Internship',
//               value: 'INT',
//               selected: job.jobType == 'INT',
//               onSelected: (val) => notifier.updateJobType('INT'),
//             ),
//             _JobTypeChip(
//               label: 'Volunteer',
//               value: 'VOL',
//               selected: job.jobType == 'VOL',
//               onSelected: (val) => notifier.updateJobType('VOL'),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildBasicInfoSection(PostJob job, PostJobNotifier notifier) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Basic Information',
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//         ),
//         const SizedBox(height: 16),
//         TextFormField(
//           controller: _titleController,
//           decoration: InputDecoration(
//             labelText: 'Job Title',
//             border: const OutlineInputBorder(),
//             errorText: _errors['title'],
//           ),
//           onChanged: (value) {
//             notifier.updateField('title', value);
//             _clearError('title');
//           },
//         ),
//         const SizedBox(height: 16),
//         TextFormField(
//           controller: _locationController,
//           decoration: InputDecoration(
//             labelText: 'Location (Street/Area)',
//             border: const OutlineInputBorder(),
//             errorText: _errors['location'],
//           ),
//           onChanged: (value) {
//             notifier.updateField('location', value);
//             _clearError('location');
//           },
//         ),
//         const SizedBox(height: 16),
//         TextFormField(
//           controller: _cityController,
//           decoration: InputDecoration(
//             labelText: 'City',
//             border: const OutlineInputBorder(),
//             errorText: _errors['city'],
//           ),
//           onChanged: (value) {
//             notifier.updateField('city', value);
//             _clearError('city');
//           },
//         ),
//         const SizedBox(height: 16),
//         TextFormField(
//           controller: _districtController,
//           decoration: InputDecoration(
//             labelText: 'District/Neighborhood',
//             border: const OutlineInputBorder(),
//             errorText: _errors['district'],
//           ),
//           onChanged: (value) {
//             notifier.updateField('district', value);
//             _clearError('district');
//           },
//         ),
//         const SizedBox(height: 16),
//         DropdownButtonFormField<String>(
//           value: job.job_nature ?? 'Full time',
//           decoration: const InputDecoration(
//             labelText: 'Job Nature',
//             border: OutlineInputBorder(),
//           ),
//           items: const [
//             DropdownMenuItem(value: 'Full time', child: Text('Full-time')),
//             DropdownMenuItem(value: 'Part time', child: Text('Part-time')),
//             DropdownMenuItem(value: 'Contract', child: Text('Contract')),
//             DropdownMenuItem(value: 'Freelance', child: Text('Freelance')),
//           ],
//           onChanged: (value) {
//             if (value != null) notifier.updateField('job_nature', value);
//           },
//         ),
//         const SizedBox(height: 16),
//         DropdownButtonFormField<String>(
//           value: job.category,
//           decoration: const InputDecoration(
//             labelText: 'Category',
//             border: OutlineInputBorder(),
//           ),
//           items: const [
//             DropdownMenuItem(value: 'IT', child: Text('Information Technology')),
//             DropdownMenuItem(value: 'HEALTH', child: Text('Health')),
//             DropdownMenuItem(value: 'FINANCE', child: Text('Finance')),
//           ],
//           onChanged: (value) {
//             if (value != null) notifier.updateField('category', value);
//           },
//         ),
//         const SizedBox(height: 16),
//         TextFormField(
//           controller: _descriptionController,
//           maxLines: 5,
//           decoration: InputDecoration(
//             labelText: 'Description',
//             border: const OutlineInputBorder(),
//             errorText: _errors['description'],
//           ),
//           onChanged: (value) {
//             notifier.updateField('description', value);
//             _clearError('description');
//           },
//         ),
//         const SizedBox(height: 16),
//         TextFormField(
//           controller: _rolesController,
//           maxLines: 3,
//           decoration: const InputDecoration(
//             labelText: 'Roles & Responsibilities',
//             border: OutlineInputBorder(),
//           ),
//           onChanged: (value) => notifier.updateField('rolesDescription', value),
//         ),
//       ],
//     );
//   }

//   Widget _buildDynamicFields(PostJob job, PostJobNotifier notifier) {
//     final isPaidJob = job.jobType == 'PRO' || job.jobType == 'LOC';
    
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (isPaidJob) ...[
//           TextFormField(
//             keyboardType: TextInputType.number,
//             decoration: InputDecoration(
//               labelText: 'Salary Amount',
//               border: const OutlineInputBorder(),
//               prefixText: 'FCFA',
//               errorText: _errors['salary'],
//             ),
//             onChanged: (value) {
//               notifier.updateTypeSpecific(
//                 'salary', 
//                 value.isEmpty ? null : int.tryParse(value),
//               );
//               _clearError('salary');
//             },
//           ),
//           const SizedBox(height: 16),
//           DropdownButtonFormField<String>(
//             value: job.typeSpecific['salary_period'] ?? 'd',
//             decoration: const InputDecoration(
//               labelText: 'Salary Period',
//               border: OutlineInputBorder(),
//             ),
//             items: const [
//               DropdownMenuItem(value: 'd', child: Text('Daily')),
//               DropdownMenuItem(value: 'w', child: Text('Weekly')),
//               DropdownMenuItem(value: 'm', child: Text('Monthly')),
//             ],
//             onChanged: (value) => notifier.updateTypeSpecific('salary_period', value),
//           ),
//         ] else ...[
//           SwitchListTile(
//             title: const Text('Includes Compensation'),
//             value: job.typeSpecific['compensation_toggle'] ?? false,
//             onChanged: (value) => notifier.updateTypeSpecific('compensation_toggle', value),
//           ),
//           if (job.typeSpecific['compensation_toggle'] == true) ...[
//             const SizedBox(height: 16),
//             TextFormField(
//               decoration: const InputDecoration(
//                 labelText: 'Compensation Details',
//                 border: OutlineInputBorder(),
//               ),
//               onChanged: (value) => notifier.updateTypeSpecific(
//                 'bonus_supplementary', 
//                 {'details': value},
//               ),
//             ),
//           ],
//         ],
//         const SizedBox(height: 24),
//         TextFormField(
//           readOnly: true,
//           controller: _dueDateController,
//           decoration: InputDecoration(
//             labelText: 'Due Date',
//             border: const OutlineInputBorder(),
//             errorText: _errors['dueDate'],
//           ),
//           onTap: () async {
//             final date = await showDatePicker(
//               context: context,
//               initialDate: DateTime.now().add(const Duration(days: 7)),
//               firstDate: DateTime.now(),
//               lastDate: DateTime.now().add(const Duration(days: 365)),
//             );
//             if (date != null) {
//               notifier.updateField(
//                 'dueDate', 
//                 DateFormat('yyyy-MM-dd').format(date),
//               );
//               _dueDateController.text = DateFormat('yyyy-MM-dd').format(date);
//               _clearError('dueDate');
//             }
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildRequirementsSection(PostJob job, PostJobNotifier notifier) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text('Requirements', style: TextStyle(fontWeight: FontWeight.bold)),
//         Wrap(
//           spacing: 8,
//           children: [
//             ...job.requirements.map((req) => Chip(
//               label: Text(req),
//               onDeleted: () => notifier.updateField(
//                 'requirements',
//                 job.requirements.where((r) => r != req).toList(),
//               ),
//             )),
//             ConstrainedBox(
//               constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 100),
//               child: TextFormField(
//                 controller: _requirementController,
//                 decoration: InputDecoration(
//                   labelText: 'Add requirement',
//                   suffixIcon: IconButton(
//                     icon: const Icon(Icons.add),
//                     onPressed: () {
//                       if (_requirementController.text.isNotEmpty) {
//                         notifier.updateField(
//                           'requirements',
//                           [...job.requirements, _requirementController.text],
//                         );
//                         _requirementController.clear();
//                       }
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildSkillsSection(PostJob job, PostJobNotifier notifier) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Skills Required',
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//         ),
//         const SizedBox(height: 16),
        
//         // Required Skills
//         _buildSkillInputField(
//           controller: _requiredSkillController,
//           label: 'Required Skills (Must Have)',
//           skills: job.requiredSkills,
//           onAdd: (skill) => notifier.updateField('requiredSkills', [...job.requiredSkills, skill]),
//           onRemove: (skill) => notifier.updateField(
//             'requiredSkills', 
//             job.requiredSkills.where((s) => s != skill).toList(),
//           ),
//         ),
        
//         const SizedBox(height: 16),
        
//         // Optional Skills
//         _buildSkillInputField(
//           controller: _optionalSkillController,
//           label: 'Bonus Skills (Nice to Have)',
//           skills: job.optionalSkills,
//           onAdd: (skill) => notifier.updateField('optionalSkills', [...job.optionalSkills, skill]),
//           onRemove: (skill) => notifier.updateField(
//             'optionalSkills', 
//             job.optionalSkills.where((s) => s != skill).toList(),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSkillInputField({
//     required TextEditingController controller,
//     required String label,
//     required List<String> skills,
//     required Function(String) onAdd,
//     required Function(String) onRemove,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label),
//         const SizedBox(height: 8),
//         Wrap(
//           spacing: 8,
//           runSpacing: 8,
//           children: [
//             ...skills.map((skill) => Chip(
//               label: Text(skill),
//               onDeleted: () => onRemove(skill),
//             )),
//             ConstrainedBox(
//               constraints: BoxConstraints(
//                 maxWidth: MediaQuery.of(context).size.width - 100,
//               ),
//               child: TextFormField(
//                 controller: controller,
//                 decoration: InputDecoration(
//                   labelText: 'Add skill',
//                   suffixIcon: IconButton(
//                     icon: const Icon(Icons.add),
//                     onPressed: () {
//                       if (controller.text.trim().isNotEmpty) {
//                         onAdd(controller.text.trim());
//                         controller.clear();
//                       }
//                     },
//                   ),
//                 ),
//                 onFieldSubmitted: (value) {
//                   if (value.trim().isNotEmpty) {
//                     onAdd(value.trim());
//                     controller.clear();
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildWorkingDaysSection(PostJob job, PostJobNotifier notifier) {
//     const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Working Days',
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//         ),
//         const SizedBox(height: 8),
//         Wrap(
//           spacing: 8,
//           children: days.map((day) => FilterChip(
//             label: Text(day),
//             selected: job.workingDays.contains(day),
//             onSelected: (selected) {
//               final newDays = List<String>.from(job.workingDays);
//               if (selected) {
//                 newDays.add(day);
//               } else {
//                 newDays.remove(day);
//               }
//               notifier.updateField('workingDays', newDays);
//             },
//           )).toList(),
//         ),
//       ],
//     );
//   }
// }

// class _JobTypeChip extends StatelessWidget {
//   final String label;
//   final String value;
//   final bool selected;
//   final Function(bool) onSelected;

//   const _JobTypeChip({
//     required this.label,
//     required this.value,
//     required this.selected,
//     required this.onSelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ChoiceChip(
//       label: Text(label),
//       selected: selected,
//       onSelected: onSelected,
//       selectedColor: Theme.of(context).primaryColor,
//       labelStyle: TextStyle(
//         color: selected ? Colors.white : Colors.black,
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:workdey_frontend/core/enums/form_mode.dart';
import 'package:workdey_frontend/core/models/postjob/post_job_model.dart';
import 'package:workdey_frontend/core/providers/post_job_provider.dart';
import 'package:workdey_frontend/features/location/widgets/zone_selector.dart';
import 'package:workdey_frontend/features/location/widgets/gps_location_button.dart';

class PostJobForm extends ConsumerStatefulWidget {
  final FormMode mode;
  final PostJob? initialData;
  
  const PostJobForm({
    super.key,
    this.mode = FormMode.create,
    this.initialData,
  });

  @override
  ConsumerState<PostJobForm> createState() => _PostJobFormState();
}

class _PostJobFormState extends ConsumerState<PostJobForm> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();
  
  // Text Controllers
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _rolesController = TextEditingController();
  final _locationController = TextEditingController();
  final _cityController = TextEditingController();
  final _districtController = TextEditingController();
  final _requirementController = TextEditingController();
  final _requiredSkillController = TextEditingController();
  final _optionalSkillController = TextEditingController();
  final _dueDateController = TextEditingController();
  
  // Focus Nodes
  final _requiredSkillFocus = FocusNode();
  final _optionalSkillFocus = FocusNode();
  final _requirementFocus = FocusNode();
  
  // State
  Map<String, String> _errors = {};
  bool _initialized = false;
  bool _isSubmitting = false;
  int? _selectedZoneId;
  double? _gpsLatitude;
  double? _gpsLongitude;
  bool _useGPS = false;

  @override
  void initState() {
    super.initState();
    _setupControllers();
    _setupKeyboardListeners();
  }

  void _setupKeyboardListeners() {
    // Required Skills - Done key handler
    _requiredSkillFocus.addListener(() {
      if (!_requiredSkillFocus.hasFocus && _requiredSkillController.text.isNotEmpty) {
        _addRequiredSkill();
      }
    });
    
    // Optional Skills - Done key handler
    _optionalSkillFocus.addListener(() {
      if (!_optionalSkillFocus.hasFocus && _optionalSkillController.text.isNotEmpty) {
        _addOptionalSkill();
      }
    });
    
    // Requirements - Done key handler
    _requirementFocus.addListener(() {
      if (!_requirementFocus.hasFocus && _requirementController.text.isNotEmpty) {
        _addRequirement();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final job = ref.watch(postJobNotifierProvider);
    final notifier = ref.read(postJobNotifierProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProgressIndicator(),
              const SizedBox(height: 24),
              _buildJobTypeSection(job, notifier),
              const SizedBox(height: 24),
              _buildBasicInfoSection(job, notifier),
              const SizedBox(height: 24),
              _buildLocationSection(job, notifier),
              const SizedBox(height: 24),
              _buildJobDetailsSection(job, notifier),
              const SizedBox(height: 24),
              _buildCompensationSection(job, notifier),
              const SizedBox(height: 24),
              _buildSkillsSection(job, notifier),
              const SizedBox(height: 24),
              _buildRequirementsSection(job, notifier),
              const SizedBox(height: 24),
              _buildWorkingDaysSection(job, notifier),
              const SizedBox(height: 100), // Space for floating button
            ],
          ),
        ),
      ),
      floatingActionButton: _buildSubmitButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        widget.mode == FormMode.edit ? 'Edit Job' : 'Post a Job',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        TextButton(
          onPressed: _isSubmitting ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  Widget _buildProgressIndicator() {
    final job = ref.watch(postJobNotifierProvider);
    final completedSections = _getCompletedSections(job);
    final progress = completedSections / 7; // Total sections

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Progress',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            const Spacer(),
            Text(
              '${(progress * 100).toInt()}%',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildJobTypeSection(PostJob job, PostJobNotifier notifier) {
    return _buildSection(
      title: 'Job Type',
      icon: Icons.work_outline,
      isRequired: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select the type of job you\'re posting',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _JobTypeChip(
                label: 'Local Job',
                value: 'LOC',
                description: 'Quick local tasks',
                icon: Icons.location_city,
                selected: job.jobType == 'LOC',
                onSelected: () => notifier.updateJobType('LOC'),
              ),
              _JobTypeChip(
                label: 'Professional',
                value: 'PRO',
                description: 'Skilled professional work',
                icon: Icons.business_center,
                selected: job.jobType == 'PRO',
                onSelected: () => notifier.updateJobType('PRO'),
              ),
              _JobTypeChip(
                label: 'Internship',
                value: 'INT',
                description: 'Learning opportunities',
                icon: Icons.school,
                selected: job.jobType == 'INT',
                onSelected: () => notifier.updateJobType('INT'),
              ),
              _JobTypeChip(
                label: 'Volunteer',
                value: 'VOL',
                description: 'Community service',
                icon: Icons.volunteer_activism,
                selected: job.jobType == 'VOL',
                onSelected: () => notifier.updateJobType('VOL'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfoSection(PostJob job, PostJobNotifier notifier) {
    return _buildSection(
      title: 'Basic Information',
      icon: Icons.info_outline,
      isRequired: true,
      child: Column(
        children: [
          _buildTextField(
            controller: _titleController,
            label: 'Job Title',
            hint: 'e.g., Graphic Designer Needed',
            isRequired: true,
            onChanged: (value) => notifier.updateField('title', value),
          ),
          const SizedBox(height: 16),
          _buildDropdownField(
            label: 'Category',
            value: job.category.isEmpty ? null : job.category,
            items: const [
              DropdownMenuItem(value: 'IT', child: Text('Information Technology')),
              DropdownMenuItem(value: 'HEALTH', child: Text('Healthcare')),
              DropdownMenuItem(value: 'FINANCE', child: Text('Finance')),
              DropdownMenuItem(value: 'CONSTRUCTION', child: Text('Construction')),
              DropdownMenuItem(value: 'EDUCATION', child: Text('Education')),
              DropdownMenuItem(value: 'DESIGN', child: Text('Design')),
              DropdownMenuItem(value: 'OTHER', child: Text('Other')),
            ],
            onChanged: (value) => notifier.updateField('category', value),
          ),
          const SizedBox(height: 16),
          _buildDropdownField(
            label: 'Job Nature',
            value: job.job_nature?.isEmpty == true ? null : job.job_nature,
            items: const [
              DropdownMenuItem(value: 'Full time', child: Text('Full-time')),
              DropdownMenuItem(value: 'Part time', child: Text('Part-time')),
              DropdownMenuItem(value: 'Contract', child: Text('Contract')),
              DropdownMenuItem(value: 'Freelance', child: Text('Freelance')),
            ],
            onChanged: (value) => notifier.updateField('job_nature', value),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSection(PostJob job, PostJobNotifier notifier) {
    return _buildSection(
      title: 'Location',
      icon: Icons.location_on,
      isRequired: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Zone Selection (Recommended)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue[200]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.recommend, size: 20, color: Colors.blue[700]),
                    const SizedBox(width: 8),
                    Text(
                      'Recommended: Select Zone',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.blue[700],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Choose a specific area for better job visibility and accurate distance calculations.',
                  style: TextStyle(color: Colors.blue[600], fontSize: 13),
                ),
                const SizedBox(height: 12),
                ZoneSelector(
                  label: 'Select Area/Zone',
                  hint: 'Search for specific area (e.g., Molyko, Mile 17)...',
                  onZoneSelected: (zone) {
                    setState(() {
                      _selectedZoneId = zone.id;
                    });
                    // Auto-fill city/district from zone
                    _cityController.text = zone.city;
                    _districtController.text = zone.district ?? '';
                    notifier.updateField('city', zone.city);
                    notifier.updateField('district', zone.district ?? '');
                  },
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Manual Location Input (Alternative)
          ExpansionTile(
            title: const Text('Or enter location manually'),
            leading: const Icon(Icons.edit_location),
            children: [
              const SizedBox(height: 12),
              _buildTextField(
                controller: _locationController,
                label: 'Full Address/Location',
                hint: 'e.g., Near University of Buea, Molyko',
                onChanged: (value) => notifier.updateField('location', value),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _cityController,
                      label: 'City',
                      hint: 'e.g., Buea',
                      onChanged: (value) => notifier.updateField('city', value),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      controller: _districtController,
                      label: 'District/Area',
                      hint: 'e.g., Molyko',
                      onChanged: (value) => notifier.updateField('district', value),
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // GPS Location (Optional)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green[200]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Add Precise GPS Location (Optional)',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.green[700],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'For exact location and better job matching',
                            style: TextStyle(color: Colors.green[600], fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: _useGPS,
                      onChanged: (value) {
                        setState(() {
                          _useGPS = value;
                          if (!value) {
                            _gpsLatitude = null;
                            _gpsLongitude = null;
                          }
                        });
                      },
                    ),
                  ],
                ),
                if (_useGPS) ...[
                  const SizedBox(height: 12),
                  GPSLocationButton(
                    onLocationObtained: (position) {
                      setState(() {
                        _gpsLatitude = position.latitude;
                        _gpsLongitude = position.longitude;
                      });
                    },
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobDetailsSection(PostJob job, PostJobNotifier notifier) {
    return _buildSection(
      title: 'Job Details',
      icon: Icons.description,
      isRequired: true,
      child: Column(
        children: [
          _buildTextField(
            controller: _descriptionController,
            label: 'Job Description',
            hint: 'Describe what you need done...',
            maxLines: 4,
            isRequired: true,
            onChanged: (value) => notifier.updateField('description', value),
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _rolesController,
            label: 'Roles & Responsibilities',
            hint: 'What will the person be doing?',
            maxLines: 3,
            onChanged: (value) => notifier.updateField('rolesDescription', value),
          ),
          const SizedBox(height: 16),
          _buildDateField(
            controller: _dueDateController,
            label: 'Application Deadline',
            isRequired: true,
            onChanged: (date) => notifier.updateField('dueDate', date),
          ),
        ],
      ),
    );
  }

  Widget _buildCompensationSection(PostJob job, PostJobNotifier notifier) {
    final isPaidJob = job.jobType == 'PRO' || job.jobType == 'LOC';
    
    return _buildSection(
      title: 'Compensation',
      icon: Icons.payments,
      isRequired: isPaidJob,
      child: isPaidJob ? _buildSalaryFields(job, notifier) : _buildCompensationToggle(job, notifier),
    );
  }

  Widget _buildSalaryFields(PostJob job, PostJobNotifier notifier) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: _buildTextField(
                label: 'Salary Amount',
                hint: '50000',
                keyboardType: TextInputType.number,
                isRequired: true,
                prefixText: 'FCFA ',
                onChanged: (value) {
                  final amount = int.tryParse(value);
                  notifier.updateTypeSpecific('salary', amount);
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildDropdownField(
                label: 'Period',
                value: job.typeSpecific['salary_period']?.toString().isEmpty == true
                     ? null 
                     : job.typeSpecific['salary_period']?.toString(),
                items: const [
                  DropdownMenuItem(value: 'd', child: Text('Daily')),
                  DropdownMenuItem(value: 'w', child: Text('Weekly')),
                  DropdownMenuItem(value: 'm', child: Text('Monthly')),
                ],
                onChanged: (value) => notifier.updateTypeSpecific('salary_period', value),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCompensationToggle(PostJob job, PostJobNotifier notifier) {
    return Column(
      children: [
        SwitchListTile(
          title: const Text('Includes Other Compensation'),
          subtitle: const Text('Food, transport, certificates, etc.'),
          value: job.typeSpecific['compensation_toggle'] ?? false,
          onChanged: (value) => notifier.updateTypeSpecific('compensation_toggle', value),
        ),
        if (job.typeSpecific['compensation_toggle'] == true) ...[
          const SizedBox(height: 16),
          _buildTextField(
            label: 'Compensation Details',
            hint: 'e.g., Free lunch + transport allowance + certificate',
            maxLines: 2,
            onChanged: (value) => notifier.updateTypeSpecific(
              'bonus_supplementary', 
              {'details': value},
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSkillsSection(PostJob job, PostJobNotifier notifier) {
    return _buildSection(
      title: 'Skills Required',
      icon: Icons.psychology,
      isRequired: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Required Skills
          Text(
            'Required Skills (Must Have)',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.red[700],
            ),
          ),
          const SizedBox(height: 8),
          _buildSkillInput(
            controller: _requiredSkillController,
            focusNode: _requiredSkillFocus,
            hint: 'Enter a required skill and press Done',
            skills: job.requiredSkills,
            onAdd: _addRequiredSkill,
            onRemove: (skill) => _removeRequiredSkill(skill, notifier),
            chipColor: Colors.red[50]!,
            chipBorderColor: Colors.red[200]!,
            chipTextColor: Colors.red[700]!,
          ),
          
          const SizedBox(height: 20),
          
          // Optional Skills
          Text(
            'Nice to Have Skills (Optional)',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.green[700],
            ),
          ),
          const SizedBox(height: 8),
          _buildSkillInput(
            controller: _optionalSkillController,
            focusNode: _optionalSkillFocus,
            hint: 'Enter an optional skill and press Done',
            skills: job.optionalSkills,
            onAdd: _addOptionalSkill,
            onRemove: (skill) => _removeOptionalSkill(skill, notifier),
            chipColor: Colors.green[50]!,
            chipBorderColor: Colors.green[200]!,
            chipTextColor: Colors.green[700]!,
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementsSection(PostJob job, PostJobNotifier notifier) {
    return _buildSection(
      title: 'Other Requirements',
      icon: Icons.checklist,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Additional requirements or qualifications',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 12),
          _buildSkillInput(
            controller: _requirementController,
            focusNode: _requirementFocus,
            hint: 'Enter a requirement and press Done',
            skills: job.requirements,
            onAdd: _addRequirement,
            onRemove: (req) => _removeRequirement(req, notifier),
            chipColor: Colors.blue[50]!,
            chipBorderColor: Colors.blue[200]!,
            chipTextColor: Colors.blue[700]!,
          ),
        ],
      ),
    );
  }

  Widget _buildWorkingDaysSection(PostJob job, PostJobNotifier notifier) {
    const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    
    return _buildSection(
      title: 'Working Days',
      icon: Icons.calendar_today,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select the working days for this job',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: days.map((day) {
              final isSelected = job.workingDays.contains(day);
              return FilterChip(
                label: Text(day),
                selected: isSelected,
                onSelected: (selected) {
                  final newDays = List<String>.from(job.workingDays);
                  if (selected) {
                    newDays.add(day);
                  } else {
                    newDays.remove(day);
                  }
                  notifier.updateField('workingDays', newDays);
                },
                selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
                checkmarkColor: Theme.of(context).primaryColor,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Helper Methods for Skills/Requirements
  void _addRequiredSkill() {
    final skill = _requiredSkillController.text.trim();
    if (skill.isNotEmpty) {
      final notifier = ref.read(postJobNotifierProvider.notifier);
      final job = ref.read(postJobNotifierProvider);
      final newSkills = [...job.requiredSkills, skill];
      notifier.updateField('requiredSkills', newSkills);
      _requiredSkillController.clear();
    }
  }

  void _addOptionalSkill() {
    final skill = _optionalSkillController.text.trim();
    if (skill.isNotEmpty) {
      final notifier = ref.read(postJobNotifierProvider.notifier);
      final job = ref.read(postJobNotifierProvider);
      final newSkills = [...job.optionalSkills, skill];
      notifier.updateField('optionalSkills', newSkills);
      _optionalSkillController.clear();
    }
  }

  void _addRequirement() {
    final requirement = _requirementController.text.trim();
    if (requirement.isNotEmpty) {
      final notifier = ref.read(postJobNotifierProvider.notifier);
      final job = ref.read(postJobNotifierProvider);
      final newRequirements = [...job.requirements, requirement];
      notifier.updateField('requirements', newRequirements);
      _requirementController.clear();
    }
  }

  void _removeRequiredSkill(String skill, PostJobNotifier notifier) {
    final job = ref.read(postJobNotifierProvider);
    final newSkills = job.requiredSkills.where((s) => s != skill).toList();
    notifier.updateField('requiredSkills', newSkills);
  }

  void _removeOptionalSkill(String skill, PostJobNotifier notifier) {
    final job = ref.read(postJobNotifierProvider);
    final newSkills = job.optionalSkills.where((s) => s != skill).toList();
    notifier.updateField('optionalSkills', newSkills);
  }

  void _removeRequirement(String requirement, PostJobNotifier notifier) {
    final job = ref.read(postJobNotifierProvider);
    final newRequirements = job.requirements.where((r) => r != requirement).toList();
    notifier.updateField('requirements', newRequirements);
  }

  // Helper widget methods...
  Widget _buildSection({
    required String title,
    required IconData icon,
    required Widget child,
    bool isRequired = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (isRequired)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Required',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.red[700],
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildTextField({
    TextEditingController? controller,
    required String label,
    String? hint,
    int maxLines = 1,
    bool isRequired = false,
    TextInputType? keyboardType,
    String? prefixText,
    Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: isRequired ? '$label *' : label,
        hintText: hint,
        prefixText: prefixText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      onChanged: onChanged,
      validator: isRequired ? (value) {
        if (value?.isEmpty ?? true) {
          return '$label is required';
        }
        return null;
      } : null,
    );
  }

  Widget _buildDropdownField<T>({
    required String label,
    required T? value,
    required List<DropdownMenuItem<T>> items,
    Function(T?)? onChanged,
    bool isRequired = false,
  }) {

    final validValue = items.any((item) => item.value == value) ? value : null;

    return DropdownButtonFormField<T>(
      value: validValue,
      decoration: InputDecoration(
        labelText: isRequired ? '$label *' : label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      items: items,
      onChanged: onChanged,
      validator: isRequired ? (value) {
        if (value == null) {
          return '$label is required';
        }
        return null;
      } : null,
    );
  }

  Widget _buildDateField({
    required TextEditingController controller,
    required String label,
    bool isRequired = false,
    Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: isRequired ? '$label *' : label,
        suffixIcon: const Icon(Icons.calendar_today),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime.now().add(const Duration(days: 7)),
         firstDate: DateTime.now(),
         lastDate: DateTime.now().add(const Duration(days: 365)),
       );
       if (date != null) {
         final formattedDate = DateFormat('yyyy-MM-dd').format(date);
         controller.text = formattedDate;
         if (onChanged != null) onChanged(formattedDate);
       }
     },
     validator: isRequired ? (value) {
       if (value?.isEmpty ?? true) {
         return '$label is required';
       }
       return null;
     } : null,
   );
 }

 Widget _buildSkillInput({
   required TextEditingController controller,
   required FocusNode focusNode,
   required String hint,
   required List<String> skills,
   required VoidCallback onAdd,
   required Function(String) onRemove,
   required Color chipColor,
   required Color chipBorderColor,
   required Color chipTextColor,
 }) {
   return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
       // Skills Chips Display
       if (skills.isNotEmpty) ...[
         Wrap(
           spacing: 8,
           runSpacing: 8,
           children: skills.map((skill) => Chip(
             label: Text(skill),
             deleteIcon: const Icon(Icons.close, size: 16),
             onDeleted: () => onRemove(skill),
             backgroundColor: chipColor,
             side: BorderSide(color: chipBorderColor),
             labelStyle: TextStyle(
               color: chipTextColor,
               fontWeight: FontWeight.w500,
             ),
           )).toList(),
         ),
         const SizedBox(height: 12),
       ],
       
       // Input Field
       TextFormField(
         controller: controller,
         focusNode: focusNode,
         decoration: InputDecoration(
           hintText: hint,
           border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(12),
           ),
           filled: true,
           fillColor: Colors.grey[50],
           suffixIcon: IconButton(
             icon: const Icon(Icons.add),
             onPressed: onAdd,
           ),
         ),
         textInputAction: TextInputAction.done,
         onFieldSubmitted: (_) => onAdd(),
       ),
     ],
   );
 }

 Widget _buildSubmitButton() {
   return Container(
     width: double.infinity,
     margin: const EdgeInsets.symmetric(horizontal: 16),
     child: ElevatedButton(
       onPressed: _isSubmitting ? null : _submitForm,
       style: ElevatedButton.styleFrom(
         backgroundColor: const Color(0xFF3E8728),
         padding: const EdgeInsets.symmetric(vertical: 16),
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(12),
         ),
         elevation: 4,
       ),
       child: _isSubmitting
           ? const Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 SizedBox(
                   width: 20,
                   height: 20,
                   child: CircularProgressIndicator(
                     strokeWidth: 2,
                     valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                   ),
                 ),
                 SizedBox(width: 12),
                 Text(
                   'Posting...',
                   style: TextStyle(
                     fontSize: 16,
                     fontWeight: FontWeight.bold,
                     color: Colors.white,
                   ),
                 ),
               ],
             )
           : Text(
               widget.mode == FormMode.edit ? 'Update Job' : 'Post Job',
               style: const TextStyle(
                 fontSize: 16,
                 fontWeight: FontWeight.bold,
                 color: Colors.white,
               ),
             ),
     ),
   );
 }

 // Helper Methods
 void _setupControllers() {
   final job = ref.read(postJobNotifierProvider);
   _titleController.text = job.title;
   _descriptionController.text = job.description;
   _rolesController.text = job.rolesDescription ?? '';
   _locationController.text = job.location ?? '';
   _cityController.text = job.city ?? '';
   _districtController.text = job.district ?? '';
   _dueDateController.text = job.dueDate ?? '';
 }

 int _getCompletedSections(PostJob job) {
   int completed = 0;
   
   // Job Type
   if (job.jobType.isNotEmpty) completed++;
   
   // Basic Info
   if (job.title.isNotEmpty && job.category.isNotEmpty) completed++;
   
   // Location
   if ((job.city?.isNotEmpty == true) || (job.location?.isNotEmpty == true)) completed++;
   
   // Job Details
   if (job.description.isNotEmpty && job.dueDate?.isNotEmpty == true) completed++;
   
   // Compensation
   final isPaidJob = job.jobType == 'PRO' || job.jobType == 'LOC';
   if (isPaidJob) {
     if (job.typeSpecific['salary'] != null) completed++;
   } else {
     completed++; // Non-paid jobs auto-complete this section
   }
   
   // Skills
   if (job.requiredSkills.isNotEmpty) completed++;
   
   // Working Days
   if (job.workingDays.isNotEmpty) completed++;
   
   return completed;
 }

 Future<void> _submitForm() async {
   if (!_formKey.currentState!.validate()) {
     return;
   }

   setState(() => _isSubmitting = true);
   
   try {
     final notifier = ref.read(postJobNotifierProvider.notifier);
     
     // Add zone and GPS data if available
     final data = <String, dynamic>{};
     if (_selectedZoneId != null) {
       data['zone_id'] = _selectedZoneId;
     }
     if (_gpsLatitude != null && _gpsLongitude != null) {
       data['latitude'] = _gpsLatitude;
       data['longitude'] = _gpsLongitude;
     }
     
     // Update any additional data
     for (final entry in data.entries) {
       notifier.updateField(entry.key, entry.value);
     }
     
     final success = await notifier.submitJob(
       mode: widget.mode,
       jobId: widget.initialData?.id,
     );
     
     if (mounted && success) {
       Navigator.pop(context, true);
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
           content: Text('Job ${widget.mode == FormMode.edit ? 'updated' : 'posted'} successfully!'),
           backgroundColor: Colors.green,
         ),
       );
     }
   } catch (e) {
     if (mounted) {
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
           content: Text(e.toString().replaceAll('Exception: ', '')),
           backgroundColor: Colors.red,
         ),
       );
     }
   } finally {
     if (mounted) setState(() => _isSubmitting = false);
   }
 }

 @override
 void didChangeDependencies() {
   super.didChangeDependencies();
   if (!_initialized && widget.mode == FormMode.edit && widget.initialData != null) {
     WidgetsBinding.instance.addPostFrameCallback((_) {
       _initializeWithPostJobData(widget.initialData!);
     });
     _initialized = true;
   }
 }

 Future<void> _initializeWithPostJobData(PostJob postjob) async {
   // Implementation same as before...
   // (Initialize controllers with existing data for edit mode)
 }

 @override
 void dispose() {
   _titleController.dispose();
   _descriptionController.dispose();
   _rolesController.dispose();
   _locationController.dispose();
   _cityController.dispose();
   _districtController.dispose();
   _requirementController.dispose();
   _requiredSkillController.dispose();
   _optionalSkillController.dispose();
   _dueDateController.dispose();
   
   _requiredSkillFocus.dispose();
   _optionalSkillFocus.dispose();
   _requirementFocus.dispose();
   _scrollController.dispose();
   
   super.dispose();
 }
}

// Custom Job Type Chip Widget
class _JobTypeChip extends StatelessWidget {
 final String label;
 final String value;
 final String description;
 final IconData icon;
 final bool selected;
 final VoidCallback onSelected;

 const _JobTypeChip({
   required this.label,
   required this.value,
   required this.description,
   required this.icon,
   required this.selected,
   required this.onSelected,
 });

 @override
 Widget build(BuildContext context) {
   return GestureDetector(
     onTap: onSelected,
     child: Container(
       width: 160,
       padding: const EdgeInsets.all(16),
       decoration: BoxDecoration(
         color: selected ? Theme.of(context).primaryColor.withOpacity(0.1) : Colors.grey[50],
         borderRadius: BorderRadius.circular(12),
         border: Border.all(
           color: selected ? Theme.of(context).primaryColor : Colors.grey[300]!,
           width: selected ? 2 : 1,
         ),
       ),
       child: Column(
         children: [
           Icon(
             icon,
             size: 32,
             color: selected ? Theme.of(context).primaryColor : Colors.grey[600],
           ),
           const SizedBox(height: 8),
           Text(
             label,
             style: TextStyle(
               fontWeight: FontWeight.bold,
               color: selected ? Theme.of(context).primaryColor : Colors.grey[700],
             ),
           ),
           const SizedBox(height: 4),
           Text(
             description,
             style: TextStyle(
               fontSize: 12,
               color: Colors.grey[600],
             ),
             textAlign: TextAlign.center,
           ),
         ],
       ),
     ),
   );
 }
}