// applicant_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'applicant_model.freezed.dart';
part 'applicant_model.g.dart';

@freezed
class Application with _$Application {
  const factory Application({
    required int id,
    @JsonKey(name: 'status') required String status,
    @JsonKey(name: 'applied_at') required DateTime appliedAt,
    @JsonKey(name: 'applicant_details') required ApplicantDetails details,
    @JsonKey(name: 'response') ApplicationResponse? response,
    @JsonKey(name: 'match_stats') MatchStats? matchStats,
    @JsonKey(name: 'completion') JobCompletion? completion,
  }) = _Application;

  factory Application.fromJson(Map<String, dynamic> json) => 
      _$ApplicationFromJson(json);
}

@freezed
class ApplicantDetails with _$ApplicantDetails {
  const factory ApplicantDetails({
    required String name,
    @JsonKey(defaultValue: 0) required int verification_level,
    @JsonKey(name: 'completed_jobs', defaultValue: 0) required int completedJobs,
  }) = _ApplicantDetails;

  factory ApplicantDetails.fromJson(Map<String, dynamic> json) => 
      _$ApplicantDetailsFromJson(json);
}


@freezed
class ApplicationResponse with _$ApplicationResponse {
  const factory ApplicationResponse({
    @JsonKey(name: 'skills_met') required List<String> skillsMet,
    @JsonKey(name: 'optional_skills_met') required List<String> optionalSkillsMet,
    required String notes,
  }) = _ApplicationResponse;

  factory ApplicationResponse.fromJson(Map<String, dynamic> json) => 
      _$ApplicationResponseFromJson(json);
}

@freezed
class MatchStats with _$MatchStats {
  const factory MatchStats({
    @JsonKey(name: 'required_match') required String requiredMatch,
    @JsonKey(name: 'optional_match') required int optionalMatch,
    required double percentage,
  }) = _MatchStats;

  factory MatchStats.fromJson(Map<String, dynamic> json) => 
      _$MatchStatsFromJson(json);
}

@freezed
class JobCompletion with _$JobCompletion {
  const factory JobCompletion({
    required int id,
    @JsonKey(name: 'employer_confirmed') required bool employerConfirmed,
    @JsonKey(name: 'worker_confirmed') required bool workerConfirmed,
    @JsonKey(name: 'employer_confirmed_at') DateTime? employerConfirmedAt,
    @JsonKey(name: 'worker_confirmed_at') DateTime? workerConfirmedAt,
    @JsonKey(name: 'actual_start_date') DateTime? actualStartDate,
    @JsonKey(name: 'actual_end_date') DateTime? actualEndDate,
    @JsonKey(name: 'final_payment') int? finalPayment,
    @JsonKey(name: 'completion_notes') String? completionNotes,
    @JsonKey(name: 'is_mutually_confirmed') required bool isMutuallyConfirmed,
    @JsonKey(name: 'can_confirm') Map<String, dynamic>? canConfirm,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _JobCompletion;

  factory JobCompletion.fromJson(Map<String, dynamic> json) => 
      _$JobCompletionFromJson(json);
}

// NEW: Convenience extensions for better UX
extension ApplicationX on Application {
  // Status checks
  bool get isPending => status == 'PENDING';
  bool get isApproved => status == 'APPROVED';
  bool get isRejected => status == 'REJECTED';
  bool get isCompleted => status == 'COMPLETED';
  
  // Action availability checks
  bool get canWorkerConfirmCompletion => completion != null && 
      completion!.employerConfirmed && !completion!.workerConfirmed;
  bool get canEmployerConfirmCompletion => completion != null && 
      completion!.workerConfirmed && !completion!.employerConfirmed;
  bool get canLeaveReview => completion?.isMutuallyConfirmed ?? false;
  
  // Status display helpers
  String get statusDisplayName {
    switch (status) {
      case 'PENDING':
        return 'Under Review';
      case 'APPROVED':
        return 'Approved';
      case 'REJECTED':
        return 'Not Selected';
      case 'COMPLETED':
        return 'Completed';
      default:
        return status;
    }
  }
  
  String get statusDescription {
    switch (status) {
      case 'PENDING':
        return 'Your application is being reviewed';
      case 'APPROVED':
        return 'You can now start this job';
      case 'REJECTED':
        return 'Unfortunately, you were not selected';
      case 'COMPLETED':
        return 'Job completed successfully';
      default:
        return 'Status unknown';
    }
  }
  
  // Time helpers
  Duration get timeSinceApplication => DateTime.now().difference(appliedAt);
  bool get isRecentApplication => timeSinceApplication.inHours < 24;
  
  // Action indicators
  bool get needsAction => isPending || isApproved || 
      (completion != null && !completion!.isMutuallyConfirmed);
  
  String get timeAgoString {
    final difference = timeSinceApplication;
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}

// NEW: Job Completion extensions
extension JobCompletionX on JobCompletion {
  bool get isPendingEmployerConfirmation => workerConfirmed && !employerConfirmed;
  bool get isPendingWorkerConfirmation => employerConfirmed && !workerConfirmed;
  bool get isPendingBothConfirmations => !employerConfirmed && !workerConfirmed;
  
  String get confirmationStatus {
    if (isMutuallyConfirmed) return 'Mutually Confirmed';
    if (isPendingEmployerConfirmation) return 'Waiting for Employer';
    if (isPendingWorkerConfirmation) return 'Waiting for Worker';
    return 'Pending Confirmation';
  }
  
  Duration? get jobDuration {
    if (actualStartDate != null && actualEndDate != null) {
      return actualEndDate!.difference(actualStartDate!);
    }
    return null;
  }
  
  bool get hasPaymentInfo => finalPayment != null && finalPayment! > 0;
  
  // Helper to get user-specific confirmation ability
  bool canUserConfirmAsEmployer(String userId) => 
      canConfirm?['can_confirm_as_employer'] ?? false;
  
  bool canUserConfirmAsWorker(String userId) => 
      canConfirm?['can_confirm_as_worker'] ?? false;
  
  bool get canUserLeaveReview => canConfirm?['can_review'] ?? false;
}