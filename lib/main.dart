import 'package:flutter/material.dart';
import 'package:notes_pro/screens/home_screen.dart';
import 'package:notes_pro/services/local_notes_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotesRepository.initialize();
  runApp(const NotesProApp());
}

class NotesProApp extends StatelessWidget {
  const NotesProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
