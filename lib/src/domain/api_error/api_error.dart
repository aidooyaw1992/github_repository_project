import 'package:freezed_annotation/freezed_annotation.dart';
part 'api_error.freezed.dart';

@freezed
abstract class ApiError with _$ApiError {
  factory ApiError({
  required final ApiErrorType errorType,
  @Default('Unknown error') final String? message,
  }) = _ApiError;
}
enum ApiErrorType { api, network, timeout }