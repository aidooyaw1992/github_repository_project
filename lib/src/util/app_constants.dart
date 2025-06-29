import 'package:flutter/foundation.dart';

class AppConstants {
  static const String _devToken = '';
  static const String _prodToken = String.fromEnvironment('GITHUB_TOKEN');

  static String get githubToken {
    if (kDebugMode) {
      return _devToken.isNotEmpty ? 'Bearer $_devToken' : '';
    } else {
      return _prodToken.isNotEmpty ? 'Bearer $_prodToken' : '';
    }
  }

  static bool get hasValidToken => githubToken.isNotEmpty;

  static bool get isProduction => kReleaseMode;
  static bool get isDevelopment => kDebugMode;

  static const int perPage = 25;
  static const String baseUrl = 'https://api.github.com';

  static const String savedRepositoriesKey = 'saved_repositories';
  static const String favouriteRepositoriesKey = 'favourite_repositories';
}
