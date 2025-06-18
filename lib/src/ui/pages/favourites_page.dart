import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_repository_project/src/domain/app_repository.dart';
import 'package:github_repository_project/src/domain/details_screen_argument/details_screen_argument.dart';
import 'package:github_repository_project/src/ui/bloc/favourites/favourites_cubit.dart';

import '../components/repository_list_item.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              FavouritesCubit(appRepository: context.read<AppRepository>()),
      child: FavouritesView(),
    );
  }
}

class FavouritesView extends StatefulWidget {
  const FavouritesView({super.key});

  @override
  State<FavouritesView> createState() => _FavouritesViewState();
}

class _FavouritesViewState extends State<FavouritesView> {
  @override
  void initState() {
    context.read<FavouritesCubit>().retrieveStoredFavouriteRepos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite Github Repositories'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed:
                () =>
                    context
                        .read<FavouritesCubit>()
                        .retrieveStoredFavouriteRepos(),
          ),
        ],
      ),

      body: BlocListener<FavouritesCubit, FavouritesState>(
        listener: (context, state) {
          if (state is FavouritesFailure) {
            showToast(context, state.error.message);
          }
        },
        child: Container(
          height: deviceSize.height,
          width: deviceSize.width,
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: BlocBuilder<FavouritesCubit, FavouritesState>(
            builder: (context, state) {
              if (state is FavouritesStateSuccess) {
                if (state.result.isEmpty) {
                  return Center(child: Text("No Favourites Available"));
                }
                return RefreshIndicator(
                  onRefresh:
                      () =>
                          context
                              .read<FavouritesCubit>()
                              .retrieveStoredFavouriteRepos(),
                  child: ListView.builder(
                    itemCount: state.result.length,
                    itemBuilder: (context, pos) {
                      final repository = state.result[pos];
                      return RepositoryListItem(
                        repository: repository,
                        onCardPressed:
                            () => Navigator.pushNamed(
                              context,
                              'details',
                              arguments: DetailsScreenArgument(repository),
                            ),
                        onDeleteCardPressed: () {
                          context.read<FavouritesCubit>().deleteFavouriteRepo(
                            repository,
                          );
                        },
                      );
                    },
                  ),
                );
              } else if (state is FavouritesStateLoading) {
                return Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Loading Saved Repositories"),
                      SizedBox.fromSize(size: Size.fromWidth(4)),
                      CircularProgressIndicator(),
                    ],
                  ),
                );
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  void showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red[700],
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
