part of 'favourites_cubit.dart';

abstract class FavouritesState extends Equatable {
  const FavouritesState();

  @override
  List<Object?> get props => [];
}

class FavouritesStateInitial extends FavouritesState {}

class FavouritesStateLoading extends FavouritesState {}

class FavouritesStateSuccess extends FavouritesState {
  final List<GithubRepoModel> result;

  const FavouritesStateSuccess({required this.result});
  @override
  List<Object?> get props => [result];
}

class FavouritesFailure extends FavouritesState {
  final DBError error;

  const FavouritesFailure({required this.error});
}
