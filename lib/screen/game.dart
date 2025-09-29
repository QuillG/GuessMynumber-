import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _guess = 0;
  int _minGuess = 0;
  int _maxGuess = 100;
  String _message = '';
  int? _numberToGuess;

  void _checkGuess() {
    setState(() {
      if (_numberToGuess == null) {
        _message = "Génère d'abord le nombre à deviner.";
      } else if (_guess < _minGuess || _guess > _maxGuess) {
        _message = "Le nombre doit être entre $_minGuess et $_maxGuess.";
      } else if (_guess < _numberToGuess!) {
        _message = "Trop petit !";
      } else if (_guess > _numberToGuess!) {
        _message = "Trop grand !";
      } else {
        _message = "Bravo ! Tu as trouvé le nombre.";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Min',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          _minGuess = int.tryParse(value) ?? 0;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Max',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          _maxGuess = int.tryParse(value) ?? 100;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _numberToGuess = _minGuess +
                            (DateTime.now().millisecondsSinceEpoch %
                                (_maxGuess - _minGuess + 1));
                        _message = 'Nombre à deviner généré !';
                      });
                    },
                    child: const Text('Générer'),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const Text('Devine le nombre :'),
              SizedBox(
                width: 150,
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Proposition',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _guess = int.tryParse(value) ?? 0;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),
              Text(
                _message,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _checkGuess,
        tooltip: 'Vérifier',
        child: const Icon(Icons.check),
      ),
    );
  }
}
