import 'package:flutter/material.dart';
import 'letras_screen.dart';
import 'silabas_screen.dart';
import 'palavras_screen.dart';
import 'jogos_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const sizeBox = SizedBox(height: 20);

    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: AppBar(
        title: const Text("Aprender Brincando"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton(context, "🔤 Letras", const LetrasScreen()),
            sizeBox,

            _buildButton(context, "🧩 Sílabas", const SilabasScreen()),
            sizeBox,

            _buildButton(context, "📖 Palavras", const PalavrasScreen()),
            sizeBox,

            _buildButton(context, "🎮 Jogos", const JogosScreen()),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, Widget screen) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 18),
          textStyle: const TextStyle(fontSize: 22),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
        },
        child: Text(text),
      ),
    );
  }
}
