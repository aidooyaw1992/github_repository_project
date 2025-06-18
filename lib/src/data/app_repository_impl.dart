import 'dart:async';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:github_repository_project/src/data/data_sources/local_datasource.dart';
import 'package:github_repository_project/src/data/models/github_repo_model.dart';
import 'package:github_repository_project/src/data/models/search_response_model.dart';
import 'package:github_repository_project/src/domain/api_error/api_error.dart';
import 'package:github_repository_project/src/domain/app_repository.dart';
import 'package:github_repository_project/src/domain/db_error/db_error.dart';
import 'package:github_repository_project/src/util/app_constants.dart';

import '../domain/time_period.dart';
import 'data_sources/remote_datasource.dart';

class AppRepositoryImpl implements AppRepository {
  final RemoteDatasource api;
  final LocalDatasource storage;

  AppRepositoryImpl({required this.storage, required this.api});

  @override
  Future<Either<ApiError, SearchResponseModel>>
  getTrendingReposLastMonth() async {
    try {
      final result = await api.searchTrendingRepositories(
        period: TimePeriod.lastMonth,
        perPage: AppConstants.perPage,
      );
      return Right(result);
    } on SocketException {
      return Left(ApiError(errorType: ApiErrorType.network));
    } on TimeoutException {
      return Left(ApiError(errorType: ApiErrorType.timeout));
    } catch (e) {
      //debugPrint('$e');
      //debugPrint('$s');
      return Left(ApiError(errorType: ApiErrorType.api, message: e.toString()));
    }
  }

  @override
  Future<Either<ApiError, SearchResponseModel>>
  getTrendingReposLastDay() async {
    try {
      final result = await api.searchTrendingRepositories(
        period: TimePeriod.lastDay,
        perPage: AppConstants.perPage,
      );
      return Right(result);
    } on SocketException {
      return Left(ApiError(errorType: ApiErrorType.network));
    } on TimeoutException {
      return Left(ApiError(errorType: ApiErrorType.timeout));
    } catch (e){
      //debugPrint('$e');
      //debugPrint('$s');
      return Left(ApiError(errorType: ApiErrorType.api, message: e.toString()));
    }
  }

  @override
  Future<Either<ApiError, SearchResponseModel>>
  getTrendingReposLastWeek() async {
    try {
      final result = await api.searchTrendingRepositories(
        period: TimePeriod.lastWeek,
        perPage: AppConstants.perPage,
      );
      return Right(result);
    } on SocketException {
      return Left(ApiError(errorType: ApiErrorType.network));
    } on TimeoutException {
      return Left(ApiError(errorType: ApiErrorType.timeout));
    } catch (e) {
      //debugPrint('$e');
      //debugPrint('$s');
      return Left(ApiError(errorType: ApiErrorType.api, message: e.toString()));
    }
  }

  /// Search repositories with custom query
  @override
  Future<Either<ApiError, SearchResponseModel>> searchRepositories(
    String query,
  ) async {
    try {
      final result = await api.searchRepositories(query: query);
      return Right(result);
    } on SocketException {
      return Left(ApiError(errorType: ApiErrorType.network));
    } on TimeoutException {
      return Left(ApiError(errorType: ApiErrorType.timeout));
    } catch (e) {
      //debugPrint('$e');
      //debugPrint('$s');
      return Left(ApiError(errorType: ApiErrorType.api, message: e.toString()));
    }
  }

  /// Load more results using pagination
  @override
  Future<Either<ApiError, SearchResponseModel>> loadMore(
    SearchResponseModel response,
  ) async {
    try {
      if (response.pagination?.nextUrl != null) {
        // print(response.pagination?.nextUrl);
        final result = await api.fetchNextPage(response.pagination!.nextUrl!);
        return Right(result);
      } else {
        return Left(
          ApiError(errorType: ApiErrorType.api, message: "Limit reached"),
        );
      }
    } on SocketException {
      return Left(ApiError(errorType: ApiErrorType.network));
    } on TimeoutException {
      return Left(ApiError(errorType: ApiErrorType.timeout));
    } catch (e) {
      // print("im here");
      //debugPrint('$e');
      //debugPrint('$s');
      return Left(ApiError(errorType: ApiErrorType.api, message: e.toString()));
    }
  }

  @override
  Future<Either<DBError, List<GithubRepoModel>>>
  retrieveAllSavedFavouriteRepositories() async {
    try {
      final result = await storage.retrieveAllSavedRepositories();
      return Right(result);
    } catch (e) {
      return Left(DBError(message: "something went wrong"));
    }
  }

  @override
  Future<Either<DBError, GithubRepoModel?>> retrieveSavedFavouriteRepository(
    GithubRepoModel repository,
  ) async {
    try {
      final result = await storage.retrieveSavedRepository(repository.id);
      if (result != null) {
        return Right(result);
      }
      return Right(null);
    } catch (e) {
      return Left(DBError(message: "something went wrong"));
    }
  }

  @override
  Future<Either<DBError, void>> saveFavouriteRepository(
    GithubRepoModel repository,
  ) async {
    try {
      await storage.saveRepository(repository);
      // print("saved repo ${repository.id}");
      return Right(null);
    } catch (e) {
      return Left(DBError(message: "something went wrong"));
    }
  }

  @override
  Future<Either<DBError, void>> removeFavouriteRepository(
    GithubRepoModel repository,
  ) async {
    try {
      await storage.removeRepository(repository);
      return Right(null);
    } catch (e) {
      return Left(DBError(message: "something went wrong"));
    }
  }

  @override
  Future<Either<DBError, void>> clearAllFavouriteRepositories() async {
    try {
      await storage.clearAllSavedRepositories();
      return Right(null);
    } catch (e) {
      return Left(DBError(message: "something went wrong"));
    }
  }
}
