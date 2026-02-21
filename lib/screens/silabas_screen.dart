import 'dart:math';
import 'package:alfabetizacao_app/models/silaba_model.dart';
import 'package:alfabetizacao_app/services/silaba_service.dart';
import 'package:alfabetizacao_app/utils/audio_util.dart';
import 'package:alfabetizacao_app/widgets/controle_inferiores.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class SilabasScreen extends StatefulWidget {
  const SilabasScreen({super.key});

  @override
  State<SilabasScreen> createState() => _SilabasScreenState();
}

class _SilabasScreenState extends State<SilabasScreen>
    with TickerProviderStateMixin {
  final AudioPlayer player = AudioPlayer();
  SilabaModel? atual;

  List<String> selecionadas = [];
  String classificacao = '';
  Color corClassificacao = Colors.transparent;
  String pastaAudio = '';

  late AnimationController _animController;
  late Animation<double> _animScale;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animScale = Tween<double>(begin: 1.0, end: 1.2).animate(_animController);

    carregarPalavra();
  }

  Future<void> carregarPalavra() async {
    const tipos = ['monossilabas', 'dissilabas', 'trissilabas', 'polissilabas'];
    final tipoAleatorio = tipos[_random.nextInt(tipos.length)];
    final palavra = SilabasService.palavraAleatoria(tipoAleatorio);

    setState(() {
      atual = palavra;
      selecionadas.clear();
      classificar(atual!.silabas.length);
    });
  }

  void selecionar(String silaba) {
    setState(() {
      selecionadas.add(silaba);
    });
    verificar();
  }

  void verificar() async {
    if (atual == null) return;
    if (selecionadas.length == atual!.silabas.length) {
      if (selecionadas.join() == atual!.silabas.join()) {
        _animController.forward();
        await Future.delayed(const Duration(milliseconds: 100));
        _animController.reverse();

        // Toca o áudio
        await ouvir();
      }
      await Future.delayed(const Duration(milliseconds: 300));
      setState(() => selecionadas.clear());
    }
  }

  void classificar(int quantidade) {
    if (quantidade == 1) {
      classificacao = '🟢 Monossílaba';
      corClassificacao = Colors.green;
      pastaAudio = 'monossilabas';
    } else if (quantidade == 2) {
      classificacao = '🟡 Dissílaba';
      corClassificacao = Colors.orange;
      pastaAudio = 'dissilabas';
    } else if (quantidade == 3) {
      classificacao = '🔵 Trissílaba';
      corClassificacao = Colors.blue;
      pastaAudio = 'trissilabas';
    } else {
      classificacao = '🟣 Polissílaba';
      corClassificacao = Colors.purple;
      pastaAudio = 'polissilabas';
    }
  }

  void proximo() => carregarPalavra();

  Future ouvir() async {
    if (atual == null) return;
    await AudioUtil.tocarAudio(atual!.audio);
  }

  @override
  void dispose() {
    _animController.dispose();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: atual == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                // FUNDO
                Center(
                  child: Opacity(
                    opacity: 0.38,
                    child: Container(
                      width: 220,
                      height: 220,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.blueAccent.withAlpha(38),
                          width: 3,
                        ),
                        image: DecorationImage(
                          image: AssetImage('assets/images/${atual!.imagem}'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),

                // CONTEÚDO CENTRAL
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedBuilder(
                        animation: _animScale,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _animScale.value,
                            child: Text(
                              selecionadas.join(' - '),
                              style: const TextStyle(
                                fontSize: 70,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      if (classificacao.isNotEmpty)
                        Text(
                          classificacao,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: corClassificacao,
                          ),
                        ),
                      const SizedBox(height: 40),
                      Wrap(
                        spacing: 15,
                        children: atual!.silabas.map((s) {
                          return ElevatedButton(
                            onPressed: () => selecionar(s),
                            child: Text(
                              s,
                              style: const TextStyle(fontSize: 26),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

                // BOTÕES INFERIORES
                ControlesInferiores(
                  onVoltar: () => Navigator.pop(context),
                  onOuvir: ouvir,
                  onProximo: proximo,
                ),
              ],
            ),
    );
  }
}
