import 'package:fpdart/fpdart.dart';
import 'package:github_repository_project/src/data/models/github_repo_model.dart';
import 'package:github_repository_project/src/domain/db_error/db_error.dart';

import '../data/models/search_response_model.dart';
import 'api_error/api_error.dart';

abstract class AppRepository {
  Future<Either<ApiError, SearchResponseModel>> getTrendingReposLastMonth();
  Future<Either<ApiError, SearchResponseModel>> getTrendingReposLastDay();
  Future<Either<ApiError, SearchResponseModel>> getTrendingReposLastWeek();
  Future<Either<ApiError, SearchResponseModel>> searchRepositories(String query);
  Future<Either<ApiError, SearchResponseModel>> loadMore(SearchResponseModel response);


  Future<Either<DBError,void>> saveFavouriteRepository(GithubRepoModel repository);
  Future<Either<DBError,void>> removeFavouriteRepository(GithubRepoModel repository);
  Future<Either<DBError, void>> clearAllFavouriteRepositories();

  Future<Either<DBError, List<GithubRepoModel>>> retrieveAllSavedFavouriteRepositories();
  Future<Either<DBError, GithubRepoModel?>> retrieveSavedFavouriteRepository(GithubRepoModel repository);
}