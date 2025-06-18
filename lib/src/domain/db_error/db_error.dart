import 'package:freezed_annotation/freezed_annotation.dart';
part 'db_error.freezed.dart';

@freezed
abstract class DBError with _$DBError {
  factory DBError({dynamic message}) = _DBError;
}
