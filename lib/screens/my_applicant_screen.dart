// my_applications_screen.dart - Simplified - Uses MyApplicationCard + MyApplicationBottomSheet
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/applicant/applicant_model.dart';
import 'package:workdey_frontend/core/providers/applicantion_provider.dart';
import 'package:workdey_frontend/features/application/my_application_card.dart';

class MyApplicationsScreen extends ConsumerStatefulWidget {
  const MyApplicationsScreen({super.key});

  @override
  ConsumerState<MyApplicationsScreen> createState() => _MyApplicationsScreenState();
}

class _MyApplicationsScreenState extends ConsumerState<MyApplicationsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final applicationsAsync = ref.watch(myApplicationsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FC),
      appBar: AppBar(
        title: const Text(
          'My Applications',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Color(0xFF181A1F),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF181A1F)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: const Icon(Icons.refresh, color: Color(0xFF3E8728)),
              onPressed: () => ref.refresh(myApplicationsProvider),
              style: IconButton.styleFrom(
                backgroundColor: const Color(0xFF3E8728).withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
        bottom: applicationsAsync.maybeWhen(
          data: (applications) => applications.isNotEmpty
              ? _buildTabBar(applications)
              : null,
          orElse: () => null,
        ),
      ),
      body: applicationsAsync.when(
        loading: () => _buildLoadingState(),
        error: (error, stack) => _buildErrorState(context, ref, error),
        data: (applications) {
          return Column(
            children: [
              // Stats Header
              _buildStatsHeader(applications),
              
              // Applications List
              Expanded(
                child: applications.isEmpty 
                    ? _buildEmptyState(context)
                    : _buildApplicationsTabs(applications),
              ),
            ],
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildTabBar(List<Application> applications) {
    final pending = applications.where((app) => app.status == 'PENDING').length;
    final approved = applications.where((app) => app.status == 'APPROVED').length;
    final inProgress = applications.where((app) => app.status == 'IN_PROGRESS').length;
    final completed = applications.where((app) => app.status == 'COMPLETED').length;

    return TabBar(
      controller: _tabController,
      labelColor: const Color(0xFF3E8728),
      unselectedLabelColor: Colors.grey,
      indicatorColor: const Color(0xFF3E8728),
      isScrollable: true,
      labelStyle: const TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      unselectedLabelStyle: const TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
      tabs: [
        Tab(text: 'All (${applications.length})'),
        Tab(text: 'Pending ($pending)'),
        Tab(text: 'Approved ($approved)'),
        Tab(text: 'Active ($inProgress)'),
        Tab(text: 'Done ($completed)'),
      ],
    );
  }

  Widget _buildStatsHeader(List<Application> applications) {
    final pending = applications.where((app) => app.status == 'PENDING').length;
    final approved = applications.where((app) => app.status == 'APPROVED').length;
    final inProgress = applications.where((app) => app.status == 'IN_PROGRESS').length;
    final completed = applications.where((app) => app.status == 'COMPLETED').length;

    // Calculate pending actions needed
    final needsAction = applications.where((app) => 
      app.status == 'APPROVED' || // Can start job
      app.status == 'IN_PROGRESS' // Can confirm completion
    ).length;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3E8728).withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFF3E8728).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.description,
                  color: Color(0xFF3E8728),
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${applications.length} Application${applications.length != 1 ? 's' : ''}',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF181A1F),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (needsAction > 0) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '$needsAction action needed',
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          'Tap any application for details and actions',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          if (applications.isNotEmpty) ...[
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem('Pending', pending, Colors.orange),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildStatItem('Approved', approved, const Color(0xFF3E8728)),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildStatItem('Active', inProgress, Colors.blue),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildStatItem('Done', completed, Colors.purple),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, int count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            count.toString(),
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApplicationsTabs(List<Application> applications) {
    return TabBarView(
      controller: _tabController,
      children: [
        // All Applications
        _buildApplicationsList(applications),
        // Pending Applications
        _buildApplicationsList(applications.where((app) => app.status == 'PENDING').toList()),
        // Approved Applications
        _buildApplicationsList(applications.where((app) => app.status == 'APPROVED').toList()),
        // In Progress Applications
        _buildApplicationsList(applications.where((app) => app.status == 'IN_PROGRESS').toList()),
        // Completed Applications
        _buildApplicationsList(applications.where((app) => app.status == 'COMPLETED').toList()),
      ],
    );
  }

  Widget _buildApplicationsList(List<Application> applications) {
    if (applications.isEmpty) {
      return _buildEmptyFilterState();
    }

    return RefreshIndicator(
      onRefresh: () async {
        ref.read(myApplicationsProvider.notifier).refresh();
      },
      color: const Color(0xFF3E8728),
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
        itemCount: applications.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: MyApplicationCard(
              application: applications[index],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyFilterState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No applications in this category',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try checking other tabs or applying to more jobs',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.description_outlined,
              size: 60,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'No Applications Yet',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF181A1F),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'Start applying for jobs to see your applications here. Browse available jobs and find the perfect match!',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context); // Go back to jobs screen
            },
            icon: const Icon(Icons.search),
            label: const Text('Browse Jobs'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3E8728),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3E8728)),
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Loading your applications...',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF181A1F),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, WidgetRef ref, Object error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.error_outline,
              size: 40,
              color: Colors.red[400],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Error Loading Applications',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF181A1F),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'We couldn\'t load your applications. Please check your connection and try again.',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => ref.refresh(myApplicationsProvider),
            icon: const Icon(Icons.refresh),
            label: const Text('Try Again'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3E8728),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}