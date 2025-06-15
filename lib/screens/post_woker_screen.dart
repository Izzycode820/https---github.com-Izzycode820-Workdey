import 'package:flutter/material.dart';
import 'package:workdey_frontend/shared/components/custom_app_bar.dart';

class PostWorkerScreen extends StatelessWidget {
  const PostWorkerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actionButton: TextButton(
          onPressed: () {
            // TODO: Implement Post Workcard functionality
            debugPrint('Post Workcard pressed');
          },
          child: const Text(
            'Post Workcard',
            style: TextStyle(
              color: Color(0xFF3E8728), // Matching your theme
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: const Center(
        child: Text(
          'Your worker profiles will appear here',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}