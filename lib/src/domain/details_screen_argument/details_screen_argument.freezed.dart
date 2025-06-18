// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'details_screen_argument.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DetailsScreenArgument implements DiagnosticableTreeMixin {

 GithubRepoModel get repository;
/// Create a copy of DetailsScreenArgument
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DetailsScreenArgumentCopyWith<DetailsScreenArgument> get copyWith => _$DetailsScreenArgumentCopyWithImpl<DetailsScreenArgument>(this as DetailsScreenArgument, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'DetailsScreenArgument'))
    ..add(DiagnosticsProperty('repository', repository));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DetailsScreenArgument&&(identical(other.repository, repository) || other.repository == repository));
}


@override
int get hashCode => Object.hash(runtimeType,repository);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'DetailsScreenArgument(repository: $repository)';
}


}

/// @nodoc
abstract mixin class $DetailsScreenArgumentCopyWith<$Res>  {
  factory $DetailsScreenArgumentCopyWith(DetailsScreenArgument value, $Res Function(DetailsScreenArgument) _then) = _$DetailsScreenArgumentCopyWithImpl;
@useResult
$Res call({
 GithubRepoModel repository
});




}
/// @nodoc
class _$DetailsScreenArgumentCopyWithImpl<$Res>
    implements $DetailsScreenArgumentCopyWith<$Res> {
  _$DetailsScreenArgumentCopyWithImpl(this._self, this._then);

  final DetailsScreenArgument _self;
  final $Res Function(DetailsScreenArgument) _then;

/// Create a copy of DetailsScreenArgument
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? repository = null,}) {
  return _then(_self.copyWith(
repository: null == repository ? _self.repository : repository // ignore: cast_nullable_to_non_nullable
as GithubRepoModel,
  ));
}

}


/// @nodoc


class _DetailsScreenArgument with DiagnosticableTreeMixin implements DetailsScreenArgument {
  const _DetailsScreenArgument(this.repository);
  

@override final  GithubRepoModel repository;

/// Create a copy of DetailsScreenArgument
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DetailsScreenArgumentCopyWith<_DetailsScreenArgument> get copyWith => __$DetailsScreenArgumentCopyWithImpl<_DetailsScreenArgument>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'DetailsScreenArgument'))
    ..add(DiagnosticsProperty('repository', repository));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DetailsScreenArgument&&(identical(other.repository, repository) || other.repository == repository));
}


@override
int get hashCode => Object.hash(runtimeType,repository);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'DetailsScreenArgument(repository: $repository)';
}


}

/// @nodoc
abstract mixin class _$DetailsScreenArgumentCopyWith<$Res> implements $DetailsScreenArgumentCopyWith<$Res> {
  factory _$DetailsScreenArgumentCopyWith(_DetailsScreenArgument value, $Res Function(_DetailsScreenArgument) _then) = __$DetailsScreenArgumentCopyWithImpl;
@override @useResult
$Res call({
 GithubRepoModel repository
});




}
/// @nodoc
class __$DetailsScreenArgumentCopyWithImpl<$Res>
    implements _$DetailsScreenArgumentCopyWith<$Res> {
  __$DetailsScreenArgumentCopyWithImpl(this._self, this._then);

  final _DetailsScreenArgument _self;
  final $Res Function(_DetailsScreenArgument) _then;

/// Create a copy of DetailsScreenArgument
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? repository = null,}) {
  return _then(_DetailsScreenArgument(
null == repository ? _self.repository : repository // ignore: cast_nullable_to_non_nullable
as GithubRepoModel,
  ));
}


}

// dart format on
