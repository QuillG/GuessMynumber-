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
  bool _showAnswer = false;

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

  void _generateNumber() {
    setState(() {
      _numberToGuess =
          _minGuess + (DateTime.now().millisecondsSinceEpoch % (_maxGuess - _minGuess + 1));
      _message = 'Nombre à deviner généré !';
      _showAnswer = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 187, 187, 187),
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                margin: const EdgeInsets.all(16),
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        "Générer un nombre aléatoire",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 100,
                            child: TextField(
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
                              onChanged: (value) {
                                setState(() {
                                  _maxGuess = int.tryParse(value) ?? 100;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          FilledButton.icon(
                            onPressed: _generateNumber,
                            label: const Text('Générer', style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        "Devine le nombre",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
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
                      FilledButton.icon(
                        onPressed: _checkGuess,
                        icon: const Icon(Icons.check, color: Colors.white),
                        label: const Text("Vérifier", style: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _message,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      if (_numberToGuess != null)
                        FilledButton.icon(
                          onPressed: () {
                            setState(() {
                              _showAnswer = !_showAnswer;
                            });
                          },
                          icon: const Icon(Icons.visibility, color: Colors.white),
                          label: Text(_showAnswer ? "Masquer la réponse" : "Voir la réponse", style: TextStyle(color: Colors.white)),
                        ),
                      if (_showAnswer && _numberToGuess != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            "Le nombre était : $_numberToGuess",
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
