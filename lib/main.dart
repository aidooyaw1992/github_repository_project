import 'package:flutter/material.dart';
import 'package:github_repository_project/src/app.dart';
import 'package:github_repository_project/src/data/app_repository_impl.dart';
import 'package:github_repository_project/src/data/data_sources/local_datasource.dart';
import 'package:github_repository_project/src/data/data_sources/remote_datasource.dart';
import 'src/ui/router.dart';

void main() {
  runApp(
    MyApp(
      appRepository: AppRepositoryImpl(
        api: RemoteDatasource(),
        storage: LocalDatasource(),
      ),
      appRouter: AppRouter(),
    ),
  );
}
