import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/getworkers/get_workers_model.dart';
import 'package:workdey_frontend/core/providers/post_worker_provider.dart';
import 'package:workdey_frontend/features/workers/wokers_card.dart';
import 'package:workdey_frontend/screens/postworker_form.dart';
import 'package:workdey_frontend/shared/components/custom_app_bar.dart';

class PostedWorkersScreen extends ConsumerStatefulWidget {
  const PostedWorkersScreen({super.key});

  @override
  ConsumerState<PostedWorkersScreen> createState() => _PostedWorkersScreenState();
}

class _PostedWorkersScreenState extends ConsumerState<PostedWorkersScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    // Load initial workers when screen first loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ref.read(postedWorkersProvider) is! AsyncData) {
        ref.read(postedWorkersProvider.notifier).loadInitialWorkers();
      }
    });
  }

  void _scrollListener() {
    final double maxScroll = _scrollController.position.maxScrollExtent;
    final double currentScroll = _scrollController.position.pixels;
    final double delta = MediaQuery.of(context).size.height * 0.20;
    
    if (maxScroll - currentScroll <= delta) {
      final notifier = ref.read(postedWorkersProvider.notifier);
      if (notifier.hasMore) {
        notifier.loadNextPage();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final workersState = ref.watch(postedWorkersProvider);
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: const CustomAppBar.withoutSearch(),
      body: RefreshIndicator(
        onRefresh: () => ref.read(postedWorkersProvider.notifier).refreshWorkers(),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // Header with stats
            SliverToBoxAdapter(
              child: _buildHeader(workersState),
            ),
            
            // Workers list
            workersState.when(
              loading: () => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) => SliverFillRemaining(
                child: _buildErrorState(e.toString()),
              ),
              data: (paginated) {
                if (paginated.results.isEmpty) {
                  return SliverFillRemaining(
                    child: _buildEmptyState(),
                  );
                }

                final hasMore = ref.read(postedWorkersProvider.notifier).hasMore;
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index >= paginated.results.length) {
                        return hasMore 
                          ? const Padding(
                              padding: EdgeInsets.all(16),
                              child: Center(
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                ),
                              ),
                            )
                          : const SizedBox.shrink();
                      }
                      
                      return WorkerCard(
                        worker: paginated.results[index],
                        onTap: () => _navigateToWorkerDetails(paginated.results[index]),
                      );
                    },
                    childCount: paginated.results.length + (hasMore ? 1 : 0),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navigateToCreateWorkerProfile,
        backgroundColor: const Color(0xFF3E8728),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add, size: 20),
        label: const Text(
          'Create Profile',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildHeader(AsyncValue workersState) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'My Worker Profiles',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => ref.read(postedWorkersProvider.notifier).refreshWorkers(),
                icon: const Icon(Icons.refresh, size: 20),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.grey[100],
                  padding: const EdgeInsets.all(8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          workersState.when(
            data: (paginated) => Text(
              '${paginated.count} ${paginated.count == 1 ? 'profile' : 'profiles'} created',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            loading: () => Text(
              'Loading profiles...',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            error: (_, __) => Text(
              'Error loading profiles',
              style: TextStyle(
                fontSize: 14,
                color: Colors.red[600],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person_outline,
                size: 48,
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'No Worker Profiles Yet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Create your worker profile to showcase your skills and attract potential clients.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _navigateToCreateWorkerProfile,
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Create Your First Profile'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3E8728),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.red[400],
            ),
            const SizedBox(height: 16),
            const Text(
              'Something went wrong',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
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
              onPressed: () => ref.read(postedWorkersProvider.notifier).refreshWorkers(),
              icon: const Icon(Icons.refresh, size: 18),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3E8728),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToCreateWorkerProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PostWorkerForm(), // Clean form for creating
      ),
    ).then((_) {
      // Refresh workers when returning
      ref.read(postedWorkersProvider.notifier).refreshWorkers();
    });
  }

  void _navigateToEditWorkerProfile(Worker worker) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostWorkerForm(existingWorker: worker), // Clean form for editing
      ),
    ).then((_) {
      // Refresh workers when returning
      ref.read(postedWorkersProvider.notifier).refreshWorkers();
    });
  }

  void _navigateToWorkerDetails(Worker worker) {
    // Show bottom sheet with worker details and edit/delete options
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _WorkerDetailsBottomSheet(
        worker: worker,
        onEdit: () => _navigateToEditWorkerProfile(worker),
        onDelete: () => _deleteWorker(worker.id),
      ),
    );
  }

  Future<void> _deleteWorker(int workerId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Worker Profile'),
        content: const Text(
          'Are you sure you want to delete this worker profile? This action cannot be undone.',
        ),
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

    if (confirmed == true) {
      try {
        await ref.read(postedWorkersProvider.notifier).removeWorker(workerId);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Worker profile deleted successfully'),
              backgroundColor: Color(0xFF3E8728),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to delete worker profile: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

// ============================================================================
// WORKER DETAILS BOTTOM SHEET - 60% height, mature design
// ============================================================================

class _WorkerDetailsBottomSheet extends StatelessWidget {
  final Worker worker;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _WorkerDetailsBottomSheet({
    required this.worker,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final bottomSheetHeight = screenHeight * 0.6; // 60% height

    return Container(
      height: bottomSheetHeight,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          _buildHandle(),
          _buildHeader(context), // Pass context here
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildWorkerInfo(),
                  const SizedBox(height: 20),
                  if (worker.bio?.isNotEmpty == true) ...[
                    _buildBioSection(),
                    const SizedBox(height: 20),
                  ],
                  if (worker.skills?.isNotEmpty == true) ...[
                    _buildSkillsSection(),
                    const SizedBox(height: 20),
                  ],
                  _buildProfessionalInfo(),
                  const SizedBox(height: 100), // Space for floating buttons
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHandle() {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 8),
      width: 32,
      height: 3,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) { // Accept context as parameter
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  worker.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${worker.categoryDisplay ?? worker.category} • ${worker.location}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              _buildHeaderButton(
                context: context, // Pass context
                icon: Icons.edit,
                label: 'Edit',
                color: Colors.blue,
                onPressed: () {
                  Navigator.pop(context);
                  onEdit();
                },
              ),
              const SizedBox(width: 8),
              _buildHeaderButton(
                context: context, // Pass context
                icon: Icons.delete,
                label: null,
                color: Colors.red,
                onPressed: () {
                  Navigator.pop(context);
                  onDelete();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderButton({
    required BuildContext context, // Accept context as parameter
    required IconData icon,
    String? label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: color),
            if (label != null) ...[
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildWorkerInfo() {
    return _buildSection(
      title: 'Professional Information',
      icon: Icons.person,
      child: Column(
        children: [
          _buildInfoRow('Category', worker.categoryDisplay ?? worker.category),
          _buildInfoRow('Location', worker.location),
          if (worker.experienceYears != null)
            _buildInfoRow('Experience', '${worker.experienceYears} years'),
          if (worker.availability != null)
            _buildInfoRow('Availability', _getAvailabilityText(worker.availability!)),
          if (worker.portfolioLink?.isNotEmpty == true)
            _buildInfoRow('Portfolio', worker.portfolioLink!),
        ],
      ),
    );
  }

  Widget _buildBioSection() {
    return _buildSection(
      title: 'About',
      icon: Icons.description,
      child: Text(
        worker.bio!,
        style: const TextStyle(
          fontSize: 14,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildSkillsSection() {
    return _buildSection(
      title: 'Skills & Expertise',
      icon: Icons.psychology,
      child: Wrap(
        spacing: 6,
        runSpacing: 4,
        children: worker.skills!
            .map((skill) => _buildChip(skill, Colors.blue))
            .toList(),
      ),
    );
  }

  Widget _buildProfessionalInfo() {
    return _buildSection(
      title: 'Profile Details',
      icon: Icons.info_outline,
      child: Column(
        children: [
          _buildInfoRow('Posted', worker.postTime ?? 'Recently'),
          _buildInfoRow('Profile ID', '#${worker.id}'),
          if (worker.createdAt != null)
            _buildInfoRow('Created', _formatDate(worker.createdAt)),
        ],
      ),
    );
  }

  // Helper widgets
  Widget _buildSection({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: Colors.grey[600]),
            const SizedBox(width: 6),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.3), width: 0.5),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // Helper methods
  String _getAvailabilityText(String availability) {
    switch (availability) {
      case 'FT': return 'Full-time';
      case 'PT': return 'Part-time';
      case 'CN': return 'Contract';
      case 'FL': return 'Freelance';
      default: return availability;
    }
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}