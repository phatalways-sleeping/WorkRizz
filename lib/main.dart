import 'package:flutter/material.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:task_managing_application/repositories/repositories.dart';
import 'package:task_managing_application/states/states.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
          create: (context) => const AuthenticationRepository(),
        ),
        RepositoryProvider<StorageRepository>(
          create: (context) => const StorageRepository(),
        ),
      ],
      child: MaterialApp(
        title: 'Task Managing Application',
        home: BlocProvider(
          create: (context) => NavigationBloc(),
          child: const AppFlow(),
        ),
      ),
    );
  }
}

class AppFlow extends StatelessWidget {
  const AppFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return FlowBuilder(
      state: context.watch<NavigationBloc>().state,
      onGeneratePages: onGeneratePages,
    );
  }

  List<Page<dynamic>> onGeneratePages(
          NavigationState state, List<Page> pages) =>
      [
        if (state is Splash)
          MaterialPage(child: ErrorWidget('Temporarily unavailable')),
        if (state is Login)
          MaterialPage(child: ErrorWidget('Temporarily unavailable')),
        if (state is SignUp)
          MaterialPage(child: ErrorWidget('Temporarily unavailable')),
        if (state is ForgotPassword)
          MaterialPage(child: ErrorWidget('Temporarily unavailable')),
        if (state is ChangePassword)
          MaterialPage(child: ErrorWidget('Temporarily unavailable')),
        if (state is Home)
          MaterialPage(child: ErrorWidget('Temporarily unavailable')),
        if (state is Profile)
          MaterialPage(child: ErrorWidget('Temporarily unavailable')),
        if (state is Settings)
          MaterialPage(child: ErrorWidget('Temporarily unavailable')),
        if (state is Dashboard)
          MaterialPage(child: ErrorWidget('Temporarily unavailable')),
      ];
}
