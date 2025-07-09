import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/applicant/applicant_model.dart';
import 'package:workdey_frontend/core/providers/activity_state_provider.dart';
import 'package:workdey_frontend/core/providers/applicantion_provider.dart'; // FIXED: Direct access to applications provider
import 'package:workdey_frontend/features/activities/activity_state_builder.dart';
import 'package:workdey_frontend/features/application/my_application_card.dart';

class ApplicationsActivityTab extends ConsumerStatefulWidget {
  const ApplicationsActivityTab({super.key});

  @override
  ConsumerState<ApplicationsActivityTab> createState() => _ApplicationsActivityTabState();
}

class _ApplicationsActivityTabState extends ConsumerState<ApplicationsActivityTab> {
  bool _isRefreshing = false;

  @override
  Widget build(BuildContext context) {
    // FIXED: Watch both the activity tab state AND the direct applications provider
    final tabState = ref.watch(applicationsTabProvider);
    final applicationsAsync = ref.watch(myApplicationsProvider);

    // FIXED: Debug logging to see what's happening
    WidgetsBinding.instance.addPostFrameCallback((_) {
      debugPrint('🔍 ApplicationsTab Debug:');
      debugPrint('  - Tab Status: ${tabState.status}');
      debugPrint('  - Tab Count: ${tabState.count}');
      debugPrint('  - Tab Data Type: ${tabState.data.runtimeType}');
      debugPrint('  - Applications Async: ${applicationsAsync.runtimeType}');
      
      applicationsAsync.when(
        data: (apps) => debugPrint('  - Direct Apps Count: ${apps.length}'),
        loading: () => debugPrint('  - Direct Apps: Loading'),
        error: (e, s) => debugPrint('  - Direct Apps Error: $e'),
      );
    });

    // FIXED: Use the direct applications provider as primary, activity state as fallback
    return applicationsAsync.when(
      data: (applications) => _buildSuccessState(applications),
      loading: () => _buildLoadingState(),
      error: (error, stackTrace) => _buildErrorState(error, stackTrace),
    );
  }

  // FIXED: Build success state with applications data
  Widget _buildSuccessState(List<Application> applications) {
    if (applications.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      children: [
        // Refresh header
        _buildRefreshHeader(applications.length),
        
        // Applications list
        Expanded(
          child: RefreshIndicator(
            onRefresh: _handleRefresh,
            color: const Color(0xFF3E8728),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: applications.length,
              itemBuilder: (context, index) {
                final application = applications[index];
                
                // FIXED: Add debug logging for each application
                debugPrint('🔍 Rendering Application ${index + 1}:');
                debugPrint('  - ID: ${application.id}');
                debugPrint('  - Status: ${application.status}');
                debugPrint('  - Applied At: ${application.appliedAt}');
                debugPrint('  - Applicant Name: ${application.details.name}');
                
                return Container(
                  margin: const EdgeInsets.only(bottom: 1),
                  child: MyApplicationCard(
                    application: application,
                  ),
                );
              },
            ),
          ),
        ),
      ],
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

  Widget _buildErrorState(Object error, StackTrace stackTrace) {
    // FIXED: Enhanced error display with more details
    debugPrint('❌ Applications Tab Error: $error');
    debugPrint('Stack Trace: $stackTrace');

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
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
              'Unable to Load Applications',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF181A1F),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Error: ${error.toString()}',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                color: Colors.grey[600],
                height: 1.5,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _handleRefresh,
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
                const SizedBox(width: 16),
                OutlinedButton.icon(
                  onPressed: () => Navigator.pushNamed(context, '/find-jobs'),
                  icon: const Icon(Icons.search),
                  label: const Text('Find Jobs'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF3E8728),
                    side: const BorderSide(color: Color(0xFF3E8728)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
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
            Text(
              'Start applying to jobs to track your applications here.',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/find-jobs'),
              icon: const Icon(Icons.search),
              label: const Text('Find Jobs'),
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
      ),
    );
  }

  Widget _buildRefreshHeader(int count) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          Text(
            '$count application${count == 1 ? '' : 's'}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: _isRefreshing ? null : _handleRefresh,
            borderRadius: BorderRadius.circular(6),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF3E8728).withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_isRefreshing)
                    const SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3E8728)),
                      ),
                    )
                  else
                    const Icon(
                      Icons.refresh,
                      size: 14,
                      color: Color(0xFF3E8728),
                    ),
                  const SizedBox(width: 4),
                  const Text(
                    'Refresh',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF3E8728),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // FIXED: Enhanced refresh method with better error handling
  Future<void> _handleRefresh() async {
    if (_isRefreshing) return;
    
    setState(() => _isRefreshing = true);
    
    try {
      debugPrint('🔄 ApplicationsTab: Starting manual refresh...');
      
      // Refresh both the direct provider and activity center
      await Future.wait([
        ref.read(myApplicationsProvider.notifier).forceRefresh(),
        ref.read(activityCenterProvider.notifier).refreshSingleTab(ActivityTab.applications),
      ]);
      
      debugPrint('✅ ApplicationsTab: Refresh completed');
      
    } catch (e) {
      debugPrint('❌ ApplicationsTab: Refresh failed: $e');
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to refresh: ${e.toString()}'),
            backgroundColor: Colors.red,
            action: SnackBarAction(
              label: 'Retry',
              textColor: Colors.white,
              onPressed: _handleRefresh,
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isRefreshing = false);
      }
    }
  }

  // FIXED: Add debugging method to check provider states
  void _debugProviderStates() {
    final tabState = ref.read(applicationsTabProvider);
    final applicationsAsync = ref.read(myApplicationsProvider);
    
    debugPrint('🔍 Provider States Debug:');
    debugPrint('  Tab State: ${tabState.status} (${tabState.count} items)');
    debugPrint('  Applications Async: ${applicationsAsync.runtimeType}');
    
    applicationsAsync.when(
      data: (apps) => debugPrint('  Direct Provider: ${apps.length} applications'),
      loading: () => debugPrint('  Direct Provider: Loading'),
      error: (e, s) => debugPrint('  Direct Provider Error: $e'),
    );
  }
}