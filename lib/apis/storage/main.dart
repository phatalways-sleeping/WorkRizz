import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:task_managing_application/firebase_options.dart';

const String path = 'lib/assets/models/';
Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
