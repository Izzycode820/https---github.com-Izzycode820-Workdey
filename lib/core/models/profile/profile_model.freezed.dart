// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return _UserProfile.fromJson(json);
}

/// @nodoc
mixin _$UserProfile {
  int? get id => throw _privateConstructorUsedError;
  String get bio => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get district => throw _privateConstructorUsedError;
  String? get transport => throw _privateConstructorUsedError;
  List<String> get availability => throw _privateConstructorUsedError;
  @JsonKey(name: 'willing_to_learn')
  bool get willingToLearn => throw _privateConstructorUsedError;
  @JsonKey(name: 'rating', defaultValue: 0.0)
  double get rating => throw _privateConstructorUsedError;
  @JsonKey(name: 'jobs_completed', defaultValue: 0)
  int get jobsCompleted => throw _privateConstructorUsedError;
  @JsonKey(name: 'verification_badges')
  Map<String, dynamic> get verificationBadges =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt =>
      throw _privateConstructorUsedError; // User information
  User get user => throw _privateConstructorUsedError; // Trust system data
  @JsonKey(name: 'trust_score')
  TrustScore? get trustScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'recent_reviews')
  List<Review>? get recentReviews => throw _privateConstructorUsedError;
  @JsonKey(name: 'review_summary')
  ReviewSummary? get reviewSummary =>
      throw _privateConstructorUsedError; // Profile components
  List<Skill> get skills => throw _privateConstructorUsedError;
  List<Experience> get experiences => throw _privateConstructorUsedError;
  List<Education> get educations => throw _privateConstructorUsedError;
  List<Review> get reviews =>
      throw _privateConstructorUsedError; // Additional profile data
  @JsonKey(name: 'profile_completeness')
  int? get profileCompleteness => throw _privateConstructorUsedError;
  @JsonKey(name: 'languages_spoken')
  List<String>? get languagesSpoken => throw _privateConstructorUsedError;
  @JsonKey(name: 'preferred_job_types')
  List<String>? get preferredJobTypes => throw _privateConstructorUsedError;
  @JsonKey(name: 'hourly_rate_min')
  double? get hourlyRateMin => throw _privateConstructorUsedError;
  @JsonKey(name: 'hourly_rate_max')
  double? get hourlyRateMax => throw _privateConstructorUsedError;
  @JsonKey(name: 'portfolio_links')
  List<String>? get portfolioLinks =>
      throw _privateConstructorUsedError; // Privacy settings
  @JsonKey(name: 'profile_visibility')
  String? get profileVisibility => throw _privateConstructorUsedError;
  @JsonKey(name: 'show_contact_info')
  bool? get showContactInfo => throw _privateConstructorUsedError;
  @JsonKey(name: 'show_location')
  bool? get showLocation => throw _privateConstructorUsedError;

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileCopyWith<UserProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileCopyWith<$Res> {
  factory $UserProfileCopyWith(
          UserProfile value, $Res Function(UserProfile) then) =
      _$UserProfileCopyWithImpl<$Res, UserProfile>;
  @useResult
  $Res call(
      {int? id,
      String bio,
      String? location,
      String? city,
      String? district,
      String? transport,
      List<String> availability,
      @JsonKey(name: 'willing_to_learn') bool willingToLearn,
      @JsonKey(name: 'rating', defaultValue: 0.0) double rating,
      @JsonKey(name: 'jobs_completed', defaultValue: 0) int jobsCompleted,
      @JsonKey(name: 'verification_badges')
      Map<String, dynamic> verificationBadges,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      User user,
      @JsonKey(name: 'trust_score') TrustScore? trustScore,
      @JsonKey(name: 'recent_reviews') List<Review>? recentReviews,
      @JsonKey(name: 'review_summary') ReviewSummary? reviewSummary,
      List<Skill> skills,
      List<Experience> experiences,
      List<Education> educations,
      List<Review> reviews,
      @JsonKey(name: 'profile_completeness') int? profileCompleteness,
      @JsonKey(name: 'languages_spoken') List<String>? languagesSpoken,
      @JsonKey(name: 'preferred_job_types') List<String>? preferredJobTypes,
      @JsonKey(name: 'hourly_rate_min') double? hourlyRateMin,
      @JsonKey(name: 'hourly_rate_max') double? hourlyRateMax,
      @JsonKey(name: 'portfolio_links') List<String>? portfolioLinks,
      @JsonKey(name: 'profile_visibility') String? profileVisibility,
      @JsonKey(name: 'show_contact_info') bool? showContactInfo,
      @JsonKey(name: 'show_location') bool? showLocation});

  $UserCopyWith<$Res> get user;
  $TrustScoreCopyWith<$Res>? get trustScore;
  $ReviewSummaryCopyWith<$Res>? get reviewSummary;
}

/// @nodoc
class _$UserProfileCopyWithImpl<$Res, $Val extends UserProfile>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? bio = null,
    Object? location = freezed,
    Object? city = freezed,
    Object? district = freezed,
    Object? transport = freezed,
    Object? availability = null,
    Object? willingToLearn = null,
    Object? rating = null,
    Object? jobsCompleted = null,
    Object? verificationBadges = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? user = null,
    Object? trustScore = freezed,
    Object? recentReviews = freezed,
    Object? reviewSummary = freezed,
    Object? skills = null,
    Object? experiences = null,
    Object? educations = null,
    Object? reviews = null,
    Object? profileCompleteness = freezed,
    Object? languagesSpoken = freezed,
    Object? preferredJobTypes = freezed,
    Object? hourlyRateMin = freezed,
    Object? hourlyRateMax = freezed,
    Object? portfolioLinks = freezed,
    Object? profileVisibility = freezed,
    Object? showContactInfo = freezed,
    Object? showLocation = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      bio: null == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      district: freezed == district
          ? _value.district
          : district // ignore: cast_nullable_to_non_nullable
              as String?,
      transport: freezed == transport
          ? _value.transport
          : transport // ignore: cast_nullable_to_non_nullable
              as String?,
      availability: null == availability
          ? _value.availability
          : availability // ignore: cast_nullable_to_non_nullable
              as List<String>,
      willingToLearn: null == willingToLearn
          ? _value.willingToLearn
          : willingToLearn // ignore: cast_nullable_to_non_nullable
              as bool,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      jobsCompleted: null == jobsCompleted
          ? _value.jobsCompleted
          : jobsCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      verificationBadges: null == verificationBadges
          ? _value.verificationBadges
          : verificationBadges // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      trustScore: freezed == trustScore
          ? _value.trustScore
          : trustScore // ignore: cast_nullable_to_non_nullable
              as TrustScore?,
      recentReviews: freezed == recentReviews
          ? _value.recentReviews
          : recentReviews // ignore: cast_nullable_to_non_nullable
              as List<Review>?,
      reviewSummary: freezed == reviewSummary
          ? _value.reviewSummary
          : reviewSummary // ignore: cast_nullable_to_non_nullable
              as ReviewSummary?,
      skills: null == skills
          ? _value.skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<Skill>,
      experiences: null == experiences
          ? _value.experiences
          : experiences // ignore: cast_nullable_to_non_nullable
              as List<Experience>,
      educations: null == educations
          ? _value.educations
          : educations // ignore: cast_nullable_to_non_nullable
              as List<Education>,
      reviews: null == reviews
          ? _value.reviews
          : reviews // ignore: cast_nullable_to_non_nullable
              as List<Review>,
      profileCompleteness: freezed == profileCompleteness
          ? _value.profileCompleteness
          : profileCompleteness // ignore: cast_nullable_to_non_nullable
              as int?,
      languagesSpoken: freezed == languagesSpoken
          ? _value.languagesSpoken
          : languagesSpoken // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      preferredJobTypes: freezed == preferredJobTypes
          ? _value.preferredJobTypes
          : preferredJobTypes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      hourlyRateMin: freezed == hourlyRateMin
          ? _value.hourlyRateMin
          : hourlyRateMin // ignore: cast_nullable_to_non_nullable
              as double?,
      hourlyRateMax: freezed == hourlyRateMax
          ? _value.hourlyRateMax
          : hourlyRateMax // ignore: cast_nullable_to_non_nullable
              as double?,
      portfolioLinks: freezed == portfolioLinks
          ? _value.portfolioLinks
          : portfolioLinks // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      profileVisibility: freezed == profileVisibility
          ? _value.profileVisibility
          : profileVisibility // ignore: cast_nullable_to_non_nullable
              as String?,
      showContactInfo: freezed == showContactInfo
          ? _value.showContactInfo
          : showContactInfo // ignore: cast_nullable_to_non_nullable
              as bool?,
      showLocation: freezed == showLocation
          ? _value.showLocation
          : showLocation // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TrustScoreCopyWith<$Res>? get trustScore {
    if (_value.trustScore == null) {
      return null;
    }

    return $TrustScoreCopyWith<$Res>(_value.trustScore!, (value) {
      return _then(_value.copyWith(trustScore: value) as $Val);
    });
  }

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReviewSummaryCopyWith<$Res>? get reviewSummary {
    if (_value.reviewSummary == null) {
      return null;
    }

    return $ReviewSummaryCopyWith<$Res>(_value.reviewSummary!, (value) {
      return _then(_value.copyWith(reviewSummary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserProfileImplCopyWith<$Res>
    implements $UserProfileCopyWith<$Res> {
  factory _$$UserProfileImplCopyWith(
          _$UserProfileImpl value, $Res Function(_$UserProfileImpl) then) =
      __$$UserProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String bio,
      String? location,
      String? city,
      String? district,
      String? transport,
      List<String> availability,
      @JsonKey(name: 'willing_to_learn') bool willingToLearn,
      @JsonKey(name: 'rating', defaultValue: 0.0) double rating,
      @JsonKey(name: 'jobs_completed', defaultValue: 0) int jobsCompleted,
      @JsonKey(name: 'verification_badges')
      Map<String, dynamic> verificationBadges,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt,
      User user,
      @JsonKey(name: 'trust_score') TrustScore? trustScore,
      @JsonKey(name: 'recent_reviews') List<Review>? recentReviews,
      @JsonKey(name: 'review_summary') ReviewSummary? reviewSummary,
      List<Skill> skills,
      List<Experience> experiences,
      List<Education> educations,
      List<Review> reviews,
      @JsonKey(name: 'profile_completeness') int? profileCompleteness,
      @JsonKey(name: 'languages_spoken') List<String>? languagesSpoken,
      @JsonKey(name: 'preferred_job_types') List<String>? preferredJobTypes,
      @JsonKey(name: 'hourly_rate_min') double? hourlyRateMin,
      @JsonKey(name: 'hourly_rate_max') double? hourlyRateMax,
      @JsonKey(name: 'portfolio_links') List<String>? portfolioLinks,
      @JsonKey(name: 'profile_visibility') String? profileVisibility,
      @JsonKey(name: 'show_contact_info') bool? showContactInfo,
      @JsonKey(name: 'show_location') bool? showLocation});

  @override
  $UserCopyWith<$Res> get user;
  @override
  $TrustScoreCopyWith<$Res>? get trustScore;
  @override
  $ReviewSummaryCopyWith<$Res>? get reviewSummary;
}

/// @nodoc
class __$$UserProfileImplCopyWithImpl<$Res>
    extends _$UserProfileCopyWithImpl<$Res, _$UserProfileImpl>
    implements _$$UserProfileImplCopyWith<$Res> {
  __$$UserProfileImplCopyWithImpl(
      _$UserProfileImpl _value, $Res Function(_$UserProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? bio = null,
    Object? location = freezed,
    Object? city = freezed,
    Object? district = freezed,
    Object? transport = freezed,
    Object? availability = null,
    Object? willingToLearn = null,
    Object? rating = null,
    Object? jobsCompleted = null,
    Object? verificationBadges = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? user = null,
    Object? trustScore = freezed,
    Object? recentReviews = freezed,
    Object? reviewSummary = freezed,
    Object? skills = null,
    Object? experiences = null,
    Object? educations = null,
    Object? reviews = null,
    Object? profileCompleteness = freezed,
    Object? languagesSpoken = freezed,
    Object? preferredJobTypes = freezed,
    Object? hourlyRateMin = freezed,
    Object? hourlyRateMax = freezed,
    Object? portfolioLinks = freezed,
    Object? profileVisibility = freezed,
    Object? showContactInfo = freezed,
    Object? showLocation = freezed,
  }) {
    return _then(_$UserProfileImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      bio: null == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      district: freezed == district
          ? _value.district
          : district // ignore: cast_nullable_to_non_nullable
              as String?,
      transport: freezed == transport
          ? _value.transport
          : transport // ignore: cast_nullable_to_non_nullable
              as String?,
      availability: null == availability
          ? _value._availability
          : availability // ignore: cast_nullable_to_non_nullable
              as List<String>,
      willingToLearn: null == willingToLearn
          ? _value.willingToLearn
          : willingToLearn // ignore: cast_nullable_to_non_nullable
              as bool,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      jobsCompleted: null == jobsCompleted
          ? _value.jobsCompleted
          : jobsCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      verificationBadges: null == verificationBadges
          ? _value._verificationBadges
          : verificationBadges // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      trustScore: freezed == trustScore
          ? _value.trustScore
          : trustScore // ignore: cast_nullable_to_non_nullable
              as TrustScore?,
      recentReviews: freezed == recentReviews
          ? _value._recentReviews
          : recentReviews // ignore: cast_nullable_to_non_nullable
              as List<Review>?,
      reviewSummary: freezed == reviewSummary
          ? _value.reviewSummary
          : reviewSummary // ignore: cast_nullable_to_non_nullable
              as ReviewSummary?,
      skills: null == skills
          ? _value._skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<Skill>,
      experiences: null == experiences
          ? _value._experiences
          : experiences // ignore: cast_nullable_to_non_nullable
              as List<Experience>,
      educations: null == educations
          ? _value._educations
          : educations // ignore: cast_nullable_to_non_nullable
              as List<Education>,
      reviews: null == reviews
          ? _value._reviews
          : reviews // ignore: cast_nullable_to_non_nullable
              as List<Review>,
      profileCompleteness: freezed == profileCompleteness
          ? _value.profileCompleteness
          : profileCompleteness // ignore: cast_nullable_to_non_nullable
              as int?,
      languagesSpoken: freezed == languagesSpoken
          ? _value._languagesSpoken
          : languagesSpoken // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      preferredJobTypes: freezed == preferredJobTypes
          ? _value._preferredJobTypes
          : preferredJobTypes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      hourlyRateMin: freezed == hourlyRateMin
          ? _value.hourlyRateMin
          : hourlyRateMin // ignore: cast_nullable_to_non_nullable
              as double?,
      hourlyRateMax: freezed == hourlyRateMax
          ? _value.hourlyRateMax
          : hourlyRateMax // ignore: cast_nullable_to_non_nullable
              as double?,
      portfolioLinks: freezed == portfolioLinks
          ? _value._portfolioLinks
          : portfolioLinks // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      profileVisibility: freezed == profileVisibility
          ? _value.profileVisibility
          : profileVisibility // ignore: cast_nullable_to_non_nullable
              as String?,
      showContactInfo: freezed == showContactInfo
          ? _value.showContactInfo
          : showContactInfo // ignore: cast_nullable_to_non_nullable
              as bool?,
      showLocation: freezed == showLocation
          ? _value.showLocation
          : showLocation // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$UserProfileImpl extends _UserProfile with DiagnosticableTreeMixin {
  const _$UserProfileImpl(
      {this.id,
      required this.bio,
      this.location,
      this.city,
      this.district,
      this.transport,
      required final List<String> availability,
      @JsonKey(name: 'willing_to_learn') required this.willingToLearn,
      @JsonKey(name: 'rating', defaultValue: 0.0) required this.rating,
      @JsonKey(name: 'jobs_completed', defaultValue: 0)
      required this.jobsCompleted,
      @JsonKey(name: 'verification_badges')
      required final Map<String, dynamic> verificationBadges,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt,
      required this.user,
      @JsonKey(name: 'trust_score') this.trustScore,
      @JsonKey(name: 'recent_reviews') final List<Review>? recentReviews,
      @JsonKey(name: 'review_summary') this.reviewSummary,
      required final List<Skill> skills,
      required final List<Experience> experiences,
      required final List<Education> educations,
      required final List<Review> reviews,
      @JsonKey(name: 'profile_completeness') this.profileCompleteness,
      @JsonKey(name: 'languages_spoken') final List<String>? languagesSpoken,
      @JsonKey(name: 'preferred_job_types')
      final List<String>? preferredJobTypes,
      @JsonKey(name: 'hourly_rate_min') this.hourlyRateMin,
      @JsonKey(name: 'hourly_rate_max') this.hourlyRateMax,
      @JsonKey(name: 'portfolio_links') final List<String>? portfolioLinks,
      @JsonKey(name: 'profile_visibility') this.profileVisibility,
      @JsonKey(name: 'show_contact_info') this.showContactInfo,
      @JsonKey(name: 'show_location') this.showLocation})
      : _availability = availability,
        _verificationBadges = verificationBadges,
        _recentReviews = recentReviews,
        _skills = skills,
        _experiences = experiences,
        _educations = educations,
        _reviews = reviews,
        _languagesSpoken = languagesSpoken,
        _preferredJobTypes = preferredJobTypes,
        _portfolioLinks = portfolioLinks,
        super._();

  factory _$UserProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileImplFromJson(json);

  @override
  final int? id;
  @override
  final String bio;
  @override
  final String? location;
  @override
  final String? city;
  @override
  final String? district;
  @override
  final String? transport;
  final List<String> _availability;
  @override
  List<String> get availability {
    if (_availability is EqualUnmodifiableListView) return _availability;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availability);
  }

  @override
  @JsonKey(name: 'willing_to_learn')
  final bool willingToLearn;
  @override
  @JsonKey(name: 'rating', defaultValue: 0.0)
  final double rating;
  @override
  @JsonKey(name: 'jobs_completed', defaultValue: 0)
  final int jobsCompleted;
  final Map<String, dynamic> _verificationBadges;
  @override
  @JsonKey(name: 'verification_badges')
  Map<String, dynamic> get verificationBadges {
    if (_verificationBadges is EqualUnmodifiableMapView)
      return _verificationBadges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_verificationBadges);
  }

  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
// User information
  @override
  final User user;
// Trust system data
  @override
  @JsonKey(name: 'trust_score')
  final TrustScore? trustScore;
  final List<Review>? _recentReviews;
  @override
  @JsonKey(name: 'recent_reviews')
  List<Review>? get recentReviews {
    final value = _recentReviews;
    if (value == null) return null;
    if (_recentReviews is EqualUnmodifiableListView) return _recentReviews;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'review_summary')
  final ReviewSummary? reviewSummary;
// Profile components
  final List<Skill> _skills;
// Profile components
  @override
  List<Skill> get skills {
    if (_skills is EqualUnmodifiableListView) return _skills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_skills);
  }

  final List<Experience> _experiences;
  @override
  List<Experience> get experiences {
    if (_experiences is EqualUnmodifiableListView) return _experiences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_experiences);
  }

  final List<Education> _educations;
  @override
  List<Education> get educations {
    if (_educations is EqualUnmodifiableListView) return _educations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_educations);
  }

  final List<Review> _reviews;
  @override
  List<Review> get reviews {
    if (_reviews is EqualUnmodifiableListView) return _reviews;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reviews);
  }

// Additional profile data
  @override
  @JsonKey(name: 'profile_completeness')
  final int? profileCompleteness;
  final List<String>? _languagesSpoken;
  @override
  @JsonKey(name: 'languages_spoken')
  List<String>? get languagesSpoken {
    final value = _languagesSpoken;
    if (value == null) return null;
    if (_languagesSpoken is EqualUnmodifiableListView) return _languagesSpoken;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _preferredJobTypes;
  @override
  @JsonKey(name: 'preferred_job_types')
  List<String>? get preferredJobTypes {
    final value = _preferredJobTypes;
    if (value == null) return null;
    if (_preferredJobTypes is EqualUnmodifiableListView)
      return _preferredJobTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'hourly_rate_min')
  final double? hourlyRateMin;
  @override
  @JsonKey(name: 'hourly_rate_max')
  final double? hourlyRateMax;
  final List<String>? _portfolioLinks;
  @override
  @JsonKey(name: 'portfolio_links')
  List<String>? get portfolioLinks {
    final value = _portfolioLinks;
    if (value == null) return null;
    if (_portfolioLinks is EqualUnmodifiableListView) return _portfolioLinks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// Privacy settings
  @override
  @JsonKey(name: 'profile_visibility')
  final String? profileVisibility;
  @override
  @JsonKey(name: 'show_contact_info')
  final bool? showContactInfo;
  @override
  @JsonKey(name: 'show_location')
  final bool? showLocation;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserProfile(id: $id, bio: $bio, location: $location, city: $city, district: $district, transport: $transport, availability: $availability, willingToLearn: $willingToLearn, rating: $rating, jobsCompleted: $jobsCompleted, verificationBadges: $verificationBadges, createdAt: $createdAt, updatedAt: $updatedAt, user: $user, trustScore: $trustScore, recentReviews: $recentReviews, reviewSummary: $reviewSummary, skills: $skills, experiences: $experiences, educations: $educations, reviews: $reviews, profileCompleteness: $profileCompleteness, languagesSpoken: $languagesSpoken, preferredJobTypes: $preferredJobTypes, hourlyRateMin: $hourlyRateMin, hourlyRateMax: $hourlyRateMax, portfolioLinks: $portfolioLinks, profileVisibility: $profileVisibility, showContactInfo: $showContactInfo, showLocation: $showLocation)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserProfile'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('bio', bio))
      ..add(DiagnosticsProperty('location', location))
      ..add(DiagnosticsProperty('city', city))
      ..add(DiagnosticsProperty('district', district))
      ..add(DiagnosticsProperty('transport', transport))
      ..add(DiagnosticsProperty('availability', availability))
      ..add(DiagnosticsProperty('willingToLearn', willingToLearn))
      ..add(DiagnosticsProperty('rating', rating))
      ..add(DiagnosticsProperty('jobsCompleted', jobsCompleted))
      ..add(DiagnosticsProperty('verificationBadges', verificationBadges))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt))
      ..add(DiagnosticsProperty('user', user))
      ..add(DiagnosticsProperty('trustScore', trustScore))
      ..add(DiagnosticsProperty('recentReviews', recentReviews))
      ..add(DiagnosticsProperty('reviewSummary', reviewSummary))
      ..add(DiagnosticsProperty('skills', skills))
      ..add(DiagnosticsProperty('experiences', experiences))
      ..add(DiagnosticsProperty('educations', educations))
      ..add(DiagnosticsProperty('reviews', reviews))
      ..add(DiagnosticsProperty('profileCompleteness', profileCompleteness))
      ..add(DiagnosticsProperty('languagesSpoken', languagesSpoken))
      ..add(DiagnosticsProperty('preferredJobTypes', preferredJobTypes))
      ..add(DiagnosticsProperty('hourlyRateMin', hourlyRateMin))
      ..add(DiagnosticsProperty('hourlyRateMax', hourlyRateMax))
      ..add(DiagnosticsProperty('portfolioLinks', portfolioLinks))
      ..add(DiagnosticsProperty('profileVisibility', profileVisibility))
      ..add(DiagnosticsProperty('showContactInfo', showContactInfo))
      ..add(DiagnosticsProperty('showLocation', showLocation));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.district, district) ||
                other.district == district) &&
            (identical(other.transport, transport) ||
                other.transport == transport) &&
            const DeepCollectionEquality()
                .equals(other._availability, _availability) &&
            (identical(other.willingToLearn, willingToLearn) ||
                other.willingToLearn == willingToLearn) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.jobsCompleted, jobsCompleted) ||
                other.jobsCompleted == jobsCompleted) &&
            const DeepCollectionEquality()
                .equals(other._verificationBadges, _verificationBadges) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.trustScore, trustScore) ||
                other.trustScore == trustScore) &&
            const DeepCollectionEquality()
                .equals(other._recentReviews, _recentReviews) &&
            (identical(other.reviewSummary, reviewSummary) ||
                other.reviewSummary == reviewSummary) &&
            const DeepCollectionEquality().equals(other._skills, _skills) &&
            const DeepCollectionEquality()
                .equals(other._experiences, _experiences) &&
            const DeepCollectionEquality()
                .equals(other._educations, _educations) &&
            const DeepCollectionEquality().equals(other._reviews, _reviews) &&
            (identical(other.profileCompleteness, profileCompleteness) ||
                other.profileCompleteness == profileCompleteness) &&
            const DeepCollectionEquality()
                .equals(other._languagesSpoken, _languagesSpoken) &&
            const DeepCollectionEquality()
                .equals(other._preferredJobTypes, _preferredJobTypes) &&
            (identical(other.hourlyRateMin, hourlyRateMin) ||
                other.hourlyRateMin == hourlyRateMin) &&
            (identical(other.hourlyRateMax, hourlyRateMax) ||
                other.hourlyRateMax == hourlyRateMax) &&
            const DeepCollectionEquality()
                .equals(other._portfolioLinks, _portfolioLinks) &&
            (identical(other.profileVisibility, profileVisibility) ||
                other.profileVisibility == profileVisibility) &&
            (identical(other.showContactInfo, showContactInfo) ||
                other.showContactInfo == showContactInfo) &&
            (identical(other.showLocation, showLocation) ||
                other.showLocation == showLocation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        bio,
        location,
        city,
        district,
        transport,
        const DeepCollectionEquality().hash(_availability),
        willingToLearn,
        rating,
        jobsCompleted,
        const DeepCollectionEquality().hash(_verificationBadges),
        createdAt,
        updatedAt,
        user,
        trustScore,
        const DeepCollectionEquality().hash(_recentReviews),
        reviewSummary,
        const DeepCollectionEquality().hash(_skills),
        const DeepCollectionEquality().hash(_experiences),
        const DeepCollectionEquality().hash(_educations),
        const DeepCollectionEquality().hash(_reviews),
        profileCompleteness,
        const DeepCollectionEquality().hash(_languagesSpoken),
        const DeepCollectionEquality().hash(_preferredJobTypes),
        hourlyRateMin,
        hourlyRateMax,
        const DeepCollectionEquality().hash(_portfolioLinks),
        profileVisibility,
        showContactInfo,
        showLocation
      ]);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      __$$UserProfileImplCopyWithImpl<_$UserProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileImplToJson(
      this,
    );
  }
}

abstract class _UserProfile extends UserProfile {
  const factory _UserProfile(
      {final int? id,
      required final String bio,
      final String? location,
      final String? city,
      final String? district,
      final String? transport,
      required final List<String> availability,
      @JsonKey(name: 'willing_to_learn') required final bool willingToLearn,
      @JsonKey(name: 'rating', defaultValue: 0.0) required final double rating,
      @JsonKey(name: 'jobs_completed', defaultValue: 0)
      required final int jobsCompleted,
      @JsonKey(name: 'verification_badges')
      required final Map<String, dynamic> verificationBadges,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'updated_at') final DateTime? updatedAt,
      required final User user,
      @JsonKey(name: 'trust_score') final TrustScore? trustScore,
      @JsonKey(name: 'recent_reviews') final List<Review>? recentReviews,
      @JsonKey(name: 'review_summary') final ReviewSummary? reviewSummary,
      required final List<Skill> skills,
      required final List<Experience> experiences,
      required final List<Education> educations,
      required final List<Review> reviews,
      @JsonKey(name: 'profile_completeness') final int? profileCompleteness,
      @JsonKey(name: 'languages_spoken') final List<String>? languagesSpoken,
      @JsonKey(name: 'preferred_job_types')
      final List<String>? preferredJobTypes,
      @JsonKey(name: 'hourly_rate_min') final double? hourlyRateMin,
      @JsonKey(name: 'hourly_rate_max') final double? hourlyRateMax,
      @JsonKey(name: 'portfolio_links') final List<String>? portfolioLinks,
      @JsonKey(name: 'profile_visibility') final String? profileVisibility,
      @JsonKey(name: 'show_contact_info') final bool? showContactInfo,
      @JsonKey(name: 'show_location')
      final bool? showLocation}) = _$UserProfileImpl;
  const _UserProfile._() : super._();

  factory _UserProfile.fromJson(Map<String, dynamic> json) =
      _$UserProfileImpl.fromJson;

  @override
  int? get id;
  @override
  String get bio;
  @override
  String? get location;
  @override
  String? get city;
  @override
  String? get district;
  @override
  String? get transport;
  @override
  List<String> get availability;
  @override
  @JsonKey(name: 'willing_to_learn')
  bool get willingToLearn;
  @override
  @JsonKey(name: 'rating', defaultValue: 0.0)
  double get rating;
  @override
  @JsonKey(name: 'jobs_completed', defaultValue: 0)
  int get jobsCompleted;
  @override
  @JsonKey(name: 'verification_badges')
  Map<String, dynamic> get verificationBadges;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt; // User information
  @override
  User get user; // Trust system data
  @override
  @JsonKey(name: 'trust_score')
  TrustScore? get trustScore;
  @override
  @JsonKey(name: 'recent_reviews')
  List<Review>? get recentReviews;
  @override
  @JsonKey(name: 'review_summary')
  ReviewSummary? get reviewSummary; // Profile components
  @override
  List<Skill> get skills;
  @override
  List<Experience> get experiences;
  @override
  List<Education> get educations;
  @override
  List<Review> get reviews; // Additional profile data
  @override
  @JsonKey(name: 'profile_completeness')
  int? get profileCompleteness;
  @override
  @JsonKey(name: 'languages_spoken')
  List<String>? get languagesSpoken;
  @override
  @JsonKey(name: 'preferred_job_types')
  List<String>? get preferredJobTypes;
  @override
  @JsonKey(name: 'hourly_rate_min')
  double? get hourlyRateMin;
  @override
  @JsonKey(name: 'hourly_rate_max')
  double? get hourlyRateMax;
  @override
  @JsonKey(name: 'portfolio_links')
  List<String>? get portfolioLinks; // Privacy settings
  @override
  @JsonKey(name: 'profile_visibility')
  String? get profileVisibility;
  @override
  @JsonKey(name: 'show_contact_info')
  bool? get showContactInfo;
  @override
  @JsonKey(name: 'show_location')
  bool? get showLocation;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
