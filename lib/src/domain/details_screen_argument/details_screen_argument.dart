
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_repository_project/src/data/models/github_repo_model.dart';

part 'details_screen_argument.freezed.dart';

@freezed
abstract class DetailsScreenArgument with _$DetailsScreenArgument{
  const factory DetailsScreenArgument(final GithubRepoModel repository) = _DetailsScreenArgument;
}