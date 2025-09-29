import 'package:flutter/material.dart';

class GameScreen extends StatefulBuilder {
  const GameScreen({super.key, required this.title, required super.builder});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('Game Screen'),
      ),
    );
  }
}
