import 'package:app/screen/game.dart';
import 'package:flutter/foundation.dart';
import 'package:fluent_ui/fluent_ui.dart';

bool get isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'Accueil',
      home: StartPage(title: "Guess My Number"),
      theme: FluentThemeData(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Example HomePage using Fluent UI widgets
class StartPage extends StatelessWidget {
  final String title;
  const StartPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: Text(title, style: FluentTheme.of(context).typography.title),
      content: Center(
        child: Button(
          child: const Text('Jouer à Guess My Number'),
          onPressed: () {
            Navigator.push(
              context,
              FluentPageRoute(
                builder: (context) => const MyHomePage(title: 'Guess My Number'),
              ),
            );
          },
        ),
      ),
    );
  }
}


