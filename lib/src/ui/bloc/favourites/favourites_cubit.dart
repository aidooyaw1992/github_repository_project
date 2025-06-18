import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_repository_project/src/domain/db_error/db_error.dart';

import '../../../data/models/github_repo_model.dart';
import '../../../domain/app_repository.dart';

part 'favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  final AppRepository appRepository;

  FavouritesCubit({required this.appRepository})
    : super(FavouritesStateLoading());

  retrieveStoredFavouriteRepos() async {
    emit(FavouritesStateLoading());
    await Future.delayed(Duration(milliseconds: 10));
    var res = await appRepository.retrieveAllSavedFavouriteRepositories();
    return res.fold((l) => emit(FavouritesFailure(error: l)), (result) {
      emit(FavouritesStateSuccess(result: result));
    });
  }

  deleteAllFavouriteRepos() async {
    emit(FavouritesStateLoading());
    final res = await appRepository.clearAllFavouriteRepositories();
    return res.fold((l) => emit(FavouritesFailure(error: l)), (result) {
      emit(FavouritesStateSuccess(result: []));
    });
  }

  deleteFavouriteRepo(GithubRepoModel repo) async {
    final res = await appRepository.removeFavouriteRepository(repo);
    res.fold(
      (l) {
        emit(FavouritesFailure(error: l));
      },
      (_) {
        final currentState = state;
      if (currentState is FavouritesStateSuccess) {
        final updatedList = currentState.result
            .where((existingRepo) => existingRepo.id != repo.id)
            .toList();

        emit(FavouritesStateSuccess(result: updatedList));
      }
      },
    );
  }
}
