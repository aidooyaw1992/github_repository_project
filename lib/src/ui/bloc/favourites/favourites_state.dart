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

  FavouritesStateSuccess({required this.result});
}

class FavouritesFailure extends FavouritesState {
  final DBError error;

  FavouritesFailure({required this.error});
}
