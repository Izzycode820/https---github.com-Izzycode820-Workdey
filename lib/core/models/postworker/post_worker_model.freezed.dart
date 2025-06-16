// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_worker_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PostWorker _$PostWorkerFromJson(Map<String, dynamic> json) {
  return _PostWorker.fromJson(json);
}

/// @nodoc
mixin _$PostWorker {
  String get title => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  List<String> get skills => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  String? get availability => throw _privateConstructorUsedError;
  @JsonKey(name: 'experience_years')
  int? get experienceYears => throw _privateConstructorUsedError;
  @JsonKey(name: 'portfolio_link')
  String? get portfolioLink => throw _privateConstructorUsedError;

  /// Serializes this PostWorker to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PostWorker
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostWorkerCopyWith<PostWorker> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostWorkerCopyWith<$Res> {
  factory $PostWorkerCopyWith(
          PostWorker value, $Res Function(PostWorker) then) =
      _$PostWorkerCopyWithImpl<$Res, PostWorker>;
  @useResult
  $Res call(
      {String title,
      String category,
      String location,
      List<String> skills,
      String? bio,
      String? availability,
      @JsonKey(name: 'experience_years') int? experienceYears,
      @JsonKey(name: 'portfolio_link') String? portfolioLink});
}

/// @nodoc
class _$PostWorkerCopyWithImpl<$Res, $Val extends PostWorker>
    implements $PostWorkerCopyWith<$Res> {
  _$PostWorkerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostWorker
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? category = null,
    Object? location = null,
    Object? skills = null,
    Object? bio = freezed,
    Object? availability = freezed,
    Object? experienceYears = freezed,
    Object? portfolioLink = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      skills: null == skills
          ? _value.skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostWorkerImplCopyWith<$Res>
    implements $PostWorkerCopyWith<$Res> {
  factory _$$PostWorkerImplCopyWith(
          _$PostWorkerImpl value, $Res Function(_$PostWorkerImpl) then) =
      __$$PostWorkerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String category,
      String location,
      List<String> skills,
      String? bio,
      String? availability,
      @JsonKey(name: 'experience_years') int? experienceYears,
      @JsonKey(name: 'portfolio_link') String? portfolioLink});
}

/// @nodoc
class __$$PostWorkerImplCopyWithImpl<$Res>
    extends _$PostWorkerCopyWithImpl<$Res, _$PostWorkerImpl>
    implements _$$PostWorkerImplCopyWith<$Res> {
  __$$PostWorkerImplCopyWithImpl(
      _$PostWorkerImpl _value, $Res Function(_$PostWorkerImpl) _then)
      : super(_value, _then);

  /// Create a copy of PostWorker
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? category = null,
    Object? location = null,
    Object? skills = null,
    Object? bio = freezed,
    Object? availability = freezed,
    Object? experienceYears = freezed,
    Object? portfolioLink = freezed,
  }) {
    return _then(_$PostWorkerImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      skills: null == skills
          ? _value._skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$PostWorkerImpl with DiagnosticableTreeMixin implements _PostWorker {
  const _$PostWorkerImpl(
      {required this.title,
      required this.category,
      required this.location,
      required final List<String> skills,
      this.bio,
      this.availability,
      @JsonKey(name: 'experience_years') this.experienceYears,
      @JsonKey(name: 'portfolio_link') this.portfolioLink})
      : _skills = skills;

  factory _$PostWorkerImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostWorkerImplFromJson(json);

  @override
  final String title;
  @override
  final String category;
  @override
  final String location;
  final List<String> _skills;
  @override
  List<String> get skills {
    if (_skills is EqualUnmodifiableListView) return _skills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_skills);
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

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PostWorker(title: $title, category: $category, location: $location, skills: $skills, bio: $bio, availability: $availability, experienceYears: $experienceYears, portfolioLink: $portfolioLink)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PostWorker'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('category', category))
      ..add(DiagnosticsProperty('location', location))
      ..add(DiagnosticsProperty('skills', skills))
      ..add(DiagnosticsProperty('bio', bio))
      ..add(DiagnosticsProperty('availability', availability))
      ..add(DiagnosticsProperty('experienceYears', experienceYears))
      ..add(DiagnosticsProperty('portfolioLink', portfolioLink));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostWorkerImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.location, location) ||
                other.location == location) &&
            const DeepCollectionEquality().equals(other._skills, _skills) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.availability, availability) ||
                other.availability == availability) &&
            (identical(other.experienceYears, experienceYears) ||
                other.experienceYears == experienceYears) &&
            (identical(other.portfolioLink, portfolioLink) ||
                other.portfolioLink == portfolioLink));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      category,
      location,
      const DeepCollectionEquality().hash(_skills),
      bio,
      availability,
      experienceYears,
      portfolioLink);

  /// Create a copy of PostWorker
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostWorkerImplCopyWith<_$PostWorkerImpl> get copyWith =>
      __$$PostWorkerImplCopyWithImpl<_$PostWorkerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostWorkerImplToJson(
      this,
    );
  }
}

abstract class _PostWorker implements PostWorker {
  const factory _PostWorker(
          {required final String title,
          required final String category,
          required final String location,
          required final List<String> skills,
          final String? bio,
          final String? availability,
          @JsonKey(name: 'experience_years') final int? experienceYears,
          @JsonKey(name: 'portfolio_link') final String? portfolioLink}) =
      _$PostWorkerImpl;

  factory _PostWorker.fromJson(Map<String, dynamic> json) =
      _$PostWorkerImpl.fromJson;

  @override
  String get title;
  @override
  String get category;
  @override
  String get location;
  @override
  List<String> get skills;
  @override
  String? get bio;
  @override
  String? get availability;
  @override
  @JsonKey(name: 'experience_years')
  int? get experienceYears;
  @override
  @JsonKey(name: 'portfolio_link')
  String? get portfolioLink;

  /// Create a copy of PostWorker
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostWorkerImplCopyWith<_$PostWorkerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
