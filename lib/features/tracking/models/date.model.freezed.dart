// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'date.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DateModel _$DateModelFromJson(Map<String, dynamic> json) {
  return _DateModel.fromJson(json);
}

/// @nodoc
mixin _$DateModel {
  int get year => throw _privateConstructorUsedError;
  int get month => throw _privateConstructorUsedError;
  int get day => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DateModelCopyWith<DateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DateModelCopyWith<$Res> {
  factory $DateModelCopyWith(DateModel value, $Res Function(DateModel) then) =
      _$DateModelCopyWithImpl<$Res, DateModel>;
  @useResult
  $Res call({int year, int month, int day});
}

/// @nodoc
class _$DateModelCopyWithImpl<$Res, $Val extends DateModel>
    implements $DateModelCopyWith<$Res> {
  _$DateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? month = null,
    Object? day = null,
  }) {
    return _then(_value.copyWith(
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DateModelImplCopyWith<$Res>
    implements $DateModelCopyWith<$Res> {
  factory _$$DateModelImplCopyWith(
          _$DateModelImpl value, $Res Function(_$DateModelImpl) then) =
      __$$DateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int year, int month, int day});
}

/// @nodoc
class __$$DateModelImplCopyWithImpl<$Res>
    extends _$DateModelCopyWithImpl<$Res, _$DateModelImpl>
    implements _$$DateModelImplCopyWith<$Res> {
  __$$DateModelImplCopyWithImpl(
      _$DateModelImpl _value, $Res Function(_$DateModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? month = null,
    Object? day = null,
  }) {
    return _then(_$DateModelImpl(
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DateModelImpl extends _DateModel {
  const _$DateModelImpl(
      {required this.year, required this.month, required this.day})
      : super._();

  factory _$DateModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DateModelImplFromJson(json);

  @override
  final int year;
  @override
  final int month;
  @override
  final int day;

  @override
  String toString() {
    return 'DateModel(year: $year, month: $month, day: $day)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DateModelImpl &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.day, day) || other.day == day));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, year, month, day);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DateModelImplCopyWith<_$DateModelImpl> get copyWith =>
      __$$DateModelImplCopyWithImpl<_$DateModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DateModelImplToJson(
      this,
    );
  }
}

abstract class _DateModel extends DateModel {
  const factory _DateModel(
      {required final int year,
      required final int month,
      required final int day}) = _$DateModelImpl;
  const _DateModel._() : super._();

  factory _DateModel.fromJson(Map<String, dynamic> json) =
      _$DateModelImpl.fromJson;

  @override
  int get year;
  @override
  int get month;
  @override
  int get day;
  @override
  @JsonKey(ignore: true)
  _$$DateModelImplCopyWith<_$DateModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
