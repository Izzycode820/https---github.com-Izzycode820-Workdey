import 'package:flutter/material.dart';
import 'package:workdey_frontend/core/models/getworkers/get_workers_model.dart';

class WorkerDetailsScreen extends StatefulWidget {
  final Worker worker;

  const WorkerDetailsScreen({super.key, required this.worker});

  @override
  State<WorkerDetailsScreen> createState() => _WorkerDetailsScreenState();
}

class _WorkerDetailsScreenState extends State<WorkerDetailsScreen> {
  bool _showFullBio = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FC),
      appBar: AppBar(
        title: Text(
          widget.worker.title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(widget.worker.isSaved 
                ? Icons.bookmark 
                : Icons.bookmark_outline),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              children: [
                // Header Section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 32,
                            backgroundImage: widget.worker.profilePicture != null 
                                ? NetworkImage(widget.worker.profilePicture!) 
                                : null,
                            child: widget.worker.profilePicture == null 
                                ? const Icon(Icons.person, size: 32) 
                                : null,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.worker.title,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 26,
                                    height: 1.2,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  widget.worker.userName ?? 'Anonymous',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: Colors.black.withOpacity(0.8),
                                  ),
                                ),
                                if (widget.worker.postTime != null) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    widget.worker.postTime!,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          if (widget.worker.experienceYears != null)
                            _DetailChip(
                              icon: Icons.work_outline,
                              label: '${widget.worker.experienceYears} years exp',
                            ),
                          const SizedBox(width: 8),
                          _DetailChip(
                            icon: Icons.category,
                            label: widget.worker.categoryDisplay ?? widget.worker.category,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // About Section
                if (widget.worker.bio != null)
                  _buildSection(
                    title: 'About',
                    content: widget.worker.bio!,
                    expanded: _showFullBio,
                    onExpand: () => setState(() => _showFullBio = !_showFullBio),
                  ),

                // Skills Section
                if (widget.worker.skills != null && widget.worker.skills!.isNotEmpty)
                  _buildSection(
                    title: 'Skills',
                    content: widget.worker.skills!.map((s) => '• $s').join('\n'),
                  ),

                // Details Section
                _buildSection(
                  title: 'Details',
                  content: '''
Location: ${widget.worker.location}
${widget.worker.availability != null ? 'Availability: ${widget.worker.availability!}\n' : ''}
''',
                ),

                // Portfolio Link
                if (widget.worker.portfolioLink != null)
                  _buildSection(
                    title: 'Portfolio',
                    content: widget.worker.portfolioLink!,
                    isLink: true,
                  ),

                const SizedBox(height: 24),
              ],
            ),
          ),

          // Floating Contact Button
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: SizedBox(
              height: 52,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF3E8728),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  shadowColor: const Color(0xFF1C58F2).withOpacity(0.1),
                ),
                onPressed: () {},
                child: const Text(
                  'CONTACT WORKER',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    letterSpacing: 1,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String content,
    bool expanded = false,
    bool isLink = false,
    VoidCallback? onExpand,
  }) {
    const maxLines = 3;
    final shouldShowExpand = content.split('\n').length > maxLines || 
                           content.length > 150;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(24),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 11.5,
              letterSpacing: 0.75,
              color: Colors.black.withOpacity(0.75),
            ),
          ),
          const SizedBox(height: 8),
          if (isLink)
            InkWell(
              onTap: () {
                // Handle link tap
              },
              child: Text(
                content,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.5,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          else
            Text(
              content,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                height: 1.5,
              ),
              maxLines: expanded ? null : maxLines,
              overflow: expanded ? null : TextOverflow.ellipsis,
            ),
          if (shouldShowExpand && onExpand != null) ...[
            const SizedBox(height: 8),
            GestureDetector(
              onTap: onExpand,
              child: Text(
                expanded ? 'SHOW LESS' : 'READ MORE',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  letterSpacing: 0.25,
                  color: Color(0xFF3E8728),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _DetailChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  
  const _DetailChip({required this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: icon != null 
          ? const EdgeInsets.only(left: 4, right: 8)
          : EdgeInsets.zero,
      label: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ),
      avatar: icon != null 
          ? Icon(icon, size: 16, color: Colors.grey[600])
          : null,
      backgroundColor: Colors.grey[200],
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }
}