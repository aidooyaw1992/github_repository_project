import 'dart:convert';

import 'package:github_repository_project/src/data/models/search_response_model.dart';
import 'package:github_repository_project/src/util/app_constants.dart';
import 'package:http/http.dart' as http;

import '../../domain/time_period.dart';
import '../models/pagination_info.dart';

class RemoteDatasource {
  final http.Client _client = http.Client();

  Future<SearchResponseModel> searchTrendingRepositories({
    required TimePeriod period,
    int perPage = 30,
    int page = 1,
  }) async {
    final query = 'created:>${period.queryString}';
    return _searchRepositories(
      query: query,
      sort: 'stars',
      order: 'desc',
      perPage: perPage,
      page: page,
    );
  }

  /// Search repositories with custom query
  Future<SearchResponseModel> searchRepositories({
    required String query,
    String sort = 'stars',
    String order = 'desc',
    int perPage = 30,
    int page = 1,
  }) async {
    return _searchRepositories(
      query: query,
      sort: sort,
      order: order,
      perPage: perPage,
      page: page,
    );
  }

  Future<SearchResponseModel> fetchNextPage(String nextUrl) async {
    final response = await _client.get(
      Uri.parse(nextUrl),
      headers: _buildHeaders(),
    );
    final jsonData = jsonDecode(response.body);
    final pagination = _parseLinkHeader(response.headers['link']);
    return SearchResponseModel.fromJson(jsonData, pagination);
  }

  Future<SearchResponseModel> _searchRepositories({
    required String query,
    required String sort,
    required String order,
    required int perPage,
    required int page,
  }) async {
    final uri = Uri.parse(
      // '${AppConstants.baseUrl}/search/repositories',
      '${AppConstants.baseUrl}/search/repositor', //testing error message
    ).replace(
      queryParameters: {
        'q': query,
        'sort': sort,
        'order': order,
        'per_page': perPage.toString(),
        'page': page.toString(),
      },
    );

    final response = await _client.get(uri, headers: _buildHeaders());
   
    if (response.statusCode != 200) {
    
    try {
      final errorData = jsonDecode(response.body);
      final errorMessage = errorData['message'] ?? 'Unknown error occurred';
      final documentationUrl = errorData['documentation_url'] ?? '';
      
      throw Exception(
        'API Error (${response.statusCode}): $errorMessage'
        '${documentationUrl.isNotEmpty ? ' - See: $documentationUrl' : ''}'
      );
    } catch (e) {
      throw Exception(
        'API Error (${response.statusCode}): ${response.reasonPhrase ?? 'Unknown error'}'
      );
    }
  }
    final jsonData = jsonDecode(response.body);
    final pagination = _parseLinkHeader(response.headers['link']);
    return SearchResponseModel.fromJson(jsonData, pagination);
  }

  PaginationInfo? _parseLinkHeader(String? linkHeader) {
    if (linkHeader == null) return null;

    final links = <String, String>{};
    final parts = linkHeader.split(',');

    for (final part in parts) {
      final match = RegExp(r'<(.+?)>;\s*rel="(.+?)"').firstMatch(part.trim());
      if (match != null) {
        final url = match.group(1)!;
        final rel = match.group(2)!;
        links[rel] = url;
      }
    }

    return PaginationInfo(
      nextUrl: links['next'],
      lastUrl: links['last'],
      prevUrl: links['prev'],
      firstUrl: links['first'],
    );
  }

  Map<String, String> _buildHeaders() {
    return {
      'Accept': 'application/json',
      'Authorization': AppConstants.githubToken,
    };
  }
}
