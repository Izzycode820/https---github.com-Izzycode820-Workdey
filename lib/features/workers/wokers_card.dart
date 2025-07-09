import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/getworkers/get_workers_model.dart';
import 'package:workdey_frontend/core/providers/saved_worker_provider.dart';
import 'package:workdey_frontend/features/workers/get_worker_bottom_sheet.dart';
import 'package:workdey_frontend/features/workers/workers_bookmark.dart';

class WorkerCard extends ConsumerWidget {
  final Worker worker;
  final VoidCallback? onTap;
  final Function(int)? onBookmarkPressed;

  const WorkerCard({
    super.key,
    required this.worker,
    this.onTap,
    this.onBookmarkPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSaved = ref.watch(savedWorkersProvider).maybeWhen(
      data: (data) => data.results.any((w) => w.id == worker.id),
      orElse: () => worker.isSaved,
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 1), // Minimal gap like LinkedIn
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[300]!,
            width: 1.5,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(isSaved),
                const SizedBox(height: 8),
                _buildWorkerTitle(),
                const SizedBox(height: 4),
                _buildWorkerInfo(),
                const SizedBox(height: 6),
                _buildLocation(),
                const SizedBox(height: 10),
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isSaved) {
    return Row(
      children: [
        // Post time
        Text(
          worker.postTime ?? 'Recently',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Colors.red[600],
          ),
        ),
        const SizedBox(width: 8),
        // Category chip
        _buildCategoryChip(),
        const Spacer(),
        // Bookmark
        WorkerBookmarkWidget(
          workerId: worker.id,
          isSaved: isSaved,
        ),
      ],
    );
  }

  Widget _buildCategoryChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: _getCategoryColor(worker.category).withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        worker.categoryDisplay ?? worker.category,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: _getCategoryColor(worker.category),
        ),
      ),
    );
  }

  Widget _buildWorkerTitle() {
    return Text(
      worker.title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.2,
        color: Color(0xFF181A1F),
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildWorkerInfo() {
    return Row(
      children: [
        // Worker avatar
        CircleAvatar(
          radius: 10,
          backgroundColor: Colors.grey[200],
          backgroundImage: worker.profilePicture != null 
              ? NetworkImage(worker.profilePicture!) 
              : null,
          child: worker.profilePicture == null 
              ? Icon(
                  Icons.person, 
                  size: 12, 
                  color: Colors.grey[600],
                )
              : null,
        ),
        const SizedBox(width: 6),
        // Worker name
        Expanded(
          child: Text(
            worker.userName ?? 'Anonymous',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF181A1F),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 6),
        // Verification badges
        _buildVerificationBadges(),
        const SizedBox(width: 8),
        // Experience chip
        if (worker.experienceYears != null)
          _buildExperienceChip(),
      ],
    );
  }

  Widget _buildVerificationBadges() {
    if (worker.verificationBadges == null) return const SizedBox.shrink();
    
    final badges = worker.verificationBadges!;
    final verifiedCount = [
      badges['email'] == true,
      badges['phone'] == true,
      badges['id'] == true,
    ].where((v) => v).length;

    if (verifiedCount == 0) return const SizedBox.shrink();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.verified,
          size: 12,
          color: verifiedCount == 3 ? Colors.green[600] : Colors.blue[600],
        ),
        if (verifiedCount < 3) ...[
          const SizedBox(width: 2),
          Text(
            '$verifiedCount/3',
            style: TextStyle(
              fontSize: 9,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildExperienceChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.purple[50],
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Colors.purple[300]!,
          width: 0.5,
        ),
      ),
      child: Text(
        '${worker.experienceYears}yr',
        style: TextStyle(
          fontSize: 9,
          color: Colors.purple[700],
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildLocation() {
    return Row(
      children: [
        Icon(
          Icons.location_on,
          size: 12,
          color: Colors.grey[500],
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            worker.location,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
              fontWeight: FontWeight.w400,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Row(
      children: [
        // Skills preview (max 2)
        if (worker.skills != null && worker.skills!.isNotEmpty) ...[
          _buildInfoChip(worker.skills!.first, Colors.blue),
          if (worker.skills!.length > 1) ...[
            const SizedBox(width: 6),
            _buildInfoChip(worker.skills![1], Colors.blue),
          ],
          if (worker.skills!.length > 2) ...[
            const SizedBox(width: 6),
            Text(
              '+${worker.skills!.length - 2}',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
        const Spacer(),
        // Availability
        if (worker.availability != null)
          _buildAvailabilityChip(),
      ],
    );
  }

  Widget _buildInfoChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          color: Colors.green[700],
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildAvailabilityChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.green[200]!, width: 0.5),
      ),
      child: Text(
        _getAvailabilityText(worker.availability!),
        style: TextStyle(
          fontSize: 10,
          color: Colors.green[700],
          fontWeight: FontWeight.w600,
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

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'plumber':
        return Colors.blue;
      case 'electrician':
        return Colors.orange;
      case 'carpenter':
        return Colors.brown;
      case 'cleaner':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final Color color;
  
  const _InfoChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}