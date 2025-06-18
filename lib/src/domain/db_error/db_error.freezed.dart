// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'db_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DBError {

 dynamic get message;
/// Create a copy of DBError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DBErrorCopyWith<DBError> get copyWith => _$DBErrorCopyWithImpl<DBError>(this as DBError, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DBError&&const DeepCollectionEquality().equals(other.message, message));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(message));

@override
String toString() {
  return 'DBError(message: $message)';
}


}

/// @nodoc
abstract mixin class $DBErrorCopyWith<$Res>  {
  factory $DBErrorCopyWith(DBError value, $Res Function(DBError) _then) = _$DBErrorCopyWithImpl;
@useResult
$Res call({
 dynamic message
});




}
/// @nodoc
class _$DBErrorCopyWithImpl<$Res>
    implements $DBErrorCopyWith<$Res> {
  _$DBErrorCopyWithImpl(this._self, this._then);

  final DBError _self;
  final $Res Function(DBError) _then;

/// Create a copy of DBError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = freezed,}) {
  return _then(_self.copyWith(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// @nodoc


class _DBError implements DBError {
   _DBError({this.message});
  

@override final  dynamic message;

/// Create a copy of DBError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DBErrorCopyWith<_DBError> get copyWith => __$DBErrorCopyWithImpl<_DBError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DBError&&const DeepCollectionEquality().equals(other.message, message));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(message));

@override
String toString() {
  return 'DBError(message: $message)';
}


}

/// @nodoc
abstract mixin class _$DBErrorCopyWith<$Res> implements $DBErrorCopyWith<$Res> {
  factory _$DBErrorCopyWith(_DBError value, $Res Function(_DBError) _then) = __$DBErrorCopyWithImpl;
@override @useResult
$Res call({
 dynamic message
});




}
/// @nodoc
class __$DBErrorCopyWithImpl<$Res>
    implements _$DBErrorCopyWith<$Res> {
  __$DBErrorCopyWithImpl(this._self, this._then);

  final _DBError _self;
  final $Res Function(_DBError) _then;

/// Create a copy of DBError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(_DBError(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

// dart format on
