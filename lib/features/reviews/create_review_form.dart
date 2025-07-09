// lib/features/reviews/forms/create_review_form.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/models/getjob/getjob_model.dart';
import 'package:workdey_frontend/core/providers/review_provider.dart';

class CreateReviewForm extends ConsumerStatefulWidget {
  final String reviewType; // 'JOB_EMP_WORKER', 'JOB_WORKER_EMP', 'SERVICE_CLIENT'
  final Job? job;
  final int? applicationId;
  final int? workerProfileId;
  final int? serviceCompletionId;

  const CreateReviewForm({
    super.key,
    required this.reviewType,
    this.job,
    this.applicationId,
    this.workerProfileId,
    this.serviceCompletionId,
  });

  @override
  ConsumerState<CreateReviewForm> createState() => _CreateReviewFormState();
}

class _CreateReviewFormState extends ConsumerState<CreateReviewForm> {
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();
  
  int _overallRating = 0;
  String? _workComplexity;
  bool _wouldWorkAgain = false;
  bool _isLoading = false;
  
  // Category ratings
  final Map<String, int> _categoryRatings = {
    'communication': 0,
    'quality': 0,
    'timeliness': 0,
    'professionalism': 0,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getFormTitle()),
        backgroundColor: const Color(0xFF3E8728),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: _isLoading
          ? _buildLoadingState()
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderInfo(),
                    const SizedBox(height: 24),
                    _buildOverallRating(),
                    const SizedBox(height: 24),
                    _buildCategoryRatings(),
                    const SizedBox(height: 24),
                    _buildCommentSection(),
                    const SizedBox(height: 24),
                    _buildAdditionalQuestions(),
                    const SizedBox(height: 32),
                    _buildSubmitButton(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Color(0xFF3E8728)),
          SizedBox(height: 16),
          Text('Submitting your review...'),
        ],
      ),
    );
  }

  Widget _buildHeaderInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF3E8728).withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF3E8728).withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _getReviewIcon(),
                color: const Color(0xFF3E8728),
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  _getReviewContextTitle(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            _getReviewDescription(),
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
          if (widget.job != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.job!.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF3E8728),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.job!.locationDisplayText,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOverallRating() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Overall Rating *',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'How would you rate your overall experience?',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
          
          // Star rating
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return GestureDetector(
                onTap: () => setState(() => _overallRating = index + 1),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    index < _overallRating ? Icons.star : Icons.star_border,
                    size: 40,
                    color: Colors.amber,
                  ),
                ),
              );
            }),
          ),
          
          const SizedBox(height: 12),
          
          // Rating label
          if (_overallRating > 0)
            Center(
              child: Text(
                _getRatingLabel(_overallRating),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: _getRatingColor(_overallRating),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCategoryRatings() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Detailed Ratings',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Rate specific aspects of the experience',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
          
          ..._categoryRatings.entries.map((entry) {
            return _buildCategoryRatingRow(entry.key, entry.value);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildCategoryRatingRow(String category, int rating) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _getCategoryDisplayName(category),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          
          Row(
            children: [
              Expanded(
                child: Row(
                  children: List.generate(5, (index) {
                    return GestureDetector(
                      onTap: () => setState(() => _categoryRatings[category] = index + 1),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        child: Icon(
                          index < rating ? Icons.star : Icons.star_border,
                          size: 24,
                          color: Colors.amber,
                        ),
                      ),
                    );
                  }),
                ),
              ),
              if (rating > 0)
                Text(
                  '$rating/5',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _getRatingColor(rating),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCommentSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Written Review',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Share your experience in detail (optional)',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          
          TextFormField(
            controller: _commentController,
            maxLines: 4,
            maxLength: 500,
            decoration: InputDecoration(
              hintText: 'Describe your experience working with this ${_getReviewSubject()}...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF3E8728), width: 2),
              ),
              filled: true,
              fillColor: Colors.grey[50],
            ),
            validator: (value) {
              if (value != null && value.trim().isNotEmpty && value.trim().length < 10) {
                return 'Review must be at least 10 characters long';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalQuestions() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Additional Questions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          
          // Work complexity
          const Text(
            'Work Complexity',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          
          Wrap(
            spacing: 8,
            children: ['SIMPLE', 'MODERATE', 'COMPLEX'].map((complexity) {
              final isSelected = _workComplexity == complexity;
              return FilterChip(
                label: Text(_getComplexityDisplay(complexity)),
                selected: isSelected,
                onSelected: (selected) => setState(() => 
                  _workComplexity = selected ? complexity : null
                ),
                backgroundColor: Colors.grey[100],
                selectedColor: const Color(0xFF3E8728).withOpacity(0.2),
                checkmarkColor: const Color(0xFF3E8728),
              );
            }).toList(),
          ),
          
          const SizedBox(height: 20),
          
          // Would work again
          Row(
            children: [
              Checkbox(
                value: _wouldWorkAgain,
                onChanged: (value) => setState(() => _wouldWorkAgain = value ?? false),
                activeColor: const Color(0xFF3E8728),
              ),
              Expanded(
                child: Text(
                  'I would ${_getWorkAgainText()} this ${_getReviewSubject()} again',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    final isValid = _overallRating > 0;
    
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isValid && !_isLoading ? _submitReview : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3E8728),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 2,
        ),
        child: _isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Text(
                'Submit Review',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  Future<void> _submitReview() async {
    if (!_formKey.currentState!.validate() || _overallRating == 0) return;

    setState(() => _isLoading = true);

    try {
      // Filter out category ratings with value > 0
      final filteredCategoryRatings = Map<String, int>.fromEntries(
        _categoryRatings.entries.where((entry) => entry.value > 0)
      );

      final reviewData = {
        'review_type': widget.reviewType,
        'overall_rating': _overallRating,
        'comment': _commentController.text.trim(),
        'category_ratings': filteredCategoryRatings,
        'work_complexity': _workComplexity,
        'would_work_again': _wouldWorkAgain,
        if (widget.applicationId != null) 'application_id': widget.applicationId,
        if (widget.serviceCompletionId != null) 
          'service_completion_id': widget.serviceCompletionId,
      };

      // Call the appropriate review creation method based on type
      if (widget.reviewType.startsWith('JOB_')) {
        await ref.read(reviewProvider.notifier).createJobReview(reviewData);
      } else {
        await ref.read(reviewProvider.notifier).createServiceReview(reviewData);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Review submitted successfully'),
            backgroundColor: Color(0xFF3E8728),
          ),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Error submitting review: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  // Helper methods
  String _getFormTitle() {
    switch (widget.reviewType) {
      case 'JOB_EMP_WORKER':
        return 'Review Worker';
      case 'JOB_WORKER_EMP':
        return 'Review Employer';
      case 'SERVICE_CLIENT':
        return 'Review Service';
      default:
        return 'Create Review';
    }
  }

  IconData _getReviewIcon() {
    switch (widget.reviewType) {
      case 'JOB_EMP_WORKER':
        return Icons.work_outline;
      case 'JOB_WORKER_EMP':
        return Icons.person_outline;
      case 'SERVICE_CLIENT':
        return Icons.handyman_outlined;
      default:
        return Icons.star_outline;
    }
  }

  String _getReviewContextTitle() {
    switch (widget.reviewType) {
      case 'JOB_EMP_WORKER':
        return 'Job Worker Review';
      case 'JOB_WORKER_EMP':
        return 'Employer Review';
      case 'SERVICE_CLIENT':
        return 'Service Review';
      default:
        return 'Review';
    }
  }

  String _getReviewDescription() {
    switch (widget.reviewType) {
      case 'JOB_EMP_WORKER':
        return 'Share your experience working with this worker. Your feedback helps build trust in the community.';
      case 'JOB_WORKER_EMP':
        return 'Rate your experience with this employer. Help other workers make informed decisions.';
      case 'SERVICE_CLIENT':
        return 'How was your experience with this service provider? Your review helps others choose quality services.';
      default:
        return 'Share your experience to help build trust in the community.';
    }
  }

  String _getReviewSubject() {
    switch (widget.reviewType) {
      case 'JOB_EMP_WORKER':
        return 'worker';
      case 'JOB_WORKER_EMP':
        return 'employer';
      case 'SERVICE_CLIENT':
        return 'service provider';
      default:
        return 'person';
    }
  }

  String _getWorkAgainText() {
    switch (widget.reviewType) {
      case 'JOB_EMP_WORKER':
        return 'hire';
      case 'JOB_WORKER_EMP':
        return 'work for';
      case 'SERVICE_CLIENT':
        return 'use services from';
      default:
        return 'work with';
    }
  }

  String _getRatingLabel(int rating) {
    switch (rating) {
      case 5: return 'Excellent';
      case 4: return 'Very Good';
      case 3: return 'Good';
      case 2: return 'Fair';
      case 1: return 'Poor';
      default: return '';
    }
  }

  Color _getRatingColor(int rating) {
    if (rating >= 4) return Colors.green;
    if (rating >= 3) return Colors.orange;
    return Colors.red;
  }

  String _getCategoryDisplayName(String category) {
    switch (category) {
      case 'communication': return 'Communication';
      case 'quality': return 'Work Quality';
      case 'timeliness': return 'Timeliness';
      case 'professionalism': return 'Professionalism';
      default: return category;
    }
  }

  String _getComplexityDisplay(String complexity) {
    switch (complexity) {
      case 'SIMPLE': return 'Simple';
      case 'MODERATE': return 'Moderate';
      case 'COMPLEX': return 'Complex';
      default: return complexity;
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}