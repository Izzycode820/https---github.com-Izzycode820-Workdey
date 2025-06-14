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
  User get user => throw _privateConstructorUsedError;
  List<Skill> get skills => throw _privateConstructorUsedError;
  List<Experience> get experiences => throw _privateConstructorUsedError;
  List<Education> get educations => throw _privateConstructorUsedError;
  List<Review> get reviews => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

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
      String? transport,
      List<String> availability,
      @JsonKey(name: 'willing_to_learn') bool willingToLearn,
      @JsonKey(name: 'rating', defaultValue: 0.0) double rating,
      @JsonKey(name: 'jobs_completed', defaultValue: 0) int jobsCompleted,
      @JsonKey(name: 'verification_badges')
      Map<String, dynamic> verificationBadges,
      User user,
      List<Skill> skills,
      List<Experience> experiences,
      List<Education> educations,
      List<Review> reviews,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});

  $UserCopyWith<$Res> get user;
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
    Object? transport = freezed,
    Object? availability = null,
    Object? willingToLearn = null,
    Object? rating = null,
    Object? jobsCompleted = null,
    Object? verificationBadges = null,
    Object? user = null,
    Object? skills = null,
    Object? experiences = null,
    Object? educations = null,
    Object? reviews = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
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
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
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
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
      String? transport,
      List<String> availability,
      @JsonKey(name: 'willing_to_learn') bool willingToLearn,
      @JsonKey(name: 'rating', defaultValue: 0.0) double rating,
      @JsonKey(name: 'jobs_completed', defaultValue: 0) int jobsCompleted,
      @JsonKey(name: 'verification_badges')
      Map<String, dynamic> verificationBadges,
      User user,
      List<Skill> skills,
      List<Experience> experiences,
      List<Education> educations,
      List<Review> reviews,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'updated_at') DateTime? updatedAt});

  @override
  $UserCopyWith<$Res> get user;
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
    Object? transport = freezed,
    Object? availability = null,
    Object? willingToLearn = null,
    Object? rating = null,
    Object? jobsCompleted = null,
    Object? verificationBadges = null,
    Object? user = null,
    Object? skills = null,
    Object? experiences = null,
    Object? educations = null,
    Object? reviews = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
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
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
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
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
      this.transport,
      required final List<String> availability,
      @JsonKey(name: 'willing_to_learn') required this.willingToLearn,
      @JsonKey(name: 'rating', defaultValue: 0.0) required this.rating,
      @JsonKey(name: 'jobs_completed', defaultValue: 0)
      required this.jobsCompleted,
      @JsonKey(name: 'verification_badges')
      required final Map<String, dynamic> verificationBadges,
      required this.user,
      required final List<Skill> skills,
      required final List<Experience> experiences,
      required final List<Education> educations,
      required final List<Review> reviews,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'updated_at') this.updatedAt})
      : _availability = availability,
        _verificationBadges = verificationBadges,
        _skills = skills,
        _experiences = experiences,
        _educations = educations,
        _reviews = reviews,
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
  final User user;
  final List<Skill> _skills;
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

  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserProfile(id: $id, bio: $bio, location: $location, transport: $transport, availability: $availability, willingToLearn: $willingToLearn, rating: $rating, jobsCompleted: $jobsCompleted, verificationBadges: $verificationBadges, user: $user, skills: $skills, experiences: $experiences, educations: $educations, reviews: $reviews, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserProfile'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('bio', bio))
      ..add(DiagnosticsProperty('location', location))
      ..add(DiagnosticsProperty('transport', transport))
      ..add(DiagnosticsProperty('availability', availability))
      ..add(DiagnosticsProperty('willingToLearn', willingToLearn))
      ..add(DiagnosticsProperty('rating', rating))
      ..add(DiagnosticsProperty('jobsCompleted', jobsCompleted))
      ..add(DiagnosticsProperty('verificationBadges', verificationBadges))
      ..add(DiagnosticsProperty('user', user))
      ..add(DiagnosticsProperty('skills', skills))
      ..add(DiagnosticsProperty('experiences', experiences))
      ..add(DiagnosticsProperty('educations', educations))
      ..add(DiagnosticsProperty('reviews', reviews))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt));
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
            (identical(other.user, user) || other.user == user) &&
            const DeepCollectionEquality().equals(other._skills, _skills) &&
            const DeepCollectionEquality()
                .equals(other._experiences, _experiences) &&
            const DeepCollectionEquality()
                .equals(other._educations, _educations) &&
            const DeepCollectionEquality().equals(other._reviews, _reviews) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      bio,
      location,
      transport,
      const DeepCollectionEquality().hash(_availability),
      willingToLearn,
      rating,
      jobsCompleted,
      const DeepCollectionEquality().hash(_verificationBadges),
      user,
      const DeepCollectionEquality().hash(_skills),
      const DeepCollectionEquality().hash(_experiences),
      const DeepCollectionEquality().hash(_educations),
      const DeepCollectionEquality().hash(_reviews),
      createdAt,
      updatedAt);

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
      final String? transport,
      required final List<String> availability,
      @JsonKey(name: 'willing_to_learn') required final bool willingToLearn,
      @JsonKey(name: 'rating', defaultValue: 0.0) required final double rating,
      @JsonKey(name: 'jobs_completed', defaultValue: 0)
      required final int jobsCompleted,
      @JsonKey(name: 'verification_badges')
      required final Map<String, dynamic> verificationBadges,
      required final User user,
      required final List<Skill> skills,
      required final List<Experience> experiences,
      required final List<Education> educations,
      required final List<Review> reviews,
      @JsonKey(name: 'created_at') final DateTime? createdAt,
      @JsonKey(name: 'updated_at')
      final DateTime? updatedAt}) = _$UserProfileImpl;
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
  User get user;
  @override
  List<Skill> get skills;
  @override
  List<Experience> get experiences;
  @override
  List<Education> get educations;
  @override
  List<Review> get reviews;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
