import 'dart:convert';

import 'package:github_repository_project/src/data/models/github_repo_model.dart';
import 'package:github_repository_project/src/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDatasource {
  Future<void> saveRepository(GithubRepoModel repository) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedData = await retrieveAllSavedRepositories();

    final alreadySavedData = savedData.any((repo) => repo.id == repository.id);
    if (!alreadySavedData) {
      savedData.add(repository);
      final jsonList =
          savedData.map((repo) => jsonEncode(repo.toJson())).toList();
          // print(jsonList);
      await prefs.setStringList(AppConstants.favouriteRepositoriesKey, jsonList);
    }
  }

  Future<List<GithubRepoModel>> retrieveAllSavedRepositories() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList =
        prefs.getStringList(AppConstants.favouriteRepositoriesKey) ?? [];

// debugPrint(jsonList);
    final repositories =
        jsonList.map((jsonString) {
          final json = jsonDecode(jsonString) as Map<String, dynamic>;
          return GithubRepoModel.fromJson(json);
        }).toList();

    // debugPrint('Retrieved ${repositories.length} saved repositories');
    return repositories;
  }

  Future<void> removeRepository(GithubRepoModel repository) async {
    final prefs = await SharedPreferences.getInstance();

    final savedRepos = await retrieveAllSavedRepositories();

    savedRepos.removeWhere((repo) => repo.id == repository.id);

    final jsonList =
        savedRepos.map((repo) => json.encode(repo.toJson())).toList();

    await prefs.setStringList(AppConstants.favouriteRepositoriesKey, jsonList);

    // print('Repository removed: ${repository.name}');
  }

  Future<GithubRepoModel?> retrieveSavedRepository(int repositoryId) async {
    final savedRepos = await retrieveAllSavedRepositories();

    for (final repo in savedRepos) {
      if (repo.id == repositoryId) {
        return repo;
      }
    }
    return null;
  }

  Future<void> clearAllSavedRepositories() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.favouriteRepositoriesKey);
  }
}
