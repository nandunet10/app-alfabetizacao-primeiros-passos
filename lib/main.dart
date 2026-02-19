import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const AlfabetizacaoApp());
}

class AlfabetizacaoApp extends StatelessWidget {
  const AlfabetizacaoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alfabetização Infantil',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

// ======================
// TELA INICIAL
// ======================

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: AppBar(
        title: const Text('Aprender Brincando'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            textStyle: const TextStyle(fontSize: 24),
          ),
          child: const Text("Aprender Letras"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LetrasScreen()),
            );
          },
        ),
      ),
    );
  }
}

// ======================
// TELA LETRAS
// ======================

class LetrasScreen extends StatefulWidget {
  const LetrasScreen({super.key});

  @override
  State<LetrasScreen> createState() => LetrasScreenState();
}

class LetrasScreenState extends State<LetrasScreen>
    with TickerProviderStateMixin {
  final List<Map<String, String>> letras = [
    {'letra': 'A', 'imagem': 'abelha.png'},
    {'letra': 'B', 'imagem': 'bola.png'},
    {'letra': 'C', 'imagem': 'cachorro.png'},
    {'letra': 'D', 'imagem': 'dado.png'},
  ];

  int indiceAtual = 0;
  final AudioPlayer player = AudioPlayer();

  late AnimationController _letraController;
  late Animation<double> _letraAnimation;

  late AnimationController _backgroundController;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    // Animação da letra
    _letraController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _letraAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(_letraController);

    // Animação do fundo
    _backgroundController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: Colors.orange[100],
      end: Colors.pink[100],
    ).animate(_backgroundController);

    tocarLetra();
  }

  void proximaLetra() {
    setState(() {
      if (indiceAtual < letras.length - 1) {
        indiceAtual++;
      } else {
        indiceAtual = 0;
      }
    });

    tocarLetra();
  }

  void tocarLetra() async {
    String letra = letras[indiceAtual]['letra']!;
    await player.play(AssetSource('audios/$letra.mp3'));

    _letraController.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    _letraController.reverse();
  }

  @override
  void dispose() {
    _letraController.dispose();
    _backgroundController.dispose();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String letra = letras[indiceAtual]['letra']!;
    String imagem = letras[indiceAtual]['imagem']!;

    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: _colorAnimation.value,
          appBar: AppBar(
            title: const Text('Aprendendo Letras'),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // IMAGEM
                Image.asset('assets/images/$imagem', height: 180),

                const SizedBox(height: 30),

                // LETRA ANIMADA
                AnimatedBuilder(
                  animation: _letraAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _letraAnimation.value,
                      child: Text(
                        letra,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 150,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 40),

                ElevatedButton.icon(
                  onPressed: tocarLetra,
                  icon: const Icon(Icons.volume_up),
                  label: const Text("Ouvir"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: proximaLetra,
                  child: const Text("Próxima"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
