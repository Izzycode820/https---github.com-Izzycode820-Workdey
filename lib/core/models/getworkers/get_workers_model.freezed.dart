// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_workers_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Worker _$WorkerFromJson(Map<String, dynamic> json) {
  return _Worker.fromJson(json);
}

/// @nodoc
mixin _$Worker {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  int? get user => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  List<String>? get skills => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  String? get availability => throw _privateConstructorUsedError;
  @JsonKey(name: 'experience_years')
  int? get experienceYears => throw _privateConstructorUsedError;
  @JsonKey(name: 'portfolio_link')
  String? get portfolioLink =>
      throw _privateConstructorUsedError; // Computed fields
  @JsonKey(name: 'post_time')
  String? get postTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_display')
  String? get categoryDisplay => throw _privateConstructorUsedError;
  @JsonKey(name: 'verification_badges')
  Map<String, dynamic>? get verificationBadges =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'is_saved')
  bool get isSaved => throw _privateConstructorUsedError;
  @JsonKey(name: 'profile_picture')
  String? get profilePicture => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get userName => throw _privateConstructorUsedError;

  /// Serializes this Worker to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Worker
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkerCopyWith<Worker> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkerCopyWith<$Res> {
  factory $WorkerCopyWith(Worker value, $Res Function(Worker) then) =
      _$WorkerCopyWithImpl<$Res, Worker>;
  @useResult
  $Res call(
      {int id,
      String title,
      String category,
      int? user,
      String location,
      @JsonKey(name: 'created_at') DateTime createdAt,
      List<String>? skills,
      String? bio,
      String? availability,
      @JsonKey(name: 'experience_years') int? experienceYears,
      @JsonKey(name: 'portfolio_link') String? portfolioLink,
      @JsonKey(name: 'post_time') String? postTime,
      @JsonKey(name: 'category_display') String? categoryDisplay,
      @JsonKey(name: 'verification_badges')
      Map<String, dynamic>? verificationBadges,
      @JsonKey(name: 'is_saved') bool isSaved,
      @JsonKey(name: 'profile_picture') String? profilePicture,
      @JsonKey(name: 'name') String? userName});
}

/// @nodoc
class _$WorkerCopyWithImpl<$Res, $Val extends Worker>
    implements $WorkerCopyWith<$Res> {
  _$WorkerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Worker
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? category = null,
    Object? user = freezed,
    Object? location = null,
    Object? createdAt = null,
    Object? skills = freezed,
    Object? bio = freezed,
    Object? availability = freezed,
    Object? experienceYears = freezed,
    Object? portfolioLink = freezed,
    Object? postTime = freezed,
    Object? categoryDisplay = freezed,
    Object? verificationBadges = freezed,
    Object? isSaved = null,
    Object? profilePicture = freezed,
    Object? userName = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as int?,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      skills: freezed == skills
          ? _value.skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      availability: freezed == availability
          ? _value.availability
          : availability // ignore: cast_nullable_to_non_nullable
              as String?,
      experienceYears: freezed == experienceYears
          ? _value.experienceYears
          : experienceYears // ignore: cast_nullable_to_non_nullable
              as int?,
      portfolioLink: freezed == portfolioLink
          ? _value.portfolioLink
          : portfolioLink // ignore: cast_nullable_to_non_nullable
              as String?,
      postTime: freezed == postTime
          ? _value.postTime
          : postTime // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryDisplay: freezed == categoryDisplay
          ? _value.categoryDisplay
          : categoryDisplay // ignore: cast_nullable_to_non_nullable
              as String?,
      verificationBadges: freezed == verificationBadges
          ? _value.verificationBadges
          : verificationBadges // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      isSaved: null == isSaved
          ? _value.isSaved
          : isSaved // ignore: cast_nullable_to_non_nullable
              as bool,
      profilePicture: freezed == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkerImplCopyWith<$Res> implements $WorkerCopyWith<$Res> {
  factory _$$WorkerImplCopyWith(
          _$WorkerImpl value, $Res Function(_$WorkerImpl) then) =
      __$$WorkerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String category,
      int? user,
      String location,
      @JsonKey(name: 'created_at') DateTime createdAt,
      List<String>? skills,
      String? bio,
      String? availability,
      @JsonKey(name: 'experience_years') int? experienceYears,
      @JsonKey(name: 'portfolio_link') String? portfolioLink,
      @JsonKey(name: 'post_time') String? postTime,
      @JsonKey(name: 'category_display') String? categoryDisplay,
      @JsonKey(name: 'verification_badges')
      Map<String, dynamic>? verificationBadges,
      @JsonKey(name: 'is_saved') bool isSaved,
      @JsonKey(name: 'profile_picture') String? profilePicture,
      @JsonKey(name: 'name') String? userName});
}

/// @nodoc
class __$$WorkerImplCopyWithImpl<$Res>
    extends _$WorkerCopyWithImpl<$Res, _$WorkerImpl>
    implements _$$WorkerImplCopyWith<$Res> {
  __$$WorkerImplCopyWithImpl(
      _$WorkerImpl _value, $Res Function(_$WorkerImpl) _then)
      : super(_value, _then);

  /// Create a copy of Worker
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? category = null,
    Object? user = freezed,
    Object? location = null,
    Object? createdAt = null,
    Object? skills = freezed,
    Object? bio = freezed,
    Object? availability = freezed,
    Object? experienceYears = freezed,
    Object? portfolioLink = freezed,
    Object? postTime = freezed,
    Object? categoryDisplay = freezed,
    Object? verificationBadges = freezed,
    Object? isSaved = null,
    Object? profilePicture = freezed,
    Object? userName = freezed,
  }) {
    return _then(_$WorkerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as int?,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      skills: freezed == skills
          ? _value._skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      availability: freezed == availability
          ? _value.availability
          : availability // ignore: cast_nullable_to_non_nullable
              as String?,
      experienceYears: freezed == experienceYears
          ? _value.experienceYears
          : experienceYears // ignore: cast_nullable_to_non_nullable
              as int?,
      portfolioLink: freezed == portfolioLink
          ? _value.portfolioLink
          : portfolioLink // ignore: cast_nullable_to_non_nullable
              as String?,
      postTime: freezed == postTime
          ? _value.postTime
          : postTime // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryDisplay: freezed == categoryDisplay
          ? _value.categoryDisplay
          : categoryDisplay // ignore: cast_nullable_to_non_nullable
              as String?,
      verificationBadges: freezed == verificationBadges
          ? _value._verificationBadges
          : verificationBadges // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      isSaved: null == isSaved
          ? _value.isSaved
          : isSaved // ignore: cast_nullable_to_non_nullable
              as bool,
      profilePicture: freezed == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$WorkerImpl with DiagnosticableTreeMixin implements _Worker {
  const _$WorkerImpl(
      {required this.id,
      required this.title,
      required this.category,
      this.user,
      required this.location,
      @JsonKey(name: 'created_at') required this.createdAt,
      final List<String>? skills,
      this.bio,
      this.availability,
      @JsonKey(name: 'experience_years') this.experienceYears,
      @JsonKey(name: 'portfolio_link') this.portfolioLink,
      @JsonKey(name: 'post_time') this.postTime,
      @JsonKey(name: 'category_display') this.categoryDisplay,
      @JsonKey(name: 'verification_badges')
      final Map<String, dynamic>? verificationBadges,
      @JsonKey(name: 'is_saved') this.isSaved = false,
      @JsonKey(name: 'profile_picture') this.profilePicture,
      @JsonKey(name: 'name') this.userName})
      : _skills = skills,
        _verificationBadges = verificationBadges;

  factory _$WorkerImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkerImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String category;
  @override
  final int? user;
  @override
  final String location;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  final List<String>? _skills;
  @override
  List<String>? get skills {
    final value = _skills;
    if (value == null) return null;
    if (_skills is EqualUnmodifiableListView) return _skills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? bio;
  @override
  final String? availability;
  @override
  @JsonKey(name: 'experience_years')
  final int? experienceYears;
  @override
  @JsonKey(name: 'portfolio_link')
  final String? portfolioLink;
// Computed fields
  @override
  @JsonKey(name: 'post_time')
  final String? postTime;
  @override
  @JsonKey(name: 'category_display')
  final String? categoryDisplay;
  final Map<String, dynamic>? _verificationBadges;
  @override
  @JsonKey(name: 'verification_badges')
  Map<String, dynamic>? get verificationBadges {
    final value = _verificationBadges;
    if (value == null) return null;
    if (_verificationBadges is EqualUnmodifiableMapView)
      return _verificationBadges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey(name: 'is_saved')
  final bool isSaved;
  @override
  @JsonKey(name: 'profile_picture')
  final String? profilePicture;
  @override
  @JsonKey(name: 'name')
  final String? userName;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Worker(id: $id, title: $title, category: $category, user: $user, location: $location, createdAt: $createdAt, skills: $skills, bio: $bio, availability: $availability, experienceYears: $experienceYears, portfolioLink: $portfolioLink, postTime: $postTime, categoryDisplay: $categoryDisplay, verificationBadges: $verificationBadges, isSaved: $isSaved, profilePicture: $profilePicture, userName: $userName)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Worker'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('category', category))
      ..add(DiagnosticsProperty('user', user))
      ..add(DiagnosticsProperty('location', location))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('skills', skills))
      ..add(DiagnosticsProperty('bio', bio))
      ..add(DiagnosticsProperty('availability', availability))
      ..add(DiagnosticsProperty('experienceYears', experienceYears))
      ..add(DiagnosticsProperty('portfolioLink', portfolioLink))
      ..add(DiagnosticsProperty('postTime', postTime))
      ..add(DiagnosticsProperty('categoryDisplay', categoryDisplay))
      ..add(DiagnosticsProperty('verificationBadges', verificationBadges))
      ..add(DiagnosticsProperty('isSaved', isSaved))
      ..add(DiagnosticsProperty('profilePicture', profilePicture))
      ..add(DiagnosticsProperty('userName', userName));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._skills, _skills) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.availability, availability) ||
                other.availability == availability) &&
            (identical(other.experienceYears, experienceYears) ||
                other.experienceYears == experienceYears) &&
            (identical(other.portfolioLink, portfolioLink) ||
                other.portfolioLink == portfolioLink) &&
            (identical(other.postTime, postTime) ||
                other.postTime == postTime) &&
            (identical(other.categoryDisplay, categoryDisplay) ||
                other.categoryDisplay == categoryDisplay) &&
            const DeepCollectionEquality()
                .equals(other._verificationBadges, _verificationBadges) &&
            (identical(other.isSaved, isSaved) || other.isSaved == isSaved) &&
            (identical(other.profilePicture, profilePicture) ||
                other.profilePicture == profilePicture) &&
            (identical(other.userName, userName) ||
                other.userName == userName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      category,
      user,
      location,
      createdAt,
      const DeepCollectionEquality().hash(_skills),
      bio,
      availability,
      experienceYears,
      portfolioLink,
      postTime,
      categoryDisplay,
      const DeepCollectionEquality().hash(_verificationBadges),
      isSaved,
      profilePicture,
      userName);

  /// Create a copy of Worker
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkerImplCopyWith<_$WorkerImpl> get copyWith =>
      __$$WorkerImplCopyWithImpl<_$WorkerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkerImplToJson(
      this,
    );
  }
}

abstract class _Worker implements Worker {
  const factory _Worker(
      {required final int id,
      required final String title,
      required final String category,
      final int? user,
      required final String location,
      @JsonKey(name: 'created_at') required final DateTime createdAt,
      final List<String>? skills,
      final String? bio,
      final String? availability,
      @JsonKey(name: 'experience_years') final int? experienceYears,
      @JsonKey(name: 'portfolio_link') final String? portfolioLink,
      @JsonKey(name: 'post_time') final String? postTime,
      @JsonKey(name: 'category_display') final String? categoryDisplay,
      @JsonKey(name: 'verification_badges')
      final Map<String, dynamic>? verificationBadges,
      @JsonKey(name: 'is_saved') final bool isSaved,
      @JsonKey(name: 'profile_picture') final String? profilePicture,
      @JsonKey(name: 'name') final String? userName}) = _$WorkerImpl;

  factory _Worker.fromJson(Map<String, dynamic> json) = _$WorkerImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get category;
  @override
  int? get user;
  @override
  String get location;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  List<String>? get skills;
  @override
  String? get bio;
  @override
  String? get availability;
  @override
  @JsonKey(name: 'experience_years')
  int? get experienceYears;
  @override
  @JsonKey(name: 'portfolio_link')
  String? get portfolioLink; // Computed fields
  @override
  @JsonKey(name: 'post_time')
  String? get postTime;
  @override
  @JsonKey(name: 'category_display')
  String? get categoryDisplay;
  @override
  @JsonKey(name: 'verification_badges')
  Map<String, dynamic>? get verificationBadges;
  @override
  @JsonKey(name: 'is_saved')
  bool get isSaved;
  @override
  @JsonKey(name: 'profile_picture')
  String? get profilePicture;
  @override
  @JsonKey(name: 'name')
  String? get userName;

  /// Create a copy of Worker
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkerImplCopyWith<_$WorkerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
