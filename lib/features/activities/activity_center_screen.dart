// lib/features/activity_center/activity_center_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/providers/activity_state_provider.dart';
import 'package:workdey_frontend/features/activities/activity_center_card.dart';
import 'package:workdey_frontend/features/activities/tabs/applicants_tab.dart';
import 'package:workdey_frontend/features/activities/tabs/review_tab.dart';
import 'package:workdey_frontend/features/activities/tabs/save_job_tab.dart';
import 'package:workdey_frontend/features/activities/tabs/workers_tab.dart';

class ActivityCenterScreen extends ConsumerStatefulWidget {
  const ActivityCenterScreen({super.key});

  @override
  ConsumerState<ActivityCenterScreen> createState() => _ActivityCenterScreenState();
}

class _ActivityCenterScreenState extends ConsumerState<ActivityCenterScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
    final activityState = ref.watch(activityCenterProvider);
    final activitySummary = ref.watch(activitySummaryProvider);
    final hasActionItems = ref.watch(hasActionItemsProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // Simplified Activity Summary Header
          ActivitySummaryCard(
            summary: activitySummary,
            hasActionItems: hasActionItems,
            lastRefresh: activityState.lastRefresh,
            onRefresh: () => ref.read(activityCenterProvider.notifier).refreshAllData(),
            isRefreshing: false,
          ),
          
          // Tab Bar (Edge-to-Edge)
          _buildTabBar(activitySummary),
          
          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                SavedJobsActivityTab(),
                ApplicationsActivityTab(),
                ReviewsActivityTab(),
                SavedWorkersActivityTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        'Activities',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: Color(0xFF181A1F),
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
    );
  }

  Widget _buildTabBar(Map<String, int> summary) {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        labelColor: const Color(0xFF3E8728),
        unselectedLabelColor: Colors.grey[600],
        indicatorColor: const Color(0xFF3E8728),
        indicatorWeight: 2,
        isScrollable: false, // Edge-to-edge tabs
        labelStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 11,
        ),
        labelPadding: EdgeInsets.zero,
        tabs: [
          Tab(text: 'SAVED (${summary['savedJobs'] ?? 0})'),
          Tab(text: 'APPLIED (${summary['applications'] ?? 0})'),
          Tab(text: 'REVIEWS (${summary['reviews'] ?? 0})'),
          Tab(text: 'WORKERS (${summary['savedWorkers'] ?? 0})'),
        ],
      ),
    );
  }
}