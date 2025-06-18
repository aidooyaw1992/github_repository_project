part of 'trending_cubit.dart';

abstract class TrendingState extends Equatable {
  const TrendingState();

  @override
  List<Object?> get props => [];
}

class TrendingStateInitial extends TrendingState {
  @override
  List<Object?> get props => [];
}

class TrendingStateLoading extends TrendingState {
  @override
  List<Object?> get props => [];
}

class TrendingStateSuccess extends TrendingState {
  final List<GithubRepoModel> result;
  final PaginationInfo? pageInfo;
  final int totalCount;

  const TrendingStateSuccess({
    required this.result,
    required this.totalCount,
    this.pageInfo,
  });

  @override
  List<Object?> get props => [
    result, 
    pageInfo,
    totalCount,
  ];

  @override
  String toString() {
    return 'TrendingStateSuccess{items: ${result.length}, totalCount: $totalCount, hasMore: ${pageInfo?.nextUrl != null}}';
  }
}

class TrendingStateFailure extends TrendingState {
  final ApiError error;

  const TrendingStateFailure({required this.error});

  @override
  List<Object?> get props => [error];
}