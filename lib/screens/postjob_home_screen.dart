import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/post_job_model.dart';
import 'package:workdey_frontend/core/providers/post_job_provider.dart';
import 'package:workdey_frontend/features/jobs/posted_job_widget.dart';
import 'package:workdey_frontend/screens/postjob_form.dart';
//import 'package:workdey_frontend/assets/empty_jobs.jpg';


class PostedJobsScreen extends ConsumerStatefulWidget {
  const PostedJobsScreen({super.key});

  @override
  ConsumerState<PostedJobsScreen> createState() => _PostedJobsScreenState();
}

class _PostedJobsScreenState extends ConsumerState<PostedJobsScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final jobs = ref.watch(postedJobsProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Workdey',
          style: TextStyle(
            color: Color(0xFF3E8728),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(postedJobsProvider.notifier).loadJobs(),
        child: _buildBody(jobs),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToPostJobForm,
        backgroundColor: const Color(0xFF3E8728),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildBody(List<PostJob> jobs) {
    if (jobs.isEmpty) {
      return _buildEmptyState();
    }
    
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: jobs.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return PostedJobItem(
          job: jobs[index],
          onTap: () => _viewJobDetails(jobs[index]),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/empty_jobs.jpg',
            width: 160,
            height: 117,
          ),
          const SizedBox(height: 24),
          const Text(
            'No jobs Posted yet',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'All your posted jobs will appear here. Click the + button to post a job',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w300,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToPostJobForm() {
    // TODO: Implement navigation to post job form
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PostJobForm()),
    );
  }

  void _viewJobDetails(PostJob job) {
    // TODO: Implement job details view
  }
}