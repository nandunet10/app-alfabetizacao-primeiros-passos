import 'package:flutter/material.dart';

class ControlesInferiores extends StatelessWidget {
  final VoidCallback onVoltar;
  final VoidCallback onOuvir;
  final VoidCallback onProximo;

  const ControlesInferiores({
    super.key,
    required this.onVoltar,
    required this.onOuvir,
    required this.onProximo,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      left: 20,
      right: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, size: 40),
            onPressed: onVoltar,
          ),
          IconButton(
            icon: const Icon(Icons.volume_up, size: 40),
            onPressed: onOuvir,
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward, size: 40),
            onPressed: onProximo,
          ),
        ],
      ),
    );
  }
}
