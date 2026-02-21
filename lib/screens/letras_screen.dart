import 'package:alfabetizacao_app/models/letra_model.dart';
import 'package:alfabetizacao_app/services/letras_service.dart';
import 'package:alfabetizacao_app/utils/audio_util.dart';
import 'package:alfabetizacao_app/widgets/controle_inferiores.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class LetrasScreen extends StatefulWidget {
  const LetrasScreen({super.key});

  @override
  State<LetrasScreen> createState() => _LetrasScreenState();
}

class _LetrasScreenState extends State<LetrasScreen>
    with TickerProviderStateMixin {
  final AudioPlayer player = AudioPlayer();
  LetraModel? atual;

  late AnimationController _letraController;
  late Animation<double> _letraAnimation;

  late AnimationController _backgroundController;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    LetrasService.resetar();
    atual = LetrasService.letraAtual();
    ouvir();

    // animação da letra
    _letraController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _letraAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(_letraController);

    // animação de fundo
    _backgroundController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: Colors.grey[100],
      end: Colors.brown[100],
    ).animate(_backgroundController);
  }

  Future<void> carregarLetra() async {
    final letra = LetrasService.letraAtual();
    setState(() => atual = letra);

    // tocar a letra automaticamente
    await ouvir();
  }

  Future ouvir() async {
    if (atual == null) return;
    await AudioUtil.tocarAudio(atual!.audio);
  }

  void proximo() {
    setState(() {
      atual = LetrasService.proxima();
    });
    ouvir();
  }

  void voltar() {
    setState(() {
      atual = LetrasService.anterior();
    });
    ouvir();
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
    return FutureBuilder(
      future: LetrasService.carregarLetras(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // carregar primeira letra se ainda não carregada
        if (atual == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) => carregarLetra());
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return AnimatedBuilder(
          animation: _colorAnimation,
          builder: (context, child) {
            return Scaffold(
              body: Stack(
                children: [
                  // FUNDO ANIMADO
                  Container(
                    decoration: BoxDecoration(color: _colorAnimation.value),
                    child: Opacity(
                      opacity: 0.38, // marca d'água
                      child: Image.asset(
                        'assets/images/${atual!.imagem}',
                        fit: BoxFit.contain,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),

                  // LETRA CENTRAL
                  SafeArea(
                    child: Center(
                      child: AnimatedBuilder(
                        animation: _letraAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _letraAnimation.value,
                            child: Text(
                              atual!.letra,
                              style: const TextStyle(
                                fontSize: 180,
                                fontWeight: FontWeight.w300,
                                color: Colors.blue,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // CONTROLES INFERIORES
                  ControlesInferiores(
                    onVoltar: voltar,
                    onOuvir: ouvir,
                    onProximo: proximo,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
