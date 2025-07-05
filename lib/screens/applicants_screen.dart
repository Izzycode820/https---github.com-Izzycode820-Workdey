// applicants_screen.dart - Improved Design with Better Management
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
  String _selectedFilter = 'ALL';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
      backgroundColor: const Color(0xFFF5F7FC),
      appBar: AppBar(
        title: const Text(
          'Applicants',
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
              onPressed: () => ref.refresh(jobApplicantsProvider(widget.jobId)),
              style: IconButton.styleFrom(
                backgroundColor: const Color(0xFF3E8728).withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
        bottom: applicantsAsync.maybeWhen(
          data: (applicants) => applicants.isNotEmpty
              ? _buildTabBar(applicants)
              : null,
          orElse: () => null,
        ),
      ),
      body: applicantsAsync.when(
        loading: () => _buildLoadingState(),
        error: (error, stack) => _buildErrorState(context, ref, error),
        data: (applicants) {
          return Column(
            children: [
              // Stats Header
              _buildStatsHeader(applicants),
              
              // Content
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
    final rejected = applicants.where((app) => app.status == 'REJECTED').length;

    return TabBar(
      controller: _tabController,
      labelColor: const Color(0xFF3E8728),
      unselectedLabelColor: Colors.grey,
      indicatorColor: const Color(0xFF3E8728),
      labelStyle: const TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
      unselectedLabelStyle: const TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      tabs: [
        Tab(text: 'All (${applicants.length})'),
        Tab(text: 'Pending ($pending)'),
        Tab(text: 'Approved ($approved)'),
        Tab(text: 'Rejected ($rejected)'),
      ],
      onTap: (index) {
        setState(() {
          switch (index) {
            case 0:
              _selectedFilter = 'ALL';
              break;
            case 1:
              _selectedFilter = 'PENDING';
              break;
            case 2:
              _selectedFilter = 'APPROVED';
              break;
            case 3:
              _selectedFilter = 'REJECTED';
              break;
          }
        });
      },
    );
  }

  Widget _buildStatsHeader(List applicants) {
    final pending = applicants.where((app) => app.status == 'PENDING').length;
    final approved = applicants.where((app) => app.status == 'APPROVED').length;
    final rejected = applicants.where((app) => app.status == 'REJECTED').length;
    
    // Calculate new applications (last 24 hours)
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(hours: 24));
    final newApps = applicants.where((app) => app.appliedAt.isAfter(yesterday)).length;

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
                  Icons.people_alt,
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
                      '${applicants.length} Application${applicants.length != 1 ? 's' : ''}',
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
                        if (newApps > 0) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '$newApps new',
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
                          'Review and manage applications',
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
          
          if (applicants.isNotEmpty) ...[
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Pending',
                    pending,
                    Colors.orange,
                    Icons.schedule,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'Approved',
                    approved,
                    const Color(0xFF3E8728),
                    Icons.check_circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'Rejected',
                    rejected,
                    Colors.red,
                    Icons.cancel,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, int count, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(
            count.toString(),
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApplicantsList(List applicants) {
    final filteredApplicants = _selectedFilter == 'ALL' 
        ? applicants 
        : applicants.where((app) => app.status == _selectedFilter).toList();

    if (filteredApplicants.isEmpty) {
      return _buildEmptyFilterState();
    }

    return TabBarView(
      controller: _tabController,
      children: [
        // All Applications
        _buildApplicationsList(applicants),
        // Pending Applications
        _buildApplicationsList(applicants.where((app) => app.status == 'PENDING').toList()),
        // Approved Applications
        _buildApplicationsList(applicants.where((app) => app.status == 'APPROVED').toList()),
        // Rejected Applications
        _buildApplicationsList(applicants.where((app) => app.status == 'REJECTED').toList()),
      ],
    );
  }

  Widget _buildApplicationsList(List filteredApplicants) {
    if (filteredApplicants.isEmpty) {
      return _buildEmptyFilterState();
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.refresh(jobApplicantsProvider(widget.jobId).future);
      },
      color: const Color(0xFF3E8728),
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
        itemCount: filteredApplicants.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: ApplicantCard(
              application: filteredApplicants[index],
              isEmployerView: true,
              onStatusChanged: (status) => _showStatusConfirmation(
                context,
                ref,
                filteredApplicants[index],
                status,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
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
              Icons.people_outline,
              size: 60,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'No Applicants Yet',
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
              'Once people apply for this job, their applications will appear here for you to review.',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF3E8728).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.lightbulb_outline,
                  color: Color(0xFF3E8728),
                  size: 24,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Tips to get more applicants:',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3E8728),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '• Share your job post with friends\n• Post in relevant WhatsApp groups\n• Make sure your job details are clear',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyFilterState() {
    String message;
    IconData icon;
    
    switch (_selectedFilter) {
      case 'PENDING':
        message = 'No pending applications';
        icon = Icons.schedule;
        break;
      case 'APPROVED':
        message = 'No approved applications';
        icon = Icons.check_circle;
        break;
      case 'REJECTED':
        message = 'No rejected applications';
        icon = Icons.cancel;
        break;
      default:
        message = 'No applications found';
        icon = Icons.search_off;
    }
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
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
            'Loading applicants...',
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
            'Error Loading Applicants',
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
              'We couldn\'t load the applicants. Please check your connection and try again.',
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
            onPressed: () => ref.refresh(jobApplicantsProvider(widget.jobId)),
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

  Future<void> _showStatusConfirmation(
    BuildContext context,
    WidgetRef ref,
    application,
    String newStatus,
  ) async {
    final isApproval = newStatus == 'APPROVED';
    
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isApproval 
                      ? const Color(0xFF3E8728).withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isApproval ? Icons.check_circle : Icons.cancel,
                  color: isApproval ? const Color(0xFF3E8728) : Colors.red,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  '${isApproval ? 'Approve' : 'Reject'} Application',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0xFF181A1F),
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Are you sure you want to ${isApproval ? 'approve' : 'reject'} ${application.details.name}\'s application?',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isApproval 
                      ? const Color(0xFF3E8728).withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      isApproval ? Icons.info_outline : Icons.warning_amber_outlined,
                      color: isApproval ? const Color(0xFF3E8728) : Colors.red,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        isApproval
                            ? 'The applicant will be notified and can contact you for next steps.'
                            : 'This action cannot be undone. The applicant will be notified.',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          color: isApproval ? const Color(0xFF3E8728) : Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: isApproval ? const Color(0xFF3E8728) : Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text(
                isApproval ? 'Approve' : 'Reject',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await _updateStatus(context, ref, application.id, newStatus);
    }
  }

  Future<void> _updateStatus(
    BuildContext context,
    WidgetRef ref,
    int applicationId,
    String status,
  ) async {
    try {
      // Show loading snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'Updating status to ${status.toLowerCase()}...',
                style: const TextStyle(fontFamily: 'Inter'),
              ),
            ],
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: const Color(0xFF3E8728),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );

      await ref
          .read(applicationServiceProvider)
          .updateApplicationStatus(applicationId, status);
      
      // Refresh the applicants list
      ref.invalidate(jobApplicantsProvider(widget.jobId));
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(
                  status == 'APPROVED' ? Icons.check_circle : Icons.cancel,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 16),
                Text(
                  'Application ${status.toLowerCase()} successfully!',
                  style: const TextStyle(fontFamily: 'Inter'),
                ),
              ],
            ),
            backgroundColor: status == 'APPROVED' 
                ? const Color(0xFF3E8728)
                : Colors.red,
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error, color: Colors.white, size: 20),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Failed to update status: ${e.toString()}',
                    style: const TextStyle(fontFamily: 'Inter'),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            action: SnackBarAction(
              label: 'Retry',
              textColor: Colors.white,
              onPressed: () => _updateStatus(context, ref, applicationId, status),
            ),
          ),
        );
      }
    }
  }
}