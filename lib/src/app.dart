import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_repository_project/src/domain/app_repository.dart';
import 'package:github_repository_project/src/ui/router.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.appRouter,
    required this.appRepository,
  });

  final AppRouter appRouter;
  final AppRepository appRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => appRepository,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        initialRoute: 'splash',
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
