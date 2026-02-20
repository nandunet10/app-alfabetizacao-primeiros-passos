import 'package:flutter/material.dart';

class PalavrasScreen extends StatelessWidget {
  const PalavrasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Palavras")),
      body: const Center(
        child: Text(
          "Módulo de Palavras em construção 📖",
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
