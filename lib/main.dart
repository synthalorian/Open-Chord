import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/explorer_screen.dart';
import 'theme/chord_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('open_chord');
  runApp(const ProviderScope(child: OpenChordApp()));
}

class OpenChordApp extends StatelessWidget {
  const OpenChordApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpenChord',
      debugShowCheckedModeBanner: false,
      theme: ChordTheme.darkTheme,
      home: const ExplorerScreen(),
    );
  }
}
