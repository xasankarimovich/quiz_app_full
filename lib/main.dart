import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/views/screens/home_screen.dart';
import 'package:quiz_app/views/screens/login_screen.dart';

import 'controllers/quiz_controller.dart';
import 'controllers/select_controller.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => QuizController(),
        ),
        ChangeNotifierProvider(
          create: (context) => SelectController(),
        ),
      ],
      child: const MaterialApp(
        home: LoginScreen(),
      ),
    );
  }
}
