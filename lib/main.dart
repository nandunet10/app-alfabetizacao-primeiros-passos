import 'package:alfabetizacao_app/services/letras_service.dart';
import 'package:alfabetizacao_app/services/silaba_service.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await SilabasService.carregarSilabas();
    await LetrasService.carregarLetras();
  } catch (e) {
    debugPrint("Erro ao carregar dados: $e");
  }

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
