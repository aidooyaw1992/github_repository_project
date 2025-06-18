import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_repository_project/src/domain/details_screen_argument/details_screen_argument.dart';
import 'package:github_repository_project/src/domain/time_period.dart';
import 'package:github_repository_project/src/ui/components/custom_error_widget.dart';

import '../../domain/app_repository.dart';
import '../bloc/trending/trending_cubit.dart';
import '../components/repository_list_item.dart';

class TrendingPage extends StatelessWidget {
  const TrendingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              TrendingCubit(appRepository: context.read<AppRepository>()),
      child: TrendingView(),
    );
  }
}

class TrendingView extends StatefulWidget {
  const TrendingView({super.key});

  @override
  State<TrendingView> createState() => _TrendingViewState();
}

class _TrendingViewState extends State<TrendingView> {
  late ScrollController _scrollController;

  TimePeriod currentTimePeriod = TimePeriod.lastDay;

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      context.read<TrendingCubit>().fetchMore();
      // print("last page");
    }
  }

  @override
  void initState() {
    context.read<TrendingCubit>().fetchLatestTrendingRepos();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Trending Github Repositories ${currentTimePeriod != TimePeriod.lastDay ? "(${currentTimePeriod.displayName})" : ''}',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          PopupMenuButton<TimePeriod>(
            tooltip: "Show Trending Categories",
            popUpAnimationStyle: AnimationStyle(
              curve: Easing.emphasizedDecelerate,
              duration: Duration(milliseconds: 300),
            ),
            icon: const Icon(Icons.more_vert),
            onSelected: (TimePeriod item) {
              setState(() {
                currentTimePeriod = item;
              });
              context.read<TrendingCubit>().fetchLatestTrendingRepos(
                period: item,
              );
            },
            itemBuilder:
                (BuildContext context) => [
                  PopupMenuItem(
                    value: TimePeriod.lastDay,
                    child: ListTile(
                      leading: Icon(Icons.calendar_view_day),
                      title: Text(TimePeriod.lastDay.displayName),
                    ),
                  ),
                  PopupMenuItem(
                    value: TimePeriod.lastWeek,
                    child: ListTile(
                      leading: Icon(Icons.calendar_view_week),
                      title: Text(TimePeriod.lastWeek.displayName),
                    ),
                  ),
                  PopupMenuItem(
                    value: TimePeriod.lastMonth,
                    child: ListTile(
                      leading: Icon(Icons.calendar_view_month),
                      title: Text(TimePeriod.lastMonth.displayName),
                    ),
                  ),
                ],
          ),
        ],
      ),
      body: Container(
        height: deviceSize.height,
        width: deviceSize.width,
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: BlocBuilder<TrendingCubit, TrendingState>(
          builder: (context, state) {
            if (state is TrendingStateSuccess) {
              return RefreshIndicator(
                onRefresh:
                    () =>
                        context
                            .read<TrendingCubit>()
                            .fetchLatestTrendingRepos(),
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: state.result.length,
                  itemBuilder: (context, pos) {
                    final repository = state.result[pos];
                    return RepositoryListItem(
                      repository: repository,
                      onFavouritePressed: () {
                        if (repository.isFavouriteRepo) {
                          context.read<TrendingCubit>().removeFromFavourite(
                            repository,
                          );
                        } else {
                          context.read<TrendingCubit>().saveToFavourite(
                            repository,
                          );
                        }
                      },
                      onCardPressed:
                          () => Navigator.pushNamed(
                            context,
                            "details",
                            arguments: DetailsScreenArgument(repository),
                          ),
                    );
                  },
                ),
              );
            }
            if (state is TrendingStateFailure) {
              return Center(child: CustomErrorWidget(message: state.error.message, onRetryPressed: (){
                context.read<TrendingCubit>().fetchLatestTrendingRepos();
              },));
            }
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Loading Repositories"),
                  SizedBox.fromSize(size: Size.fromWidth(4)),
                  CircularProgressIndicator(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
