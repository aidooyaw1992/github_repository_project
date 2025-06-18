import 'package:flutter/material.dart';
import 'package:github_repository_project/src/data/models/github_repo_model.dart';
import 'package:github_repository_project/src/ui/components/profile_widget.dart';
import 'package:github_repository_project/src/ui/components/fork_count_widget.dart';
import 'package:github_repository_project/src/ui/components/language_widget.dart';
import 'package:github_repository_project/src/ui/components/repo_status.dart';
import 'package:github_repository_project/src/ui/components/star_gazer_widget.dart';

class RepositoryListItem extends StatelessWidget {
  const RepositoryListItem({
    super.key,
    required this.repository,
    this.onFavouritePressed,
    required this.onCardPressed,
  });

  final VoidCallback? onFavouritePressed;
  final VoidCallback onCardPressed;

  final GithubRepoModel repository;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardPressed,
      child: Card(
        
        elevation: 1,
        child: Container(
          constraints: BoxConstraints(minHeight: 120),
          padding: EdgeInsets.all(8),
          child: Column(
            spacing: 6,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Spacer(),
                  if (onFavouritePressed != null)
                    IconButton(
                      onPressed: onFavouritePressed,
                      icon: Icon(
                        repository.isFavouriteRepo 
                            ? Icons.favorite 
                            : Icons.favorite_outline,
                        color: repository.isFavouriteRepo 
                            ? Colors.red 
                            : Colors.grey,
                      ),
                      tooltip: repository.isFavouriteRepo 
                          ? 'Remove from favourites' 
                          : 'Add to favourites',
                    ),
                ],
              ),
              // SizedBox.fromSize(size: Size.fromHeight(8)),
              Text(
                repository.name,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16),
              ),
              // SizedBox.fromSize(size: Size.fromHeight(4)),
              Text(
                "${repository.description ?? "No Description available"}",
                style: TextStyle(fontSize: 14),
              ),
              // SizedBox.fromSize(size: Size.fromHeight(4)),
              ProfileWidget(avatarUrl: repository.owner.avatarUrl, username: repository.owner.login),
              // SizedBox.fromSize(size: Size.fromHeight(8)),
              SizedBox(
                height: 32,
                width: MediaQuery.sizeOf(context).width,
                child: Row(
                  spacing: 12,
                  children: [
                    LanguageWidget(language: repository.language, dotSize: 12),
                    StarGazerWidget(starCount: repository.stargazersCount),
                    ForkCountWidget(forkCount: repository.forksCount),
                    RepoStatus(isPrivate: repository.private),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
