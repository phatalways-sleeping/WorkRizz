import 'package:flutter/material.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/repositories/repositories.dart';
import 'package:task_managing_application/screens/pdf_report_viewer/pdf_report_viewer_screen.dart';
import 'package:task_managing_application/screens/screens.dart';
import 'package:task_managing_application/screens/file_list/filelist_screen.dart';
import 'package:task_managing_application/screens/home/home_screen.dart';
import 'package:task_managing_application/states/home_bloc/home_bloc.dart';
import 'package:task_managing_application/screens/thread/thread_screen.dart';
import 'package:task_managing_application/states/message_bloc/message_bloc.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/states/subtask_create_bloc/subtask_create_bloc.dart'
    show SubtaskCreateBloc;
import 'package:task_managing_application/states/subtask_view_bloc/subtask_view_bloc.dart'
    show SubtaskViewBloc;
import 'package:firebase_core/firebase_core.dart';
import 'package:task_managing_application/states/thread_bloc/thread_bloc.dart';
import 'firebase_options.dart';
import 'screens/message/message_screen.dart';
import 'screens/chatbot/chatbot_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    RepositoryProvider(
      create: (context) => ApplicationRepository.repository,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'app',
      debugShowCheckedModeBanner: false,
      title: 'Task Managing Application',
      theme: LightTheme.theme,
      //home: ThreadScreen(),
      home: BlocProvider(
        create: (context) =>
            NavigationBloc(context.read<ApplicationRepository>()),
        child: const AppFlow(),
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
          MaterialPage(
            child: BlocProvider(
              create: (context) => SplashCubit(),
              child: const SplashScreen(),
            ),
          ),
        if (state is Authentication)
          MaterialPage(
            child: BlocProvider(
              create: (context) =>
                  AuthenticationBloc(context.read<ApplicationRepository>())
                    ..add(const AuthenticationClearEvent()),
              child: const AuthenticationScreen(),
            ),
          ),
        if (state is ProjectsList)
          MaterialPage(
            child: BlocProvider(
              create: (context) =>
                  ProjectBloc(context.read<ApplicationRepository>()),
              child: const ProjectScreen(),
            ),
          ),
        if (state is UserProjectInvitation)
          MaterialPage(
            child: BlocProvider(
              create: (context) => UserProjectInvitationBloc(
                  context.read<ApplicationRepository>()),
              child: const ProjectInvitationScreen(),
            ),
          ),
        if (state is Redirect)
          const MaterialPage(
            child: RedirectScreen(),
          ),
        if (state is TaskList)
          MaterialPage(
            child: BlocProvider(
              create: (context) => TasklistBloc(
                context.read<ApplicationRepository>(),
              ),
              child: const TaskListScreen(),
            ),
          ),
        if(state is Message) 
          MaterialPage(
            child: BlocProvider(
              create: (context) => MessageBloc(
                context.read<ApplicationRepository>(),
              )..add(const MessageSubscribeToFirestore()),
              //child: const MessageScreen(),
              child: const ChatbotScreen()
            ),
          ),
        if (state is FileList)
          MaterialPage(
            child: BlocProvider(
              create: (context) => FilelistBloc(
                context.read<ApplicationRepository>(),
              )..add(const FilelistSubscibeToStreamEvent()),
              child: const FileListScreen(),
            ),
          ),
        if (state is Thread)
          MaterialPage(
            child: BlocProvider(
              create: (context) => ThreadBloc(
                context.read<ApplicationRepository>(),
              )..add(const ThreadSubscribeEvent()),
              child: const ThreadScreen(),
            ), 
          ),
        if (state is SubTaskCreate)
          MaterialPage(
            child: BlocProvider(
              create: (context) => SubtaskCreateBloc(
                context.read<ApplicationRepository>(),
              ),
              child: const SubTaskCreateScreen(),
            ),
          ),
        if (state is SubTaskDetail)
          MaterialPage(
            child: BlocProvider(
              create: (context) => SubtaskViewBloc(
                context.read<ApplicationRepository>(),
              ),
              child: const SubTaskScreen(),
            ),
          ),
        if (state is PDFReportViewer)
          MaterialPage(
            child: PDFReportViewerScreen(
              file: state.file,
            ),
          ),
        if (state is ChangePassword)
          MaterialPage(
            child: ErrorWidget(
              'Temporarily unavailable',
            ),
          ),
        if (state is Home)
          MaterialPage(
            child: BlocProvider(
              create: (context) => HomeBloc(
                context.read<ApplicationRepository>(),
              )..add(const HomeSubscribeEvent()),
              child: const HomeScreen(),
            ),
          ),
        if (state is Assistant)
          const MaterialPage(
            child: BaseScreen(
              hideFloatingActionButton: true,
              child: SizedBox(
                height: 700,
                width: double.infinity,
              ),
            ),
          ),
        if (state is Profile)
          MaterialPage(
            child: ErrorWidget('Temporarily unavailable'),
          ),
        if (state is Settings)
          MaterialPage(
            child: ErrorWidget('Temporarily unavailable'),
          ),
      ];
}
