import 'package:github_repository_project/src/data/models/github_repo_model.dart';

import 'pagination_info.dart';

class SearchResponseModel {
  final int totalCount;
  final bool incompleteResults;
  final List<GithubRepoModel> items;
  final PaginationInfo? pagination;

  SearchResponseModel({
    required this.totalCount,
    required this.incompleteResults,
    required this.items,
    this.pagination,
  });

  factory SearchResponseModel.fromJson(Map<String, dynamic> json, PaginationInfo? pagination) {
    return SearchResponseModel(
      totalCount: json['total_count'],
      incompleteResults: json['incomplete_results'],
      items: (json['items'] as List)
          .map((item) => GithubRepoModel.fromJson(item))
          .toList(),
      pagination: pagination,
    );
  }
}