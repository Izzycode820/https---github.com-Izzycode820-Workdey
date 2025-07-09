import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/providers/applicantion_provider.dart';
import 'package:workdey_frontend/features/application/application_card.dart';

class ApplicantsScreen extends ConsumerStatefulWidget {
  final int jobId;

  const ApplicantsScreen({super.key, required this.jobId});

  @override
  ConsumerState<ApplicantsScreen> createState() => _ApplicantsScreenState();
}

class _ApplicantsScreenState extends ConsumerState<ApplicantsScreen>
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
    final applicantsAsync = ref.watch(jobApplicantsProvider(widget.jobId));

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Applicants',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, size: 20, color: Colors.grey[600]),
            onPressed: () => ref.refresh(jobApplicantsProvider(widget.jobId)),
          ),
        ],
        bottom: applicantsAsync.maybeWhen(
          data: (applicants) => applicants.isNotEmpty ? _buildTabBar(applicants) : null,
          orElse: () => null,
        ),
      ),
      body: applicantsAsync.when(
        loading: () => _buildLoadingState(),
        error: (error, stack) => _buildErrorState(),
        data: (applicants) {
          return Column(
            children: [
              if (applicants.isNotEmpty) _buildStatsHeader(applicants),
              Expanded(
                child: applicants.isEmpty 
                    ? _buildEmptyState()
                    : _buildApplicantsList(applicants),
              ),
            ],
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildTabBar(List applicants) {
    final pending = applicants.where((app) => app.status == 'PENDING').length;
    final approved = applicants.where((app) => app.status == 'APPROVED').length;
    final inProgress = applicants.where((app) => app.status == 'IN_PROGRESS').length;
    final completed = applicants.where((app) => app.status == 'COMPLETED').length;

    return PreferredSize(
      preferredSize: const Size.fromHeight(40),
      child: Container(
        color: Colors.white,
        child: TabBar(
          controller: _tabController,
          isScrollable: false,
          labelColor: const Color(0xFF3E8728),
          unselectedLabelColor: Colors.grey[600],
          indicatorColor: const Color(0xFF3E8728),
          indicatorWeight: 2,
          labelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
          labelPadding: EdgeInsets.zero,
          tabs: [
            Tab(text: 'ALL (${applicants.length})'),
            Tab(text: 'PENDING ($pending)'),
            Tab(text: 'APPROVED ($approved)'),
            Tab(text: 'ACTIVE ($inProgress)'),
            Tab(text: 'DONE ($completed)'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsHeader(List applicants) {
    final pending = applicants.where((app) => app.status == 'PENDING').length;
    final approved = applicants.where((app) => app.status == 'APPROVED').length;
    final inProgress = applicants.where((app) => app.status == 'IN_PROGRESS').length;
    final completed = applicants.where((app) => app.status == 'COMPLETED').length;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.white,
      child: Row(
        children: [
          _buildStatItem('Total', '${applicants.length}', Colors.blue[600]!),
          _buildStatItem('Pending', '$pending', Colors.orange[600]!),
          _buildStatItem('Approved', '$approved', Colors.green[600]!),
          _buildStatItem('Active', '$inProgress', Colors.purple[600]!),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String count, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(
            count,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApplicantsList(List applicants) {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildApplicationsList(applicants),
        _buildApplicationsList(applicants.where((app) => app.status == 'PENDING').toList()),
        _buildApplicationsList(applicants.where((app) => app.status == 'APPROVED').toList()),
        _buildApplicationsList(applicants.where((app) => app.status == 'IN_PROGRESS').toList()),
        _buildApplicationsList(applicants.where((app) => app.status == 'COMPLETED').toList()),
      ],
    );
  }

  Widget _buildApplicationsList(List filteredApplicants) {
    if (filteredApplicants.isEmpty) {
      return _buildEmptyFilterState();
    }

    return RefreshIndicator(
      onRefresh: () async {
        ref.refresh(jobApplicantsProvider(widget.jobId));
      },
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: filteredApplicants.length,
        itemBuilder: (context, index) {
          return ApplicantCard(
            application: filteredApplicants[index],
            isEmployerView: true,
            onStatusChanged: (status) => _handleStatusUpdate(status),
          );
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3E8728)),
          ),
          SizedBox(height: 16),
          Text(
            'Loading applicants...',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red[400],
            ),
            const SizedBox(height: 16),
            const Text(
              'Failed to Load Applicants',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Please check your connection and try again',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => ref.refresh(jobApplicantsProvider(widget.jobId)),
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

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.people_outline,
                size: 48,
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'No Applicants Yet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Once people apply for this job, their applications will appear here for you to review.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyFilterState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.filter_list_off,
              size: 48,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            const Text(
              'No Applications Found',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'No applications match this filter criteria',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleStatusUpdate(String status) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          status == 'APPROVED' 
              ? 'Application approved successfully!'
              : 'Application rejected successfully!',
        ),
        backgroundColor: status == 'APPROVED' 
            ? const Color(0xFF3E8728)
            : Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}