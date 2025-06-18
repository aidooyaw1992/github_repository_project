import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_repository_project/src/data/models/github_repo_model.dart';
import 'package:github_repository_project/src/data/models/pagination_info.dart';
import 'package:github_repository_project/src/data/models/search_response_model.dart';
import 'package:github_repository_project/src/domain/api_error/api_error.dart';
import 'package:github_repository_project/src/domain/app_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:github_repository_project/src/domain/time_period.dart';

part 'trending_state.dart';

class TrendingCubit extends Cubit<TrendingState> {
  final AppRepository appRepository;

  TrendingCubit({required this.appRepository}) : super(TrendingStateLoading());

  fetchLatestTrendingRepos({TimePeriod period = TimePeriod.lastDay}) async {
    emit(TrendingStateLoading());
    final result = await switch (period) {
      TimePeriod.lastDay => appRepository.getTrendingReposLastDay(),
      TimePeriod.lastWeek => appRepository.getTrendingReposLastWeek(),
      TimePeriod.lastMonth => appRepository.getTrendingReposLastMonth(),
    };

    return result.fold((l) => emit(TrendingStateFailure(error: l)), (
      result,
    ) async {
      // print(result.pagination?.nextUrl);
      final updatedItems = await _checkFavoriteStatus(result.items);

      emit(
        TrendingStateSuccess(
          result: updatedItems,
          totalCount: result.totalCount,
          pageInfo: result.pagination,
        ),
      );
    });
  }

  fetchMore() async {
    final currentState = state;
    if (currentState is TrendingStateSuccess &&
        currentState.pageInfo?.nextUrl != null) {
      // print("loading more");

      final currentResponse = SearchResponseModel(
        totalCount: currentState.totalCount,
        incompleteResults: false,
        items: currentState.result,
        pagination: currentState.pageInfo,
      );
      final result = await appRepository.loadMore(currentResponse);

      result.fold(
        (l) {
          emit(TrendingStateFailure(error: l));
        },
        (searchResponse) async{
          final newItemsWithFavoriteStatus = await _checkFavoriteStatus(searchResponse.items);
          final updatedList = [...currentState.result, ...newItemsWithFavoriteStatus];
          
          // print("updated list length => ${updatedList.length}");
          emit(
            TrendingStateSuccess(
              result: updatedList,
              pageInfo: searchResponse.pagination,
              totalCount: searchResponse.totalCount,
            ),
          );
        },
      );
    }
  }

  saveToFavourite(GithubRepoModel repo) {
    final currentState = state;
    if (currentState is TrendingStateSuccess) {
      appRepository.saveFavouriteRepository(
        repo.copyWith(isFavouriteRepo: true),
      );

      final updatedList =
          currentState.result.map((existingRepo) {
            if (existingRepo.id == repo.id) {
              return existingRepo.copyWith(isFavouriteRepo: true);
            } else {
              return existingRepo;
            }
          }).toList();

      // print('updated trending');
      emit(
        TrendingStateSuccess(
          result: updatedList,
          pageInfo: currentState.pageInfo,
          totalCount: currentState.totalCount,
        ),
      );
    }
  }

  removeFromFavourite(GithubRepoModel repo) {
    final currentState = state;
    if (currentState is TrendingStateSuccess) {
       appRepository.removeFavouriteRepository(repo);
      
      final updatedList =
          currentState.result.map((existingRepo) {
            if (existingRepo.id == repo.id) {
              return existingRepo.copyWith(isFavouriteRepo: false);
            } else {
              return existingRepo;
            }
          }).toList();

      // print('updated trending');
      emit(
        TrendingStateSuccess(
          result: updatedList,
          pageInfo: currentState.pageInfo,
          totalCount: currentState.totalCount,
        ),
      );
    }
  }

  Future<List<GithubRepoModel>> _checkFavoriteStatus(
    List<GithubRepoModel> repos,
  ) async {
    final favoriteRepos =
        await appRepository.retrieveAllSavedFavouriteRepositories();
    return favoriteRepos.fold((l) => [], (saved_repos) {
      final favoriteIds = saved_repos.map((repo) => repo.id).toSet();
      return repos.map((repo) {
        final isFavorite = favoriteIds.contains(repo.id);
        return repo.copyWith(isFavouriteRepo: isFavorite);
      }).toList();
    });
  }
}
